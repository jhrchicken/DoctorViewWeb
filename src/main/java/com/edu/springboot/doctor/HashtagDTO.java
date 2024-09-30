package com.edu.springboot.doctor;

import lombok.Data;

@Data
public class HashtagDTO {
	private int tag_idx;
	private String hosp_ref;
	private int review_ref;
	private String tag;
}
