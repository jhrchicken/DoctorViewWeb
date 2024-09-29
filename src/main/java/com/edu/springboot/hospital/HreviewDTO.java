package com.edu.springboot.hospital;

import java.sql.Date;

import lombok.Data;

@Data
public class HreviewDTO {
	private String review_idx;
	private String original_idx;
	private Date postdate;
	private int score;
	private String content;
	private int cost;
	private String treat;
	private String doctor;
	private String writer_ref;
	private String hosp_ref;
}