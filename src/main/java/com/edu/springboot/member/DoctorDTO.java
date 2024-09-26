package com.edu.springboot.member;

import lombok.Data;

@Data
public class DoctorDTO {
	private String doctorname;
	private String major;
	private String career;
	private String photo;
	private String hours;
	private String hosp_ref;
}