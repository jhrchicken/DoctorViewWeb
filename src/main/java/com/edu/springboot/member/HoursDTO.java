package com.edu.springboot.member;

import lombok.Data;

@Data
public class HoursDTO {
	private String week;
	private String starttime;
	private String endtime;
	private String startbreak;
	private String endbreak;
	private String deadline;
	private String hosp_ref;
}