package com.edu.springboot.doctor;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.crypto.dsig.keyinfo.RetrievalMethod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.edu.springboot.board.BoardDTO;
import com.edu.springboot.board.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import utils.FileUtil;
import utils.PagingUtil;

@Controller
public class DoctorController {
	
	@Autowired
	IDoctorService doctorDAO;
	
	// 페이지당 출력할 게시물 수
	@Value("#{doctorprops['doctor.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{doctorprops['doctor.pagesPerBlock']}")
	private int pagesPerBlock;
	
	@GetMapping("/doctor.do")
	public String doctor(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		// 의사의 게시글 개수
		int total = doctorDAO.countDoctor(parameterDTO);
		// 현재 페이지
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		// 현재 페이지에 출력할 게시글의 구간 계산 및 저장
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		// 뷰에서 게시글의 가상번호 계산을 위한 값 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		// 의사의 목록 저장
		ArrayList<DoctorDTO> doctorsList = doctorDAO.listDoctor(parameterDTO);
		for (DoctorDTO doctor : doctorsList) {
			String hospname = doctorDAO.selectHospName(doctor);
			int doclikecount = doctorDAO.countDocLike(Integer.toString(doctor.getDoc_idx()));
			int reviewcount = doctorDAO.countReview(Integer.toString(doctor.getDoc_idx()));
			int scoresum = doctorDAO.sumScore(Integer.toString(doctor.getDoc_idx()));
			doctor.setHospname(hospname);
			doctor.setLikecount(doclikecount);
			doctor.setReviewcount(reviewcount);
			if (reviewcount != 0) {
				doctor.setScore(scoresum / reviewcount);
			}
			else {
				doctor.setScore(0);
			}
		}
		model.addAttribute("doctorsList", doctorsList);
		// 목록 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/doctor.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "doctor/list";
	}
	
	@RequestMapping("/doctor/viewDoctor.do")
	public String viewDoctorReq(Model model, DoctorDTO doctorDTO, HttpSession session) {
		String id = (String) session.getAttribute("userId");
		// 의사 정보 조회
		doctorDTO = doctorDAO.viewDoctor(doctorDTO);
		// 병원명
		String hospname = doctorDAO.selectHospName(doctorDTO);
		doctorDTO.setHospname(hospname);
		model.addAttribute("doctorDTO", doctorDTO);
		// 리뷰 처리
		ArrayList<DreviewDTO> reviewsList = doctorDAO.listReview(doctorDTO);
		for (DreviewDTO review : reviewsList) {
			// 리뷰 작성자 닉네임
			String nickname = doctorDAO.selectReviewNickname(review);
			review.setNickname(nickname);
			// 리뷰 좋아요 수
			int likecount = doctorDAO.countReviewLike(Integer.toString(review.getReview_idx()));
			review.setLikecount(likecount);
			// 리뷰 좋아요 클릭 여부
			int reviewlikecheck = doctorDAO.checkReviewLike(id, Integer.toString(review.getReview_idx()));
			model.addAttribute("reviewlikecheck", reviewlikecheck);
		}
		// 의사 좋아요수
		int likecount = doctorDAO.countDocLike(Integer.toString(doctorDTO.getDoc_idx()));
		doctorDTO.setLikecount(likecount);
		model.addAttribute("reviewsList", reviewsList);
		// 의사 좋아요 클릭 여부
		int doclikecheck = doctorDAO.checkDocLike(id, Integer.toString(doctorDTO.getDoc_idx()));
		model.addAttribute("doclikecheck", doclikecheck);

		return "doctor/view";
	}

