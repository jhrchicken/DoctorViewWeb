package com.edu.springboot.hospital;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
				hospital.setPhoto(detailDTO.getPhoto());
				hospital.setIntroduce(detailDTO.getIntroduce());
				hospital.setParking(detailDTO.getParking());
				hospital.setPcr(detailDTO.getPcr());
				hospital.setHospitalize(detailDTO.getHospitalize());
				hospital.setSystem(detailDTO.getSystem());
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
		String hospId = hospitalDAO.selectHospId(hospitalDTO.getName());
		// 입점 병원 기본 정보
		BasicDTO basicDTO = hospitalDAO.viewHosp(hospId);
		hospitalDTO.setNickname(basicDTO.getNickname());
		hospitalDTO.setPassword(basicDTO.getPassword());
		hospitalDTO.setNickname(basicDTO.getNickname());
		hospitalDTO.setTaxid(basicDTO.getTaxid());
		// 입점 병원 상세 정보
		DetailDTO detailDTO = hospitalDAO.selectDetail(hospId);
		hospitalDTO.setPhoto(detailDTO.getPhoto());
		hospitalDTO.setIntroduce(detailDTO.getIntroduce());
		hospitalDTO.setParking(detailDTO.getParking());
		hospitalDTO.setPcr(detailDTO.getPcr());
		hospitalDTO.setHospitalize(detailDTO.getHospitalize());
		hospitalDTO.setSystem(detailDTO.getSystem());
		// 병원 좋아요 수
		int likecount = hospitalDAO.countHospLike(hospId);
		hospitalDTO.setLikecount(likecount);
		model.addAttribute("hospitalDTO", hospitalDTO);
		// 병원 좋아요 클릭 여부
		int hosplikecheck = hospitalDAO.checkHospLike(loginId, hospId);
		model.addAttribute("hosplikecheck", hosplikecheck);
		// 리뷰 처리
		ArrayList<HreviewDTO> reviewList = hospitalDAO.listReview(hospitalDTO);
		
		
		return "hospital/view";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}
