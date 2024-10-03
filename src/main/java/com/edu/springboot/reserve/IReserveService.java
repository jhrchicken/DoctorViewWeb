package com.edu.springboot.reserve;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.MemberDTO;

@Mapper
public interface IReserveService {
	
	// 예약할 병원 정보
	public MemberDTO getHospital(ReserveDTO reserveDTO);
	public MemberDTO getMyHospital(MemberDTO memberDTO);
	// 예약할 병원의 의사 정보
	public List<DoctorDTO> getDoctor(String hosp_ref);

	// 예약 정보 저장
	public int saveReservationInfo(ReserveDTO reserveDTO);
	
	// 예약 목록 가져옴
	public List<ReserveDTO> getReservationInfo(@Param("user_ref") String user_ref, @Param("hosp_ref") String hosp_ref);
	
	// 선택한 예약 정보 가져옴
	public ReserveDTO getReservationDetails(int app_id);
	// 예약 메모 추가
	public int updateReservationDetails(@Param("app_id") int app_id, @Param("user_memo") String user_memo, @Param("hosp_memo") String hosp_memo);
	
	// 예약 취소
	public int cancelReservation(ReserveDTO reserveDTO);

	// 에약내역 숨김
	public int hideReservation(ReserveDTO reserveDTO);
	
	// 예약시간 close
	public int closeTime(ReserveDTO reserveDTO);
	

	
	
	
	
	
}
