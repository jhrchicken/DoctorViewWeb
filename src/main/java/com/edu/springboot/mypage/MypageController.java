package com.edu.springboot.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {
	
//	@Autowired
//	IMemberService memberDAO;
//	@Autowired
//	EmailSending email;
	
//	마이페이지(수정하기) 진입
	@GetMapping("/mypage.do")
	public String mypage() {
		return "mypage/mypage";
	}
	
////	회원가입: user 
//	@GetMapping("/member/join/user.do")
//	public String userJoinGet() {
//		return "member/join/user";
//	}
//	
//	@PostMapping("/member/join/user.do")
//	public String userJoinPost(MemberDTO memberDTO, HttpServletRequest req, Model model) {
//		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
//		String eamil = req.getParameter("email1") + "@" + req.getParameter("email2");
//		String rrn = req.getParameter("rrn1") + "-" + req.getParameter("rrn2") + "000000";
//		
//		memberDTO.setTel(tel);
//		memberDTO.setEmail(eamil);
//		memberDTO.setRrn(rrn);
//		
//		System.out.println(memberDTO.getId());
//		System.out.println(memberDTO.getPassword());
//		System.out.println(memberDTO.getName());
//		System.out.println(memberDTO.getNickname());
//		System.out.println(memberDTO.getTel());
//		System.out.println(memberDTO.getEmail());
//		System.out.println(memberDTO.getAddress());
//		System.out.println(memberDTO.getRrn());
//		
//		
////		memberDAO.userJoin(memberDTO);
//		
//		if (memberDAO.userJoin(memberDTO) == 1) {
//			return "redirect:../../member/login.do";
//		}
//		else {
//			model.addAttribute("joinFaild", "회원가입에 실패했습니다.");
//			return "member/join/user";
//		}
//	} 
//	

}
