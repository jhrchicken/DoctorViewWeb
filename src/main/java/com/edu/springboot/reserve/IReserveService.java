package com.edu.springboot.reserve;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.MemberDTO;

@Mapper
public interface IReserveService {
	
	// 예약할 병원 정보
	public MemberDTO getHospital(ReserveDTO reserveDTO);
	// 예약할 병원의 의사 정보
	public List<DoctorDTO> getDoctor(String hosp_ref);

	// 예약 정보 저장
	public int saveReservationInfo(ReserveDTO reserveDTO);
	// 예약 정보 가져옴
	public List<ReserveDTO> getReservationInfo(String id);
	
	

	
	
	
	
	
}
