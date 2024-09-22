package com.edu.springboot.board;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IFreeboardService {
	// 목록: 자유게시판의 게시글 개수를 카운트
	public int countPost(ParameterDTO parameterDTO);
	// 목록: 자유게시판에서 한 페이지에 출력할 게시글을 인출
	public ArrayList<BoardDTO> listPost(ParameterDTO parameterDTO);
	// 조회
	public BoardDTO viewPost(BoardDTO boardDTO);
	// 조회: 자유게시판에서 게시글의 조회수 증가
	public int plusVisitcount(BoardDTO boardDTO);
	// 작성
	public int writePost(String title, String content, String writer_idx);
	// 수정
	public int editPost(BoardDTO boardDTO);
	// 삭제
	public int deletePost(String idx);
}