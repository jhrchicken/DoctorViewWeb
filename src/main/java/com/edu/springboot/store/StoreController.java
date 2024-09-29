package com.edu.springboot.store;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class StoreController {
	
	@Autowired
	IStoreService storeDAO;
	
	// 상점 진입
	@GetMapping("/store.do")
	public String store(Model model) {
		// 상점 이모지 목록 가져오기
		List<StoreDTO> storeDTO = storeDAO.storeList();
		model.addAttribute("storeDTO", storeDTO);

		return "emoji/store";
	}
	
	// 이모지 구매
	@PostMapping("/store/buy.do")
	public String buyEmoji(Model model) {

		return "store/store";
	}

}
