package com.edu.springboot.hospital;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.edu.springboot.board.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import utils.PagingUtil;

@Controller
public class HospitalController {
	
	@Autowired
	IHospitalService hospitalDAO;
	
	// 페이지당 출력할 레코드 수
	@Value("#{hospitalprops['hospital.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{hospitalprops['hospital.pagesPerBlock']}")
	private int pagesPerBlock;

	@GetMapping("/hospital.do")
	public String hospital(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		// 의사 API 레코드 개수
		int total = hospitalDAO.countHospApi(parameterDTO);
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
		// 의사 API 목록 저장
		ArrayList<HospitalDTO> hospList = hospitalDAO.listHospApi(parameterDTO);
			for (HospitalDTO hospital : hospList) {
			String id = hospitalDAO.selectHospId(hospital.getName());
			// 입점
			if (id != null) {
				hospital.setEnter("T");
				hospital.setId(id);
				// 입점 병원 기본 정보
				BasicDTO basicDTO = hospitalDAO.viewHosp(id);
				hospital.setNickname(basicDTO.getNickname());
				hospital.setPassword(basicDTO.getPassword());
				hospital.setNickname(basicDTO.getNickname());
				hospital.setTaxid(basicDTO.getTaxid());
				// 입점 병원 상세 정보
				DetailDTO detailDTO = hospitalDAO.selectDetail(id);
				if (detailDTO != null) {
					if (detailDTO.getPhoto() != null) {
						hospital.setPhoto(detailDTO.getPhoto());
					}
					if (detailDTO.getIntroduce() != null) {
						hospital.setIntroduce(detailDTO.getIntroduce());
					}
					if (detailDTO.getParking() != null) {
						hospital.setParking(detailDTO.getParking());
					}
					if (detailDTO.getPcr() != null) {
						hospital.setPcr(detailDTO.getPcr());
					}
					if (detailDTO.getHospitalize() != null) {
						hospital.setHospitalize(detailDTO.getHospitalize());
					}
					if (detailDTO.getSystem() != null) {
						hospital.setSystem(detailDTO.getSystem());
					}
				}
				// 기능과 관련된 정보
				int hosplikecount = hospitalDAO.countHospLike(id);
				int reviewcount = hospitalDAO.countReview(id);
				int scoresum = hospitalDAO.sumScore(id);
				if (reviewcount != 0) {
					hospital.setScore(scoresum / reviewcount);
				}
				else {
					hospital.setScore(0);
				}
				hospital.setLikecount(hosplikecount);
				hospital.setReviewcount(reviewcount);
			}
			// 미입점
			else {
				hospital.setEnter("F");
			}
		}
		model.addAttribute("hospList", hospList);
		// 해시태그
		ArrayList<HashtagDTO> hashtagList = hospitalDAO.listHashtag();
		model.addAttribute("hashtagList", hashtagList);
		// 목록 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/hospital.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "hospital/list";
	}
	
	@RequestMapping("/hospital/viewHosp.do")
	public String viewHospReq(Model model, HttpSession session, HttpServletRequest req, HospitalDTO hospitalDTO) {
		String loginId = (String) session.getAttribute("userId");
		// 병원 API 정보
		hospitalDTO = hospitalDAO.viewHospApi(hospitalDTO);
		String hospId = hospitalDAO.selectHospId(hospitalDTO.getName());
		if (hospId != null) {
			hospitalDTO.setEnter("T");
			hospitalDTO.setId(hospId);
			// 입점 병원 기본 정보
			BasicDTO basicDTO = hospitalDAO.viewHosp(hospId);
			hospitalDTO.setNickname(basicDTO.getNickname());
			hospitalDTO.setPassword(basicDTO.getPassword());
			hospitalDTO.setNickname(basicDTO.getNickname());
			hospitalDTO.setTaxid(basicDTO.getTaxid());
			// 입점 병원 상세 정보
			DetailDTO detailDTO = hospitalDAO.selectDetail(hospId);
			if (detailDTO != null) {
				if (detailDTO.getPhoto() != null) {
					hospitalDTO.setPhoto(detailDTO.getPhoto());
				}
				if (detailDTO.getIntroduce() != null) {
					hospitalDTO.setIntroduce(detailDTO.getIntroduce());
				}
				if (detailDTO.getParking() != null) {
					hospitalDTO.setParking(detailDTO.getParking());
				}
				if (detailDTO.getPcr() != null) {
					hospitalDTO.setPcr(detailDTO.getPcr());
				}
				if (detailDTO.getHospitalize() != null) {
					hospitalDTO.setHospitalize(detailDTO.getHospitalize());
				}
				if (detailDTO.getSystem() != null) {
					hospitalDTO.setSystem(detailDTO.getSystem());
				}
			}
			// 병원 좋아요 수
			int likecount = hospitalDAO.countHospLike(hospId);
			hospitalDTO.setLikecount(likecount);
			// 병원 좋아요 클릭 여부
			int hosplikecheck = hospitalDAO.checkHospLike(loginId, hospId);
			model.addAttribute("hosplikecheck", hosplikecheck);
			// 리뷰 처리
			ArrayList<HreviewDTO> reviewList = hospitalDAO.listReview(hospitalDTO);
			for (HreviewDTO review : reviewList) {
				// 리뷰 작성자 닉네임
				String nickname = hospitalDAO.selectReviewNickname(review);
				review.setNickname(nickname);
				// 리뷰 좋아요 수
				likecount = hospitalDAO.countReviewLike(Integer.toString(review.getReview_idx()));
				review.setLikecount(likecount);
				// 리뷰 좋아요 클릭 여부
				int reviewlikecheck = hospitalDAO.checkReviewLike(loginId, Integer.toString(review.getReview_idx()));
				model.addAttribute("reviewlikecheck", reviewlikecheck);
			}
		}
		model.addAttribute("hospitalDTO", hospitalDTO);
		return "hospital/view";
	}
	
	
	
	
	
	
	
	
	
	@PostMapping("/hospital.writeReview.do")
	public String writeReviewPost(HttpServletRequest req, HttpSession session) {
		// 폼값
		int api_idx = Integer.parseInt(req.getParameter("api_idx"));
		int score = Integer.parseInt(req.getParameter("score"));
		String content = req.getParameter("content");
		int cost = 0;
		if (req.getParameter("cost") != null) {
			cost = Integer.parseInt(req.getParameter("cost"));
		}
		String treat = req.getParameter("treat");
		String purpose = req.getParameter("purpose");
		String doctor = req.getParameter("doctor");
		// 세션에 저장된 로그인 아이디
		String loginId = (String) session.getAttribute("userId");
		// 리뷰 작성
		hospitalDAO.writeReview(score, content, cost, treat, purpose, doctor, loginId, api_idx);
		return "redirect:../hospital/viewHosp.do?api_idx=" + api_idx;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
