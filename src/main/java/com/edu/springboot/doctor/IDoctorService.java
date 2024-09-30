package com.edu.springboot.doctor;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.board.ParameterDTO;

@Mapper
public interface IDoctorService {

	// 의사 목록: 의사의 게시글 개수를 카운트
	public int countDoctor(ParameterDTO parameterDTO);
	// 의사 목록: 의사의 목록에서 한 페이지에 출력할 게시글을 인출
	public ArrayList<DoctorDTO> listDoctor(ParameterDTO parameterDTO);
	// 의사 조회
	public DoctorDTO viewDoctor(DoctorDTO doctorDTO);
	// 의사 정보 작성
	public int writeDoctor(DoctorDTO doctorDTO);
	// 의사 정보 수정
	public int editDoctor(DoctorDTO doctorDTO);
	// 의사 정보 삭제
	public int deleteDoctor(int doc_idx);
	
	// 리뷰 조회
	public ArrayList<DreviewDTO> listReview(DoctorDTO doctorDTO);
	// 리뷰 작성
	public int writeReview(int score, String content, String id, int doc_idx);
	// 리뷰 수정
	public int editReview(int review_idx, int score, String content);
	// 리뷰 삭제
	public int deleteReview(int review_idx);

	// 답변 작성
	public int writeReply(int review_idx, String content, String id, int doc_ref);
	// 답변 수정
	public int editReply(int review_idx, String content);
	// 답변 삭제
	public int deleteReply(int review_idx);
	// 리뷰 삭제에 따른 답변 일괄 삭제
	public int deleteAllReply(int original_idx);
	
	// 병원명 인출: 소속된 병원의 이름 인출
	public String selectHospName(DoctorDTO doctorDTO);
	// 닉네임 인출: 리뷰 작성자 닉네임 인출
	public String selectReviewNickname(DreviewDTO dreviewDTO);
	
	// 의사 좋아요: 의사 좋아요 수 조회
	public int countDocLike(String recodenum);
	// 의사 좋아요: 의사 좋아요 레코드 존재 여부 확인
	public int checkDocLike(String id, String doc_idx);
	// 의사 좋아요: 의사 좋아요 수 증가
	public int plusDocLike(String id, String doc_idx);
	// 의사 좋아요: 의사 좋아요 수 감소
	public int minusDocLike(String id, String doc_idx);
	// 의사 좋아요: 의사 삭제에 의한 의사 좋아요 일괄 삭제
	public int deleteAllDocLike(int doc_idx);
	// 의사 좋아요: 의사 삭제에 의한 의사에 해당하는 리뷰 좋아요 일괄 삭제
	public int deleteAllDocReviewLike(int doc_idx);
	
	// 리뷰 좋아요: 리뷰 좋아요 수 조회
	public int countReviewLike(String recodenum);
	// 리뷰 좋아요: 리뷰 좋아요 레코드 존재 여부 확인
	public int checkReviewLike(String id, String review_idx);
	// 리뷰 좋아요: 리뷰 좋아요 수 증가
	public int plusReviewLike(String id, String review_idx);
	// 리뷰 좋아요: 리뷰 좋아요 수 감소
	public int minusReviewLike(String id, String review_idx);
	// 리뷰 좋아요: 리뷰 삭제에 의한 리뷰 좋아요 일괄 삭제
	public int deleteAllReviewLike(int review_idx);
	
	// 리뷰 수 조회
	public int countReview(String doc_idx);
	// 별점 합계 조회
	public int sumScore(String doc_idx);
}
