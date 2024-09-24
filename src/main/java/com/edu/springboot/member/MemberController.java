package com.edu.springboot.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	@Autowired
	IMemberService memberDAO;
	
//	회원가입: 공통
	@GetMapping("/member/join.do")
	public String join() {
		return "member/join";
	}
	
//	회원가입: user 
	@GetMapping("/member/join/user.do")
	public String userJoinGet() {
		return "member/join/user";
	}
	
	@PostMapping("/member/join/user.do")
	public String userJoinPost(MemberDTO memberDTO) {
		memberDAO.userJoin(memberDTO);
		return "redirect:../../member/login.do";
	}
	
//	회원가입: 병원
	@GetMapping("/member/join/hosp.do")
	public String hospJoinGet() {
		return "member/join/hosp";
	}
	
	@PostMapping("/member/join/hosp.do")
	public String hospJoinPost(MemberDTO memberDTO, DoctorDTO doctorDTO, HoursDTO hoursDTO) {
		int memberResult = memberDAO.joinMember(memberDTO);
	    System.out.println("joinMember완료");
	    int doctorResult = memberDAO.joinDoctor(doctorDTO);
	    System.out.println("joinDoctor완료");
	    int hoursResult = memberDAO.joinHours(hoursDTO);
	    System.out.println("joinHours완료");
	    
	    // 회원가입 성공
	    if (memberResult == 1 && doctorResult == 1 && hoursResult == 1) {
	        return "redirect:../../member/login.do";
	    } else {
	    	// 회원가입 실패
	    	return "member/join/hosp";
	    }
	}
	
// 	회원가입: 아이디 중복 확인
    @GetMapping("/member/join/checkId.do")
    @ResponseBody
    public String checkId(@RequestParam("join_id") String joinID) {
        int checkOk = memberDAO.checkId(joinID);
        
        return String.valueOf(checkOk);
    }
    
// 	회원가입: 아이디 랜덤 생성
    @RequestMapping("/member/join/getNick.do")
    @ResponseBody
    public String getNick() {
    	String[] firstNick = {"촉촉한", "파닥파닥", "싱싱한", "상큼한", "야망있는", "용의주도한", "살금살금", "제멋대로", "거친 파도 속", "신출귀몰", "야생의", "시들시들한", "트렌디한", "철푸덕", "새콤달콤한", "수줍어하는", "카리스마있는", "졸렬한", "배고픈"};
    	String[] lastNick = {"열대어", "팽이버섯", "오리", "야자수", "숙주나물", "수박", "도둑", "어부", "헌터", "뽀야미", "파수꾼", "대주주", "알부자", "사천왕", "수족 냉증", "불주먹", "물주먹", "스나이퍼", "파스타", "수면핑", "농구공", "바다의 왕자"};
    	
        int firstIndex = (int) (Math.random() * firstNick.length);
        String randomFirstNick = firstNick[firstIndex];

        int lastIndex = (int) (Math.random() * lastNick.length);
        String randomLastNick = lastNick[lastIndex];

        String randomNick = randomFirstNick + " " +randomLastNick;

        return randomNick;
    }

//	로그인
	@GetMapping("/member/login.do")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/member/login.do")
	public String login(MemberDTO memberDTO, HttpSession session) {
		MemberDTO loginUser = memberDAO.loginMember(memberDTO);
		
		if(loginUser != null) {
		    session.setAttribute("userId", loginUser.getId()); 
		    session.setAttribute("userPassword", loginUser.getPassword()); 
		    session.setAttribute("userName", loginUser.getName()); 
			return "redirect:/";
		}
		else {
			return "member/login";
		}
	}
	
//	로그아웃
	@GetMapping("/member/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	

}
