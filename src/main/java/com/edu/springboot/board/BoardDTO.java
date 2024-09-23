package com.edu.springboot.board;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDTO {
	private int board_idx;
	private String boardname;
	private Date postdate;
	private String title;
	private String content;
	private int visitcount;
	private int reportcount;
	private String writer_ref;
	private String nickname;
	private int likecount;
	private int commentcount;
}