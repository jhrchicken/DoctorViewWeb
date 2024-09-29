package com.edu.springboot.emoji;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class EmojiController {
	
	@Autowired
	IEmojiService emojiDAO;
	
	@Autowired
	IMemberService memberDAO;
	
	// 보유 이모지 목록
	@GetMapping("/myEmoji.do")
	public String myEmoji(Model model, HttpSession session) {
		List<EmojiDTO> emojiDTO = emojiDAO.myEmojiList((String)session.getAttribute("userId"));
		model.addAttribute("emojiDTO", emojiDTO);
		
		for (EmojiDTO emoji : emojiDTO) {
		    System.out.println("Emoji: " + emoji.getEmoji());
		    System.out.println("Emoji use_emoji: " + emoji.getUse_emoji());
		}
		

		return "emoji/myEmoji";
	}
	
	// 이모지 변경
	@PostMapping("/emoji/editEmoji.do")
	public String editEmoji(Model model, HttpSession session, EmojiDTO emojiDTO) {
		// 현재 사용중인 이모지 비활성화
		emojiDAO.deactivateEmoji(emojiDTO);
		
		// 선택한 이모지 활성화
		emojiDAO.activateEmoji(emojiDTO);
		System.out.println("이모지 활성화 완료");
		
		// 현재 로그인 한 유저의 emoji  컬럼 업데이트
		emojiDAO.userEmojiUpdate(emojiDTO);
		session.setAttribute("userEmoji", emojiDTO.getEmoji());
		
		return "redirect:/myEmoji.do";
	}
	
	
	

}
