package com.edu.springboot.reserve;

import java.sql.Date;

import lombok.Data;

@Data
public class ReserveDTO {
	private int app_id;
	private String hospname;
	private String doctorname;
	private String username;
	private String tel;
	private String rnn;
	private String address;
	private Date postdate;
	private String posttime;
	private String alarm;
	private String review;
	private String hide;
	private String user_ref;
	private String hosp_ref;
}