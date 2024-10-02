package com.edu.springboot.reserve;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.HoursDTO;
import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

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
		List<HoursDTO> hoursInfo = memberDAO.hospHours(hospitalInfo);
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
		
		// 예약할 병원: 의사정보 
		List<DoctorDTO> doctorInfo = reserveDAO.getDoctor(hospitalInfo.getId());
		model.addAttribute("doctorInfo", doctorInfo);
//		
		// 예약하는 개인회원 정보
		MemberDTO userInfo = memberDAO.userInfo((String)session.getAttribute("userId"));
		model.addAttribute("userInfo", userInfo);
		
		return "reserve/proceed";
	}
	
	// 예약하기
	@PostMapping("/reserve/proceed.do")
	public String proceedPost(ReserveDTO reserveDTO) {
		// 예약정보 저장
		int reserveResult = reserveDAO.saveReservationInfo(reserveDTO);
		
		if(reserveResult ==1) {
			// 예약에 성공하면
			return "reserve/complete";
		} else {
			// 예약에 실패하면
			return "reserve/error";
		}
	}

	// 예약 관리 페이지로 이동
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
	
	
	
}
