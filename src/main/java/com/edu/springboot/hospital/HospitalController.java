package com.edu.springboot.hospital;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.HoursDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;
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
		// 병원 API 레코드 개수
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
		// 병원 API 목록 저장
		ArrayList<HospitalDTO> hospList = hospitalDAO.listHospApi(parameterDTO);
		for (HospitalDTO hospital : hospList) {
			String id = hospitalDAO.selectHospId(hospital.getName());
			// 입점
			if (id != null) {
				hospital.setEnter("T");
				hospital.setId(id);
				// 입점 병원 상세 정보
				DetailDTO detailDTO = hospitalDAO.selectDetail(id);
				if (detailDTO != null) {
					if (detailDTO.getPhoto() != null) {
						hospital.setPhoto(detailDTO.getPhoto());
					}
				}
			}
			// 미입점
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
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/hospital.do?");
		model.addAttribute("pagingImg", pagingImg);
		// 동적 셀렉트 페이지로 진입시에 시도 부분은 미리 select한 후 <select> 태그에 포함
		model.addAttribute("sidoLists", hospitalDAO.selectSido());
		return "hospital/list";
	}
	
	// 병원 검색 처리
    @PostMapping("/hospital/searchHosp.do")
    public ModelAndView searchHosp(HttpServletRequest req, ParameterDTO parameterDTO,
            @RequestParam(name = "searchSido", required = false) String searchSido,
            @RequestParam(name = "searchGugun", required = false) String searchGugun,
            @RequestParam(name = "searchDong", required = false) String searchDong,
            @RequestParam(name = "searchField", required = false) String searchField,
            @RequestParam(name = "searchWord", required = false) String searchWord,
            @RequestParam(name = "filters", required = false) String filters) {

    	List<String> filterArray = filters != null ? Arrays.asList(filters.split(",")) : new ArrayList<>();
    	// 병원 API 레코드 개수
    	parameterDTO.setSearchSido(searchSido);
    	parameterDTO.setSearchGugun(searchGugun);
    	parameterDTO.setSearchDong(searchDong);
    	parameterDTO.setSearchField(searchField);
    	parameterDTO.setSearchField(searchField);
    	parameterDTO.setSearchWord(searchWord);
    	parameterDTO.setFilters(filterArray);
    	int total = hospitalDAO.countSearchHosp(parameterDTO);
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
        // 필터 처리
        List<HospitalDTO> hospList = hospitalDAO.listSearchHosp(searchSido, searchGugun, searchDong, searchField, searchWord, filterArray, start, end);
        for (HospitalDTO hospital : hospList) {
			String id = hospitalDAO.selectHospId(hospital.getName());
			// 입점
			if (id != null) {
				hospital.setEnter("T");
				hospital.setId(id);
				// 입점 병원 상세 정보
				DetailDTO detailDTO = hospitalDAO.selectDetail(id);
				if (detailDTO != null) {
					if (detailDTO.getPhoto() != null) {
						hospital.setPhoto(detailDTO.getPhoto());
					}
				}
			}
			// 미입점
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
		// ModelAndView 설정
        ModelAndView mav = new ModelAndView("hospital/listPart");
        mav.addObject("hospList", hospList);
        mav.addObject("maps", maps);
		// 해시태그
		ArrayList<HashtagDTO> hashtagList = hospitalDAO.listHashtag();
		mav.addObject("hashtagList", hashtagList);
		// 목록 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/hospital.do?");
		mav.addObject("pagingImg", pagingImg);
        return mav;
    }

	// 시구군 동적 셀렉트
	@RequestMapping("/hospital/getGugun.do")
	@ResponseBody
	public Map<String, Object> address1(AddressDTO addressDTO) {
		List<AddressDTO> gugunList = hospitalDAO.selectGugun(addressDTO);
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", gugunList);
		return maps;
	}
	
	// 읍면동 동적 셀렉트
	@RequestMapping("/hospital/getDong.do")
	@ResponseBody
	public Map<String, Object> address2(AddressDTO addressDTO) {
		List<AddressDTO> dongList = hospitalDAO.selectDong(addressDTO);
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", dongList);
		return maps;
	}
	
	@RequestMapping("/hospital/viewHosp.do")
	public String viewHospReq(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response, HospitalDTO hospitalDTO) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
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
			ArrayList<DoctorDTO> doctorList = hospitalDAO.listDoctor(hospitalDTO);
			model.addAttribute("doctorList", doctorList);
			// 해시태그
			ArrayList<HashtagDTO> hospHashtagList = hospitalDAO.selectHospHashtag(hospId);
			model.addAttribute("hospHashtagList", hospHashtagList);
		}
		// 병원 좋아요 수
		int likecount = hospitalDAO.countHospLike(hospitalDTO.getApi_idx());
		hospitalDTO.setLikecount(likecount);
		// 병원 좋아요 클릭 여부
		int hosplikecheck = hospitalDAO.checkHospLike(loginId, hospitalDTO.getApi_idx());
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
		// 해시태그
		ArrayList<HashtagDTO> hashtagList = hospitalDAO.listHashtag();
		model.addAttribute("hashtagList", hashtagList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("hospitalDTO", hospitalDTO);
		return "hospital/view";
	}
	
	@PostMapping("/hospital/writeReview.do")
	public String writeReviewPost(HttpServletRequest req, HttpSession session) {
	    // 폼값
		int api_idx = Integer.parseInt(req.getParameter("api_idx"));
		int score = Integer.parseInt(req.getParameter("score"));
		String content = req.getParameter("content");
		String cost = req.getParameter("cost");
		String treat = req.getParameter("treat");
		String doctor = req.getParameter("doctor");
	    // 세션에 저장된 로그인 아이디
	    String loginId = (String) session.getAttribute("userId");
	    // 리뷰 작성
	    Map<String, Object> params = new HashMap<>();
	    params.put("score", score);
	    params.put("content", content);
	    params.put("cost", cost);
	    params.put("treat", treat);
	    params.put("doctor", doctor);
	    params.put("loginId", loginId);
	    params.put("api_idx", api_idx);
	    hospitalDAO.writeReview(params);
	    // 생성된 review_idx
	    int review_idx = (int) params.get("review_idx");  
	    // 해시태그 처리
	    String hashtags = req.getParameter("hashtags");
	    if (hashtags != null && !hashtags.isEmpty()) {
	    	String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
	    	for (String hashtag : hashtagArray) {
	    		hospitalDAO.writeReviewHashtag(review_idx, hashtag.trim());
	    	}
	    }
	    return "redirect:../hospital/viewHosp.do?api_idx=" + api_idx;
	}

	@PostMapping("/hospital/editReview.do")
	public String editReviewPost(HttpServletRequest req, HttpSession session) {
		// 폼값
		int api_ref = Integer.parseInt(req.getParameter("api_ref"));
		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
		int score = Integer.parseInt(req.getParameter("score"));
		String content = req.getParameter("content");
		String cost = req.getParameter("cost");
		String treat = req.getParameter("treat");
		String doctor = req.getParameter("doctor");
		// 리뷰 수정
		Map<String, Object> params = new HashMap<>();
	    params.put("score", score);
	    params.put("content", content);
	    params.put("cost", cost);
	    params.put("treat", treat);
	    params.put("doctor", doctor);
	    params.put("review_idx", review_idx);
	    hospitalDAO.editReview(params);
		// 해시태그 처리
	    String hashtags = req.getParameter("hashtags");
	    if (hashtags != null && !hashtags.isEmpty()) {
	    	String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
	    	hospitalDAO.deleteAllReviewHashtag(review_idx);
	    	for (String hashtag : hashtagArray) {
	    		hospitalDAO.writeReviewHashtag(review_idx, hashtag.trim());
	    	}
	    }
		return "redirect:../hospital/viewHosp.do?api_idx=" + api_ref;
	}
	
	@PostMapping("/hospital/deleteReview.do")
	public String deleteReviewGet(HttpServletRequest req) {
		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
		hospitalDAO.deleteReview(review_idx);
		hospitalDAO.deleteAllReply(review_idx);
		hospitalDAO.deleteAllLike(review_idx);
		return "redirect:../hospital/viewHosp.do?api_idx=" + req.getParameter("api_ref");
	}
	
	@PostMapping("/hospital/writeReply.do")
	public String writeReplyPost(HttpServletRequest req, HttpSession session) {
		// 폼값
		int api_ref = Integer.parseInt(req.getParameter("api_ref"));
		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
		String content = req.getParameter("content");
		// 세션에 저장된 로그인 아이디
		String id = (String) session.getAttribute("userId");
		// 답변 작성
		hospitalDAO.writeReply(review_idx, content, id, api_ref);
		return "redirect:../hospital/viewHosp.do?api_idx=" + api_ref;
	}
	
	@PostMapping("/hospital/editReply.do")
	public String editReplyPost(HttpServletRequest req) {
		// 폼값
		int api_ref = Integer.parseInt(req.getParameter("api_ref"));
		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
		String content = req.getParameter("content");
		// 답변 수정
		hospitalDAO.editReply(review_idx, content);
		return "redirect:../hospital/viewHosp.do?api_idx=" + api_ref;
	}
	
	@PostMapping("/hospital/deleteReply.do")
	public String deleteReplyGet(HttpServletRequest req) {
		hospitalDAO.deleteReply(Integer.parseInt(req.getParameter("review_idx")));
		return "redirect:../hospital/viewHosp.do?api_idx=" + req.getParameter("api_ref");
	}
	
	@GetMapping("hospital/clickHospLike.do")
	public String clickLikeGet(HttpServletRequest req, HttpSession session) {
		// 좋아요 여부 확인
		String id = (String) session.getAttribute("userId");
		String api_idx = req.getParameter("api_idx");
		int likecheck = hospitalDAO.checkHospLike(id, Integer.parseInt(api_idx));
		if (likecheck == 0) {
			// 좋아요 증가
			hospitalDAO.plusHospLike(id, Integer.parseInt(api_idx));
		}
		else {
			// 좋아요 취소
			hospitalDAO.minusHospLike(id, Integer.parseInt(api_idx));
		}
		return "redirect:../hospital/viewHosp.do?api_idx=" + api_idx;
	}
	
	@GetMapping("/hospital/clickReviewLike.do")
	public String clickReviewGet(HttpServletRequest req, HttpSession session) {
		// 좋아요 여부 확인
		String id = (String) session.getAttribute("userId");
		String api_ref = req.getParameter("api_ref");
		String review_idx = req.getParameter("review_idx");
		int likecheck = hospitalDAO.checkReviewLike(id, review_idx);
		if (likecheck == 0) {
			// 좋아요 증가
			hospitalDAO.plusReviewLike(id, review_idx);
		}
		else {
			// 좋아요 취소
			hospitalDAO.minusReviewLike(id, review_idx);
		}
		return "redirect:../hospital/viewHosp.do?api_idx=" + api_ref;
	}
	
	
	
	
	
	
	
	
	// 지도
	@GetMapping("/hospital/map.do")
	public String map(Model model, ParameterDTO parameterDTO) {
	    ArrayList<HospitalDTO> hospList = hospitalDAO.listHospMark(parameterDTO);
	    Date date = new Date();
	    SimpleDateFormat dayFormat = new SimpleDateFormat("EEEE");
	    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
	    String currentDay = dayFormat.format(date);
	    String currentTime = timeFormat.format(date);
	    // 운영여부/야간진료/주말진료
	    for (HospitalDTO hospital : hospList) {
	        String id = hospitalDAO.selectHospId(hospital.getName());
	        hospital.setOpen("F");
	        hospital.setNight("F");
	        hospital.setWeekend("F");
	        // 입점
	        if (id != null) {
	            hospital.setEnter("T");
	            hospital.setId(id);
	            // 입점 병원 시간 정보
	            ArrayList<HoursDTO> hoursList = hospitalDAO.selectHours(id);
	            for (HoursDTO hour : hoursList) {
	                if (hour.getWeek().equals(currentDay)) {
                        hospital.setNight(hour.getNight());
                        hospital.setWeekend(hour.getWeekend());
	                    if (currentTime.compareTo(hour.getStarttime()) > 0 && currentTime.compareTo(hour.getEndtime()) < 0) {
	                        hospital.setOpen("T");
	                    }
	                }
	            }
	        }
	        // 미입점
	        else {
	            hospital.setEnter("F");
	        }
	    }
	    model.addAttribute("hospList", hospList);
	    return "/hospital/map";
	}
	
}