	@GetMapping("/doctor/writeDoctor.do")
	public String writeDoctorGet(Model model) {
		return "doctor/write";
	}
	@PostMapping("/doctor/writeDoctor.do")
	public String writeDoctorPost(HttpSession session, HttpServletRequest req, DoctorDTO doctorDTO) {
		// 파일업로드
		try {
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
			Part part = req.getPart("file");
			String partHeader = part.getHeader("content-disposition");
			String[] phArr = partHeader.split("filename=");
			String filename = phArr[1].trim().replace("\"", "");
			if (!filename.isEmpty()) {
				part.write(uploadDir + File.separator + filename);
				String photo = FileUtil.renameFile(uploadDir, filename);
				doctorDTO.setPhoto(photo);
			}
			else {
				doctorDTO.setPhoto("NULL");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		// 세션에 저장된 로그인 아이디
		String id = (String) session.getAttribute("userId");
		doctorDTO.setHosp_ref(id);
		doctorDAO.writeDoctor(doctorDTO);
		return "redirect:../doctor.do";
	}
	
	@GetMapping("/doctor/editDoctor.do")
	public String editDoctorGet(HttpServletRequest req, Model model, DoctorDTO doctorDTO) {
		doctorDTO = doctorDAO.viewDoctor(doctorDTO);
		model.addAttribute("doctorDTO", doctorDTO);
		return "doctor/edit";
	}
	@PostMapping("/doctor/editDoctor.do")
	public String editDoctorPost(HttpServletRequest req, DoctorDTO doctorDTO) {
		// 파일업로드
		try {
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
			Part part = req.getPart("file");
			String partHeader = part.getHeader("content-disposition");
			String[] phArr = partHeader.split("filename=");
			String filename = phArr[1].trim().replace("\"", "");
			if (!filename.isEmpty()) {
				part.write(uploadDir + File.separator + filename);
				String photo = FileUtil.renameFile(uploadDir, filename);
				doctorDTO.setPhoto(photo);
			}
			else {
				doctorDTO.setPhoto("NULL");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		doctorDAO.editDoctor(doctorDTO);
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doctorDTO.getDoc_idx();
	}
	
	@PostMapping("/doctor/deleteDoctor.do")
	public String deleteDoctorPost(HttpServletRequest req) {
		doctorDAO.deleteDoctor(req.getParameter("doc_idx"));
		/********************  요청명 마이페이지로 수정 필요 **************************/
		return "redirect:../doctor.do";
	}
	
	@GetMapping("/doctor/clickDocLike.do")
	public String clickLikeGet(HttpServletRequest req, HttpSession session) {
		// 좋아요 여부 확인
		String id = (String) session.getAttribute("userId");
		String doc_idx = req.getParameter("doc_idx");
		int likecheck = doctorDAO.checkDocLike(id, doc_idx);
		if (likecheck == 0) {
			// 좋아요 증가
			doctorDAO.plusDocLike(id, doc_idx);
		}
		else {
			// 좋아요 취소
			doctorDAO.minusDocLike(id, doc_idx);
		}
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_idx;
	}
	
	@PostMapping("/doctor/writeReview.do")
	public String writeReviewPost(HttpServletRequest req, HttpSession session) {
		// 폼값
		int doc_idx = Integer.parseInt(req.getParameter("doc_idx"));
		int score = Integer.parseInt(req.getParameter("score"));
		String content = req.getParameter("content");
		// 세션에 저장된 로그인 아이디
		String id = (String) session.getAttribute("userId");
		// 리뷰 작성
		doctorDAO.writeReview(score, content, id, doc_idx);
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_idx;
	}
	
	@PostMapping("/doctor/editReview.do")
	public String editReviewPost(HttpServletRequest req) {
		// 폼값
		int doc_ref = Integer.parseInt(req.getParameter("doc_ref"));
		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
		int score = Integer.parseInt(req.getParameter("score"));
		String content = req.getParameter("content");
		// 댓글 수정
		doctorDAO.editReview(review_idx, score, content);
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
	}
	
	@PostMapping("/doctor/deleteReview.do")
	public String deleteReviewGet(HttpServletRequest req) {
		doctorDAO.deleteReview(Integer.parseInt(req.getParameter("review_idx")));
		doctorDAO.deleteAllReply(Integer.parseInt(req.getParameter("review_idx")));
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + req.getParameter("doc_ref");
	}
	
	@GetMapping("/doctor/clickReviewLike.do")
	public String clickReviewGet(HttpServletRequest req, HttpSession session) {
		// 좋아요 여부 확인
		String id = (String) session.getAttribute("userId");
		String doc_ref = req.getParameter("doc_ref");
		String review_idx = req.getParameter("review_idx");
		int likecheck = doctorDAO.checkReviewLike(id, review_idx);
		if (likecheck == 0) {
			// 좋아요 증가
			doctorDAO.plusReviewLike(id, review_idx);
		}
		else {
			// 좋아요 취소
			doctorDAO.minusReviewLike(id, review_idx);
		}
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
	}
	
	@PostMapping("/doctor/writeReply.do")
	public String writeReplyPost(HttpServletRequest req, HttpSession session) {
		// 폼값
		int doc_ref = Integer.parseInt(req.getParameter("doc_ref"));
		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
		String content = req.getParameter("content");
		// 세션에 저장된 로그인 아이디
		String id = (String) session.getAttribute("userId");
		// 리뷰 작성
		doctorDAO.writeReply(review_idx, content, id, doc_ref);
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
	}
	
	@PostMapping("/doctor/editReply.do")
	public String editReplyPost(HttpServletRequest req) {
		// 폼값
		int doc_ref = Integer.parseInt(req.getParameter("doc_ref"));
		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
		String content = req.getParameter("content");
		// 댓글 수정
		doctorDAO.editReply(review_idx, content);
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
	}
	
	@PostMapping("/doctor/deleteReply.do")
	public String deleteReplyGet(HttpServletRequest req) {
		doctorDAO.deleteReply(Integer.parseInt(req.getParameter("review_idx")));
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + req.getParameter("doc_ref");
	}

}
