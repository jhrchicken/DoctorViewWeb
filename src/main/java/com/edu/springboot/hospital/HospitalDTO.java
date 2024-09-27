package com.edu.springboot.hospital;

import lombok.Data;

@Data
public class HospitalDTO {
	// API
	private int api_idx;
	private String name;
	private String department;
	private String tel;
	private String address;
	private String distance;
	
	// 입점 여부
	private String enter = "F";
	
	private String id;
	private String nickname;
	private String taxid;
	private String photo;
	
	
	// 상세 정보
	
	
	
	// 추가
	private double score;
	private int likecount;
	private int reviewcount;
	
}
