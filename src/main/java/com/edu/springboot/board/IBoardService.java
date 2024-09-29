package com.edu.springboot.board;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IBoardService {
	// 게시글 목록: 로그인 사용자가 작성한 게시글의 개수를 카운트
	public int countMyPost(String id);
	// 게시글 목록: 로그인 한 사용자가 작성한 게시글에서 한 페이지에 출력할 게시글을 인출
	public ArrayList<BoardDTO> listMyPost(String id, int start, int end);
	
	
	// 닉네임 인출: 게시글 작성자 닉네임 인출
	public String selectBoardNickname(BoardDTO boardDTO);
	// 좋아요: 좋아요 수 조회
	public int countLike(String recodenum);
	// 댓글: 댓글 수 조회
	public int countComment(BoardDTO boardDTO);
	
	
	
	

}
