package com.edu.springboot.reserve;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.HoursDTO;
import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReserveController {
	
	@Autowired
	IReserveService reserveDAO;
	
	@Autowired
	IMemberService memberDAO;
	
	// 예약 진행 페이지로 이동
	@GetMapping("/reserve/proceed.do")
	public String proceedGet(Model model, HttpSession session, ReserveDTO reserveDTO) {
		// 예약할 병원: 기본정보 
		MemberDTO hospitalInfo  = reserveDAO.getHospital(reserveDTO);
		model.addAttribute("hospitalInfo", hospitalInfo);
		
		// 예약할 병원: 영업시간정보
		List<HoursDTO> hoursInfo = memberDAO.selectHospHours(hospitalInfo.getId());
		String[] weeks = new String[hoursInfo.size()];
		for (int i = 0; i < hoursInfo.size(); i++) {
		    HoursDTO hour = hoursInfo.get(i);
		    weeks[i] = hour.getWeek(); 
		}
		
		// js 배열로 사용하기 위한 작업
		String week = "";
		for(int i=0; i<weeks.length; i++) {
		if(i==0) 
			week += "'"+weeks[i]+"'";
		else 
			week += ",'"+weeks[i]+"'";
		}
		model.addAttribute("hoursInfo", hoursInfo.get(0));
		model.addAttribute("week", week);
		
		// 예약할 병원: 예약불가 시간
		// 해당하는 병원의 예약이 있는 시간
		List<ReserveDTO> closeTime = reserveDAO.getReservationInfo(null, hospitalInfo.getId());
		model.addAttribute("closeTime", closeTime);
		
		// 예약할 병원: 의사정보 
		List<DoctorDTO> doctorInfo = reserveDAO.getDoctor(hospitalInfo.getId());
		model.addAttribute("doctorInfo", doctorInfo);
//		
		// 예약하는 개인회원 정보
		MemberDTO userInfo = memberDAO.loginMember((String)session.getAttribute("userId"),(String)session.getAttribute("userPassword"));
		model.addAttribute("userInfo", userInfo);
		
		return "reserve/proceed";
	}
	
	// 예약하기
	@PostMapping("/reserve/proceed.do")
	public String proceedPost(Model model, ReserveDTO reserveDTO) {
		// 예약정보 저장
		int reserveResult = reserveDAO.saveReservationInfo(reserveDTO);
		
		if(reserveResult ==1) {
			// 예약에 성공하면
			model.addAttribute("reserveDTO", reserveDTO);
			return "reserve/complete";
		} else {
			// 예약에 실패하면
			return "reserve/error";
		}
	}

	// 예약 목록 페이지로 이동
	@GetMapping("/reserve.do")
	public String reserveGet(Model model, HttpSession session) {
		List<ReserveDTO> reserveInfo;
		
		// 로그인 한 유저의 예약 목록 
		if(session.getAttribute("userAuth").equals("ROLE_USER")) {
			reserveInfo = reserveDAO.getReservationInfo((String)session.getAttribute("userId"), null);
		}
		else {
			reserveInfo = reserveDAO.getReservationInfo(null, (String)session.getAttribute("userId"));
		}
		model.addAttribute("reserveInfo", reserveInfo);
		
		
		return "reserve/list"; 
	}

	// 예약 추가정보(메모) 
	@GetMapping("/reserve/extraInfo.do")
	public String extraInfoGet(Model model, HttpSession session, ReserveDTO reserveDTO) {
		ReserveDTO reserveDetail = reserveDAO.getReservationDetails(reserveDTO.getApp_id());
		model.addAttribute("reserveDetail", reserveDetail);
		
		return "reserve/extraInfo";
	}
	@PostMapping("/reserve/extraInfo.do")
	public String extraInfoPost(Model model, HttpSession session, ReserveDTO reserveDTO) {
		// user 메모 추가
		if(session.getAttribute("userAuth").equals("ROLE_USER")) {
			reserveDAO.updateReservationDetails(reserveDTO.getApp_id(), reserveDTO.getUser_memo(), null);
		}
		// hosp 메모추가
		else {
			reserveDAO.updateReservationDetails(reserveDTO.getApp_id(), null, reserveDTO.getHosp_memo());
		}
		
		return "redirect:/reserve.do";
	}
	
	// 예약 취소하기
	@PostMapping("/reserve/cancel.do")
	public String cancel(Model model, HttpSession session, ReserveDTO reserveDTO) {
		reserveDAO.cancelReservation(reserveDTO);
		
		return "redirect:/reserve.do";
	}
	
	// 예약 내역 숨김 (user)
	@GetMapping("/reserve/delete.do")
	public String delete(ReserveDTO reserveDTO) {
		reserveDAO.hideReservation(reserveDTO);
		
		return "redirect:/reserve.do";
	}
	
	// 예약 시간 설정
	@GetMapping("/reserve/setTime.do")
	public String setTimeGet(Model model, HttpSession session, ReserveDTO reserveDTO, MemberDTO memberDTO) {
		
		// ************* 수정 예정 *************
		memberDTO.setId((String)session.getAttribute("userId"));
		// 병원 기본 정보
		MemberDTO hospitalInfo  = reserveDAO.getMyHospital(memberDTO);
		model.addAttribute("hospitalInfo", hospitalInfo);
		
		// 예약할 병원: 영업시간정보
		List<HoursDTO> hoursInfo = memberDAO.selectHospHours(hospitalInfo.getId());
		String[] weeks = new String[hoursInfo.size()];
		for (int i = 0; i < hoursInfo.size(); i++) {
		    HoursDTO hour = hoursInfo.get(i);
		    weeks[i] = hour.getWeek(); 
		}
		
		// js 배열로 사용하기 위한 작업
		String week = "";
		for(int i=0; i<weeks.length; i++) {
		if(i==0) 
			week += "'"+weeks[i]+"'";
		else 
			week += ",'"+weeks[i]+"'";
		}
		
		// 예약할 병원: 예약불가 시간
		// 해당하는 병원의 예약이 있는 시간
		List<ReserveDTO> closeTime = reserveDAO.getReservationInfo(null, hospitalInfo.getId());
		
		model.addAttribute("closeTime", closeTime);
		model.addAttribute("hoursInfo", hoursInfo.get(0));
		model.addAttribute("week", week);
		System.err.println("setTiem get완료");

		return "reserve/setTime";
	}
	
	@PostMapping("/reserve/setTime.do")
	public String setTimePost(HttpServletRequest req, ReserveDTO reserveDTO) {
		System.err.println("post진입");

		String[] posttimez = req.getParameterValues("posttimez");
		
		int setCloseTime;
	    for (int i = 0; i < posttimez.length; i++) {
	    	reserveDTO.setPosttime(posttimez[i]);
	    	setCloseTime = reserveDAO.closeTime(reserveDTO);
	    }
		
	    System.err.println("post완료");
		return "redirect:/reserve/setTime.do";
	}
	
	
//	@GetMapping("/selectedDate.do")
//	@ResponseBody
//	public void selectedDate(@RequestParam("seleted_date") String seletedDate, Model model) {
//		model.addAttribute("seletedDate", seletedDate);
//	    // 처리 로직 수행 후 응답
//	}


	
	
	
	
	
}

