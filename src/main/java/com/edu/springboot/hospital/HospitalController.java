package com.edu.springboot.hospital;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.springboot.board.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;
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
			String id = hospitalDAO.checkEnter(hospital.getName());
			// 입점
			if (id != null) {
				hospital.setEnter("T");
				hospital.setId(id);
				hospital = hospitalDAO.viewHosp(hospital);
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
				
				// 여기서 여러가지 처리 추가 정보 있는지 등 해시태그
				
			}
			// 미입점
			if (id != null) {
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
	
	
	
	
	
	
	
	
	
	

}
