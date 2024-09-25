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
	public DoctorDTO viewPost(DoctorDTO doctorDTO);
	// 의사 추가
	// public int writeDoctor(String title, String content, String writer_idx);
	// 의사 정보 수정
	public int editDoctor(DoctorDTO doctorDTO);
	// 의사 정보 삭제
	public int deleteDoctor(String doctor_idx);
	
	// 병원명 인출: 소속된 병원의 이름 인출
	public String selectHosp(DoctorDTO doctorDTO);
	
	
	// 좋아요: 좋아요 수 조회
	public int countLike(String recodenum);
	// 좋아요: 좋아요 레코드 존재 여부 확인
	public int checkLike(String id, String doctor_idx);
	// 좋아요: 좋아요 수 증가
	public int plusLike(String id, String doctor_idx);
	// 좋아요: 좋아요 수 감소
	public int minusLike(String id, String doctor_idx);
}
