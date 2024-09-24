package com.edu.springboot.board;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IFreeboardService {
	// 게시글 목록: 자유게시판의 게시글 개수를 카운트
	public int countPost(ParameterDTO parameterDTO);
	// 게시글 목록: 자유게시판에서 한 페이지에 출력할 게시글을 인출
	public ArrayList<BoardDTO> listPost(ParameterDTO parameterDTO);
	// 게시글 조회
	public BoardDTO viewPost(BoardDTO boardDTO);
	// 게시글 조회: 자유게시판에서 게시글의 조회수 증가
	public int plusVisitcount(BoardDTO boardDTO);
	// 게시글 작성
	public int writePost(String title, String content, String writer_idx);
	// 게시글 수정
	public int editPost(BoardDTO boardDTO);
	// 게시글 삭제
	public int deletePost(String board_idx);
	
	// 댓글 조회
	public ArrayList<CommentsDTO> listComments(BoardDTO boardDTO);
	// 댓글 작성
	public int writeComment(String id, int board_idx, String content);
	// 댓글 수정
	public int editComment(int board_idx, String content);
	// 댓글 삭제
	public int deleteComment(String comm_idx);
	
	// 닉네임 인출: 게시글 작성자 닉네임 인출
	public String selectBoardNickname(BoardDTO boardDTO);
	// 닉네임 인출: 댓글 작성자 닉네임 인출
	public String selectCommNickname(CommentsDTO commentsDTO);
	// 좋아요: 좋아요 수 조회
	public int countLike(String recodenum);
	// 좋아요: 좋아요 레코드 존재 여부 확인
	public int checkLike(String id, String board_idx);
	// 좋아요: 좋아요 수 증가
	public int plusLike(String id, String board_idx);
	// 좋아요: 좋아요 수 감소
	public int minusLike(String id, String board_idx);
	// 신고: 신고 수 조회
	public int countReport(int board_idx);
	// 신고: 신고 레코드 존재 여부 확인
	public int checkReport(String id, String board_idx);
	// 신고: 신고 수 증가
	public int plusReport(String id, String board_idx);
	// 신고: 신고 수 감소
	public int minusReport(String id, String board_idx);
	
	// 조회
	public int countComment(BoardDTO boardDTO);

}