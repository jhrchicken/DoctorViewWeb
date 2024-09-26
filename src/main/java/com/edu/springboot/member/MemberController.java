package com.edu.springboot.member;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CookieManager;

@Controller
public class MemberController {
	
	@Autowired
	IMemberService memberDAO;
	@Autowired
	EmailSending email;
	
//	회원가입: 진입
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
	public String userJoinPost(MemberDTO memberDTO, HttpServletRequest req, Model model) {
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String eamil = req.getParameter("email1") + "@" + req.getParameter("email2");
		String rrn = req.getParameter("rrn1") + "-" + req.getParameter("rrn2") + "000000";
		
		memberDTO.setTel(tel);
		memberDTO.setEmail(eamil);
		memberDTO.setRrn(rrn);
		
		memberDAO.userJoin(memberDTO);
		
		if (memberDAO.userJoin(memberDTO) == 1) {
			return "redirect:/member/login.do";
		}
		else {
			model.addAttribute("joinFaild", "회원가입에 실패했습니다.");
			return "member/join/user";
		}
	} 
	
//	회원가입: 병원
	@GetMapping("/member/join/hosp.do")
	public String hospJoinGet() {
		return "member/join/hosp";
	}
	
	@PostMapping("/member/join/hosp.do")
	public String hospJoinPost(MemberDTO memberDTO, DoctorDTO doctorDTO, HoursDTO hoursDTO, HttpServletRequest req, Model model) {
		// member
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String taxid = req.getParameter("taxid1") + "-" + req.getParameter("taxid2") + "-" + req.getParameter("taxid3");
		memberDTO.setTel(tel);
		memberDTO.setTaxid(taxid);
		int memberResult = memberDAO.joinMember(memberDTO);
	    
	    // doctor
	    String[] doctornamez = req.getParameterValues("doctornamez");
	    String[] majorz = req.getParameterValues("majorz");
	    String[] careerz = req.getParameterValues("careerz");
	    String[] hoursz = req.getParameterValues("hoursz");
	    int doctorResult = 0;
	    
	    for (int i = 0; i < doctornamez.length; i++) {
	        doctorDTO.setDoctorname(doctornamez[i]);
	        doctorDTO.setMajor(majorz[i]);
	        doctorDTO.setCareer(careerz[i]);
	        doctorDTO.setHours(hoursz[i]);
	        doctorDTO.setHosp_ref(memberDTO.getId());
	        System.out.println(doctornamez[i]);
	        System.out.println(majorz[i]);
	        System.out.println(careerz[i]);
	        System.out.println(hoursz[i]);
	        doctorResult = memberDAO.joinDoctor(doctorDTO);
	    }

	    // hours
	    String[] weeks = req.getParameterValues("weeks");
	    hoursDTO.setHosp_ref(memberDTO.getId());
	    int hoursResult = 0;
	    if (weeks != null) {
	        for (String week : weeks) {
	        	hoursDTO.setWeek(week);
	        	hoursResult = memberDAO.joinHours(hoursDTO);
	        }
	    } else {
	        System.out.println("선택된 요일이 없습니다.");
	    }
	    
	    
		// 회원가입 성공
	    if (memberResult == 1 && doctorResult == 1 && hoursResult == 1) {
//	    	회원승인이 필요하기때문에 home으로 이동
	        return "redirect:/";
	    } else {
	    	// 회원가입 실패
	    	model.addAttribute("joinFaild", "회원가입에 실패했습니다.");
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
    	String[] firstNick = {"촉촉한", "파닥파닥", "싱싱한", "상큼한", "야망있는", "살금살금", "제멋대로", "거친 파도 속", "신출귀몰한", "야생의", "시들시들한", "트렌디한", "철푸덕", "새콤달콤한", "수줍어하는", "카리스마있는", "졸렬한", "배고픈", "비열한","뒷 골목의", "불타는", "노란머리","버섯머리", "버석한", "기괴한", "더조은","용의주도한", "괴로운", "비염걸린", "눈물흘리는", "코찔찔이"};	
    	String[] lastNick = {"열대어", "팽이버섯", "오리", "야자수", "숙주나물", "수박", "도둑", "어부", "헌터", "뽀야미", "파수꾼", "대주주", "알부자", "사천왕", "수족 냉증", "불주먹", "물주먹", "스나이퍼", "파스타", "수면핑", "농구공", "바다의 왕자", "아기돼지", "김치볶음밥", "파인애플", "지하철", "회리", "하림", "다영"};
    	
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
	public String login(MemberDTO memberDTO, HttpSession session, Model model, HttpServletRequest req, HttpServletResponse resp) {
		MemberDTO loginUser = memberDAO.loginMember(memberDTO);
		String saveId = req.getParameter("save");
		
		if(loginUser != null) {
			if(loginUser.getApprove().equals("F")) {
				// 회원가입 승인 대기 처리 추가
				model.addAttribute("loginFaild", "회원승인 대기 상태입니다.");
				return "member/login";
			}
		    session.setAttribute("userId", loginUser.getId()); 
		    session.setAttribute("userPassword", loginUser.getPassword()); 
		    session.setAttribute("userName", loginUser.getName()); 
		    
		    // 아이디 저장버튼이 눌렸다면 로그아웃을 해도 다음 로그인 시 아이디가 표시됨
            if(req.getParameter("saveId") != null) {
            	CookieManager.makeCookie(resp, "savdId", memberDTO.getId(), 86400);
            } else {
            	CookieManager.deleteCookie(resp, "savdId");
            }
		    
		    return "redirect:/";
		}
		else {
			model.addAttribute("loginFaild", "아이디 혹은 비밀번호가 일치하지않습니다.");
			return "member/login";
		}
	}
	
//	로그아웃
	@GetMapping("/member/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
//	아이디찾기
	@GetMapping("/member/findId.do")
	public String findIdGet() {
		return "member/findId";
	}
	
	@PostMapping("/member/findId.do")
	public String findIdPost(MemberDTO memberDTO, Model model) {
		MemberDTO findId = memberDAO.findIdMember(memberDTO);
		
		if(findId != null) {
			model.addAttribute("foundId", findId.getId());
			return "member/findId";
		}
		else {
			model.addAttribute("notfountId", "회원정보가 없습니다.");
			return "member/findId";
		}
	}
	
//	비밀번호찾기
	@GetMapping("/member/findPass.do")
	public String findPassGet() {
		return "member/findPass";
	}
	
	@PostMapping("/member/findPass.do")
	public String findPassPost(MemberDTO memberDTO, Model model) {
		MemberDTO findPass = memberDAO.findPassMember(memberDTO);
		
//		입력된 아이디와 이메일과 일치하는 회원이 있는지 확인
		if(findPass != null) {
			InfoDTO infoDTO = new InfoDTO();
			
//			비번랜덤생성
			String newPassword = randomPass();
//			랜덤생성된 비밀번호로 변경
			memberDAO.newPassword(newPassword, findPass.getId(), findPass.getEmail());
			
			infoDTO.setTo(findPass.getEmail());
			infoDTO.setSubject("비밀번호 찾기");
			infoDTO.setContent("임시 비밀번호는 " + newPassword + "입니다. 로그인 후 비밀번호 변경을 진행하세요.");
			infoDTO.setFormat("text");
			email.myEmailSender(infoDTO);
			
			
			model.addAttribute("passInfo", "임시비밀번호가 발급되었습니다. 메일함을 확인하세요");
			return "member/findPass";
		}
		else {
			model.addAttribute("notfountPass", "회원정보가 없습니다.");
			return "member/findPass";
		}
	}
	
//	회원인증: 로그인 유저 비밀번호 인증
	@GetMapping("/member/checkMember.do")
	public String checkMemberGet() {
		return "member/checkMember";
	}
	
	@PostMapping("/member/checkMember.do")
	public String checkMemberPost(MemberDTO memberDTO, Model model) {
		MemberDTO loginUser = memberDAO.loginMember(memberDTO);
		
		if(loginUser != null) {
//			주민번호 데이터가 있으면 개인회원
			if(loginUser.getRrn() != null) {
				return "redirect:/member/editUser.do";
			}
//			병원회원
			return "redirect:/member/editHosp.do";
		}
		else {
			model.addAttribute("checkMemberFaild", "비밀번호가 일치하지 않습니다.");
			return "member/checkMember";
		}
	}
	
//	회원정보 수정: user
	@GetMapping("/member/editUser.do")
	public String editUserGet(MemberDTO memberDTO, HttpSession session, Model model) {
		memberDTO.setId((String) session.getAttribute("userId"));
		memberDTO.setPassword((String) session.getAttribute("userPassword"));
		
		
		MemberDTO loginUser = memberDAO.loginMember(memberDTO);
		String[] tel =  loginUser.getTel().split("-");
		String[] email =  loginUser.getEmail().split("@");
		String[] rrn =  loginUser.getRrn().split("-");
		
		model.addAttribute("loginUserInfo", loginUser);
		model.addAttribute("tel", tel);
		model.addAttribute("email", email);
		model.addAttribute("rrn1", rrn[0]);
		model.addAttribute("rrn2", rrn[1].substring(0,1));
		
		return "member/editUser";
	}
	
	@PostMapping("/member/editUser.do")
	public String editUserPost(MemberDTO memberDTO, HttpServletRequest req, HttpSession session, Model model) {
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String eamil = req.getParameter("email1") + "@" + req.getParameter("email2");
		String rrn = req.getParameter("rrn1") + "-" + req.getParameter("rrn2") + "000000";
		
		memberDTO.setTel(tel);
		memberDTO.setEmail(eamil);
		memberDTO.setRrn(rrn);
		
		memberDAO.userEdit(memberDTO);
		
		if (memberDAO.userEdit(memberDTO) == 1) {
			session.setAttribute("userPassword", memberDAO.loginMember(memberDTO).getPassword());
			return "redirect:/member/editUser.do";
		}
		else {
			model.addAttribute("editUserFaild", "회원정보 수정에 실패했습니다.");
			return "member/editUser";
		}
	}

//	회원정보 수정: hosp
	@GetMapping("/member/editHosp.do")
	public String editHospGet(MemberDTO memberDTO, HttpSession session, Model model) {
		memberDTO.setId((String) session.getAttribute("userId"));
		memberDTO.setPassword((String) session.getAttribute("userPassword"));
		
		// member 
		MemberDTO loginUser = memberDAO.loginMember(memberDTO);
		String[] tel =  loginUser.getTel().split("-");
		String[] taxid =  loginUser.getTaxid().split("-");
		
		model.addAttribute("loginUserInfo", loginUser);
		model.addAttribute("tel", tel);
		model.addAttribute("taxid", taxid);
		
		// hours
		List<HoursDTO> hoursDTO = memberDAO.hospHours(memberDTO); 
//		for (HoursDTO dto : hoursDTO) {
//		    System.out.println("week: " + dto.getWeek());
//		    System.out.println("Starttime: " + dto.getStarttime());
//		    System.out.println("End Time: " + dto.getEndtime());
//		    System.out.println("Break Time Start: " + dto.getStartbreak());
//		    System.out.println("Break Time End: " + dto.getEndbreak());
//		    System.out.println("데드라인: " + dto.getDeadline());
//		    System.out.println("병원: " + dto.getHosp_ref());
//		    System.out.println("-------------------------");
//		}
		
		model.addAttribute("hoursDTO", hoursDTO);
		
		
		
		return "member/editHosp";
	}
	
//	@PostMapping("/member/editHosp.do")
//	public String editHospPost(MemberDTO memberDTO, DoctorDTO doctorDTO, HoursDTO hoursDTO, HttpServletRequest req, HttpSession session, Model model) {
//		
//		
//		return
//	}
//	
//	
//	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	비밀번호 랜덤생성 함수
	 public static String randomPass() {
	 	Random random = new Random();
	 	int[] passPattern = {0, 1, 2};
	 	char randomChar;
	 	String newPassword = "";
	 	
        for (int i = 0; i < 4; i++) {
        	for (int pass : passPattern) {
        		switch (pass) {
//	        		대문자
                case 0:
	                randomChar = (char) ('A' + random.nextInt(26));
	                newPassword += randomChar;
                    break;
//	                소문자
                case 1:
                	randomChar = (char) ('a' + random.nextInt(26));
                	newPassword += randomChar;
                    break;
//	                숫자
                case 2:
                	int passNum = (int) (Math.random() * 10);
                	newPassword += passNum;
                    break;
	            }
	        }
    	}
        
        return newPassword;
        }

	
	

}
