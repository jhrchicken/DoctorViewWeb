package com.edu.springboot.emoji;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@Controller
public class EmojiController {
	
	@Autowired
	IEmojiService emojiDAO;
	
	@Autowired
	IMemberService memberDAO;
	
	@Autowired
	IStoreService storeDAO;
	
	
	// 나의 이모지: 보유 이모지 목록
	@GetMapping("/myEmoji.do")
	public String myEmoji(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		// 로그인한 유저의 아이디를 넘겨 이모지 목록 가져옴
		List<EmojiDTO> emojiDTO = emojiDAO.myEmojiList((String)session.getAttribute("userId"));
		model.addAttribute("emojiDTO", emojiDTO);

		// 유저의 보유 포인트 목록 가져오기
		MemberDTO memberDTO = memberDAO.loginMember((String)session.getAttribute("userId"), (String)session.getAttribute("userPassword"));
		model.addAttribute("memberDTO", memberDTO);

		return "emoji/myEmoji";
	}
	
	// 이모지 변경
	@PostMapping("/emoji/editEmoji.do")
	public String editEmoji(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response, EmojiDTO emojiDTO) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		// 현재 사용중인 이모지 비활성화
		emojiDAO.deactivateEmoji((String) session.getAttribute("userId"));
		
		// 선택한 이모지 활성화
		emojiDAO.activateEmoji(emojiDTO);
		
		// 현재 로그인 한 유저의 emoji 컬럼 업데이트
		emojiDAO.userEmojiUpdate(emojiDTO);
		MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
		loginMember.setEmoji(emojiDTO.getEmoji());
		session.setAttribute("loginMember", loginMember);
		// session.setAttribute("userEmoji", emojiDTO.getEmoji());
		
		return "redirect:/myEmoji.do";
	}
	
	// 이모지 상점 이동
	@GetMapping("/store.do")
	public String store(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		// 상점 이모지 목록 가져오기
		List<StoreDTO> storeDTO = storeDAO.storeList();
		model.addAttribute("storeDTO", storeDTO);

		// 회원이면
		if(session.getAttribute("userId") != null) {
			// 유저의 보유 이모지 목록
			List<EmojiDTO> emojiDTO = emojiDAO.myEmojiList((String)session.getAttribute("userId"));
			model.addAttribute("emojiDTO", emojiDTO);
			
			// 유저의 보유 포인트 목록 가져오기
			MemberDTO memberDTO = memberDAO.loginMember((String)session.getAttribute("userId"),(String)session.getAttribute("userPassword"));
			model.addAttribute("memberDTO", memberDTO);
		}
		

		return "emoji/store";
	}
	
	// 이모지 구매
	@PostMapping("/store/buy.do")
	public String buy(Model model, MemberDTO memberDTO, StoreDTO storeDTO, EmojiDTO emojiDTO, HttpSession session, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		
		// 유저의 보유 포인트 목록 가져오기
		memberDTO = memberDAO.loginMember((String)session.getAttribute("userId"),(String)session.getAttribute("userPassword"));
		
		if (memberDTO.getPoint() >= storeDTO.getPrice() ) {
			// 회원 이모지 추가
			emojiDTO.setUser_ref(memberDTO.getId());
			emojiDAO.userBuyEmoji(emojiDTO);
			
			// 회원 포인트 감소
			memberDTO.setPoint(memberDTO.getPoint()-storeDTO.getPrice());
			memberDAO.decreaseUserPoint(memberDTO);
		} else {
		    // 이모지 구매 실패
		    redirectAttributes.addFlashAttribute("emojiBuyError", "포인트가 부족합니다.");
		}
		
		return "redirect:/store.do";
	}

}
