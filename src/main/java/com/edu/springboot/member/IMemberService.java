package com.edu.springboot.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.emoji.EmojiDTO;

@Mapper
public interface IMemberService {
	
//	회원목록
	public List<MemberDTO> getAllMember();
	
//	회원가입: 개인회원 
	public int insertUser(MemberDTO memberDTO);
	
//	회원가입: 병원회원
	public int insertHospMember(MemberDTO memberDTO);
	public int insertHospDoctor(DoctorDTO doctorDTO);
	public int insertHospHours(HoursDTO hoursDTO);
	public int updateHospHours(HoursDTO hoursDTO);
	
//	회원가입: 아이디 중복 체크
	public int checkId(String id);
//	회원가입: 랜덤 닉네임 생성
	public String getNick();
	
//	로그인
//	public MemberDTO loginMember(MemberDTO memberDTO);
	public MemberDTO loginMember(String id, String passwd);
	
//	아이디찾기
	public String findIdMember(MemberDTO memberDTO);
	
//	비밀번호찾기
	public MemberDTO findPassMember(MemberDTO memberDTO);
//  새로운 비밀번호 생성
	public int updateNewPass(String password, String id, String email);
	
//	회원정보수정: user
	public int editUser(MemberDTO memberDTO);
	
//	회원정보수정: hosp 
	public int updateHospMember(MemberDTO memberDTO);
//	회원정보수정: hosp - hours
	public int editHospHours(HoursDTO hoursDTO);
	
//	회원정보선택: hosp - hours
	public List<HoursDTO> selectHospHours(String hosp_ref);
	
//	회원정보선택: hosp - detail
	public DetailDTO selectHospDatail(String hosp_ref);
	
//	회원정보선택: hosp - doctor
	public List<DoctorDTO> selectHospDoctor(String hosp_ref);
	
	
//	로그인한 병원의 영업시간정보 초기화
	public int resetHospHours(HoursDTO hoursDTO);
	
//	병원 상세정보 추가
	public int insertHospDetail(DetailDTO detailDTO);
	
//	병원 상세정보 수정
	public int updateHospDetail(DetailDTO detailDTO);

	
	
	
//  ***************** mypage로 이동 예정 *****************
//  회원 포인트 정보 감소
	public int decreaseUserPoint(MemberDTO memberDTO);
	
//	회원 출석체크 
	public int userAttend(MemberDTO memberDTO);
	
	
	
}