package com.edu.springboot.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	@Autowired
	IMemberService memberDAO;
	

	@GetMapping("/member/join.do")
	public String join() {
		return "member/join";
	}
	
//	회원가입 - user
	@GetMapping("/member/join/user.do")
	public String userJoinGet() {
		return "member/join/user";
	}
	
	@PostMapping("/member/join/user.do")
	public String userJoinPost(Model model, MemberDTO memberDTO) {
		memberDAO.joinMemer(memberDTO);
		return "redirect:../../member/login.do";
	}
	
	
//	회원가입 - 병원
	@GetMapping("/member/join/hosp.do")
	public String hospJoinGet() {
		return "member/join/hosp";
	}
	
	@PostMapping("/member/join/hosp.do")
	public String hospJoinPost(Model model, MemberDTO memberDTO) {
		memberDAO.joinMemer(memberDTO);
		return "redirect:../../member/login.do";
	}
	
// 	회원가입 -  아이디 중복 확인
    @GetMapping("/member/join/checkId.do")
    @ResponseBody
    public String checkId(@RequestParam("join_id") String joinID) {
        int checkOk = memberDAO.checkId(joinID);
        
        return String.valueOf(checkOk);
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
	public String logout() {
		return "member/logout";
	}
	
	

}
