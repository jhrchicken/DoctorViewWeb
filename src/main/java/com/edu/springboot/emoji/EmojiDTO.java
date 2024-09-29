package com.edu.springboot.emoji;

import lombok.Data;

@Data
public class EmojiDTO {
	private int emoji_idx;
	private String user_ref;
	private String emoji;
	private String use_emoji;
	
	// 추가 컬럼
	private String title;
	
}