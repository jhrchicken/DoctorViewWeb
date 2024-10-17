package com.edu.springboot.mypage;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.hospital.HospitalDTO;

@Mapper
public interface IMypageService {

	// 찜한 병원: 로그인 사용자가 찜한 병원의 개수를 카운트
	public int countMyHosp(String id);
	// 찜한 병원
	public ArrayList<HospitalDTO> listMyHosp(String id, int start, int end);
	
	// 찜한 의사: 로그인 사용자가 찜한 의사의 개수를 카운트
	public int countMyDoctor(String id);
	// 찜한 의사
	public ArrayList<DoctorDTO> listMyDoctor(String id, int start, int end);

	
	
	
	
	
	
	
	
	
}
