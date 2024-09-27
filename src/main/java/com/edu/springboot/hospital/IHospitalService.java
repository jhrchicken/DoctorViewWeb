package com.edu.springboot.hospital;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.board.ParameterDTO;

@Mapper
public interface IHospitalService {
		
	// 병원 API 목록: 병원 API의 레코드 개수를 카운트
	public int countHospApi(ParameterDTO parameterDTO);
	// 병원 API 목록: 병원 API의 레코드에서 한 페이지에 출력할 레코드를 인출
	public ArrayList<HospitalDTO> listHospApi(ParameterDTO parameterDTO);
	// 병원 입점 여부 확인: 병원이름으로 입점 여부를 확인하여 아이디 추출
	public String checkEnter(String name);
	// 병원 조회
	public HospitalDTO viewHosp(HospitalDTO hospitalDTO);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 병원 좋아요: 병원 좋아요 수 조회
	public int countHospLike(String recodenum);
	
	
	
	
	
	
	
	// 리뷰 수 조회
	public int countReview(String id);
	// 별점 합계 조회
	public int sumScore(String id);
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
