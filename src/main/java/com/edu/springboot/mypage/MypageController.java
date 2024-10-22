package com.edu.springboot.mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.edu.springboot.board.ParameterDTO;
import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.doctor.DreviewDTO;
import com.edu.springboot.doctor.IDoctorService;
import com.edu.springboot.hospital.BasicDTO;
import com.edu.springboot.hospital.DetailDTO;
import com.edu.springboot.hospital.HashtagDTO;
import com.edu.springboot.hospital.HospitalDTO;
import com.edu.springboot.hospital.HreviewDTO;
import com.edu.springboot.hospital.IHospitalService;
import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;
import utils.PagingUtil;

@Controller
public class MypageController {
	
	// 페이지당 출력할 게시물 수
	@Value("#{mypageprops['mypage.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{mypageprops['mypage.pagesPerBlock']}")
	private int pagesPerBlock;
	
	@Autowired
	IMypageService mypageDAO;
	
	@Autowired
	IHospitalService hospitalDAO;
	
	@Autowired
	IDoctorService doctorDAO;
	
	
	// == 찜한 병원 ==
	@GetMapping("/mypage/myHosp.do")
	public String myHospGet(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response, ParameterDTO parameterDTO) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		// 병원 API 레코드 개수
		int total = mypageDAO.countMyHosp(id);
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
		// 병원 API 목록 저장
		ArrayList<HospitalDTO> hospList = mypageDAO.listMyHosp(id, start, end);
		for (HospitalDTO hospital : hospList) {
			String hospId = hospitalDAO.selectHospId(hospital.getName());
			// 입점
			if (id != null) {
				hospital.setEnter("T");
				hospital.setId(hospId);
				// 입점 병원 상세 정보
				DetailDTO detailDTO = hospitalDAO.selectDetail(id);
				if (detailDTO != null) {
					if (detailDTO.getPhoto() != null) {
						hospital.setPhoto(detailDTO.getPhoto());
					}
				}
			}
			else {
				hospital.setEnter("F");
			}
			// 기능과 관련된 정보
			int hosplikecount = hospitalDAO.countHospLike(hospital.getApi_idx());
			int reviewcount = hospitalDAO.countReview(hospital.getApi_idx());
			int scoresum = hospitalDAO.sumScore(hospital.getApi_idx());
			if (reviewcount != 0) {
				hospital.setScore(scoresum / reviewcount);
			}
			else {
				hospital.setScore(0);
			}
			hospital.setLikecount(hosplikecount);
			hospital.setReviewcount(reviewcount);
		}
		model.addAttribute("hospList", hospList);
		// 해시태그
		ArrayList<HashtagDTO> hashtagList = hospitalDAO.listHashtag();
		model.addAttribute("hashtagList", hashtagList);
		// 목록 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/mypage/myHosp.do?");
		model.addAttribute("pagingImg", pagingImg);
		
		
		return "mypage/myHosp";
	}
	
	
	// == 찜한 의사 ==
	@GetMapping("/mypage/myDoctor.do")
	public String myDoctorGet(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response, ParameterDTO parameterDTO) {
		
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		// 좋아요 한 의사의 게시글 개수
		int total = mypageDAO.countMyDoctor(id);
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
		ArrayList<DoctorDTO> doctorList = mypageDAO.listMyDoctor(id, start, end);
		for (DoctorDTO doctor : doctorList) {
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
		model.addAttribute("doctorList", doctorList);
		// 목록 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/mypage/myDoctor.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "mypage/myDoctor";
	}
	
	
	// == 작성한 리뷰 ==
	@GetMapping("/mypage/myReview.do")
	public String myReviewGet(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response, HospitalDTO hospitalDTO, DoctorDTO doctorDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		ArrayList<HreviewDTO> hreviewList = mypageDAO.listMyHreview(id);
		for (HreviewDTO hreview : hreviewList) {
			hospitalDTO.setApi_idx(hreview.getApi_ref());
			hospitalDTO = hospitalDAO.viewHospApi(hospitalDTO);
			hreview.setHosp_name(hospitalDTO.getName());
			hreview.setHosp_department(hospitalDTO.getDepartment());
		}
		// 해시태그
		ArrayList<HashtagDTO> hashtagList = hospitalDAO.listHashtag();
		model.addAttribute("hashtagList", hashtagList);
	      
		ArrayList<DreviewDTO> dreviewList = mypageDAO.listMyDreview(id);
		for (DreviewDTO dreview : dreviewList) {
			doctorDTO.setDoc_idx(dreview.getDoc_ref());
			doctorDTO = doctorDAO.viewDoctor(doctorDTO);
			dreview.setDoc_name(doctorDTO.getName());
			dreview.setHospname(doctorDTO.getHospname());
		}
		
		model.addAttribute("hreviewList", hreviewList);
		model.addAttribute("dreviewList", dreviewList);
		
		return "mypage/myReview";
	}
	
	
   	// == 병원 리뷰 수정 ==
   	@PostMapping("/mypage/editHreview.do")
   	public String editReviewPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, HreviewDTO hreviewDTO) {
   		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 댓글 수정
   		hospitalDAO.editReview(hreviewDTO);
   		
   		// 해시태그 처리
   		String hashtags = req.getParameter("hashtags");
   		if (hashtags != null && !hashtags.isEmpty()) {
   			String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
   			hospitalDAO.deleteAllReviewHashtag(hreviewDTO.getReview_idx());
   			for (String hashtag : hashtagArray) {
   				hospitalDAO.writeReviewHashtag(hreviewDTO.getReview_idx(), hashtag.trim());
   			}
   		}
   		return "redirect:../mypage/myReview.do";
   	}
	
	
   	// == 병원 리뷰 삭제 ==
   	@PostMapping("/mypage/deleteHreview.do")
   	public String deleteReviewGet(HttpServletRequest req) {
   		int review_idx = Integer.parseInt(req.getParameter("hreview_idx"));
   		hospitalDAO.deleteReview(review_idx);
   		hospitalDAO.deleteAllReply(review_idx);
   		hospitalDAO.deleteAllHospReviewLike(review_idx);
   		return "redirect:../mypage/myReview.do";
   	}
   	
   	
	// == 의사 리뷰 수정 ==
	@PostMapping("/mypage/editDreview.do")
	public String editReviewPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, DreviewDTO dreviewDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 댓글 수정
      	doctorDAO.editReview(dreviewDTO);
      	
      	// 해시태그 처리
      	String hashtags = req.getParameter("hashtags");
      	if (hashtags != null && !hashtags.isEmpty()) {
      		String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
      		doctorDAO.deleteAllReviewHashtag(dreviewDTO.getReview_idx());
      		for (String hashtag : hashtagArray) {
      			doctorDAO.writeReviewHashtag(dreviewDTO.getReview_idx(), hashtag.trim());
      		}
      	}
      	return "redirect:../mypage/myReview.do";
	}

	
	// == 의사 리뷰 삭제 ==
	@PostMapping("/mypage/deleteDreview.do")
	public String deleteReviewGet(HttpSession session, HttpServletRequest req, HttpServletResponse  response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		int review_idx = Integer.parseInt(req.getParameter("dreview_idx"));
		doctorDAO.deleteReview(review_idx);
		doctorDAO.deleteAllReply(review_idx);
		doctorDAO.deleteAllReviewLike(review_idx);
		return "redirect:../mypage/myReview.do";
	}

}
