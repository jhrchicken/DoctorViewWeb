package com.edu.springboot.emoji;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IEmojiService {
	
	// 보유한 이모지 목록 
	public List<EmojiDTO> myEmojiList(String user_ref);
	
	// 이모지 사용 비활성화
	public int deactivateEmoji(EmojiDTO emojiDTO); 
	
	// 이모지 사용 활성화
	public int activateEmoji(EmojiDTO emojiDTO); 
	
	// 회원의 활성화된 이모지 정보 업데이트
	public int userEmojiUpdate(EmojiDTO emojiDTO);
	
	// 회원 이모지 구매
	public int userBuyEmoji(EmojiDTO emojiDTO);

	
	
	
}