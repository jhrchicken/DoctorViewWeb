package com.edu.springboot.hospital;

import lombok.Data;

@Data
public class ParameterDTO {
	// 검색어
	private String searchField;
	private String searchWord;
	private String searchSido;
	private String searchGugun;
	
	
	
	// 게시물 구간
	private int start;
	private int end;
}
