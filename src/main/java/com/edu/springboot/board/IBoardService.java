package com.edu.springboot.board;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IBoardService {
	
	// 베스트 게시판: 베스트 게시판의 게시글 개수를 카운트
	public int countBestPost();
	// 베스트 게시판: 베스트 게시판에서 한 페이지에 출력할 게시글을 인출
	public ArrayList<BoardDTO> listBestPost(ParameterDTO parameterDTO);
	
	
	// 내가 쓴 글: 로그인 사용자가 작성한 게시글의 개수를 카운트
	public int countMyPost(String id);
	// 내가 쓴 글: 로그인 한 사용자가 작성한 게시글에서 한 페이지에 출력할 게시글을 인출
	public ArrayList<BoardDTO> listMyPost(String id, int start, int end);
	
	
	// 닉네임 인출: 게시글 작성자 닉네임 인출
	public String selectBoardNickname(BoardDTO boardDTO);
	// 좋아요: 좋아요 수 조회
	public int countLike(String recodenum);
	// 댓글: 댓글 수 조회
	public int countComment(BoardDTO boardDTO);
	
	
	
	

}
