package com.edu.springboot.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberService {
	
//	회원가입 
	public int joinMemer(MemberDTO memberDTO);
	
//	로그인
	public MemberDTO loginMember(MemberDTO memberDTO);
	
//	회원가입 아이디 중복 체크
	public int checkId(String id);
	
//	회원가입 랜덤 닉네임 생성
	public String getNick();

}