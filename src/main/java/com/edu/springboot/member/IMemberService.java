package com.edu.springboot.member;

import java.util.List;

import javax.xml.crypto.Data;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberService {
//	회원가입: 개인회원 
	public int userJoin(MemberDTO memberDTO);
	
//	회원가입: 병원회원
	public int joinMember(MemberDTO memberDTO);
	public int joinDoctor(DoctorDTO doctorDTO);
	public int joinHours(HoursDTO hoursDTO);
	
//	로그인
	public MemberDTO loginMember(MemberDTO memberDTO);
	
//	회원가입 아이디 중복 체크
	public int checkId(String id);
	
//	회원가입 랜덤 닉네임 생성
	public String getNick();
	
//	아이디찾기
	public MemberDTO findIdMember(MemberDTO memberDTO);
	
//	비밀번호찾기
	public MemberDTO findPassMember(MemberDTO memberDTO);
	
//  새로운 비밀번호 생성
	public int newPassword(String password, String id, String email);
	
//	회원정보수정: user
	public int userEdit(MemberDTO memberDTO);
	
//	회원정보수정: hosp - member
	public int editHospMember(MemberDTO memberDTO);
	
//	회원정보수정: hosp - hours
	public int editHours(HoursDTO hoursDTO);
	
//	회원정보선택: hosp - hours
	public List<HoursDTO> hospHours(MemberDTO memberDTO);
	
//	회원정보선택: hosp - detail
	public DetailDTO selectHospDatail(MemberDTO memberDTO);
	
//	회원정보선택: hosp - doctor
	public List<DoctorDTO> selectHospDoctor(MemberDTO memberDTO);
	
	
//	로그인한 병원의 영업시간정보 삭제
	public int deleteHospHours(MemberDTO memberDTO);
	
//	병원 상세정보 추가
	public int insertHospDetail(DetailDTO detailDTO);
	
//	병원 상세정보 수정
	public int updateHospDetail(DetailDTO detailDTO);

	
	
}