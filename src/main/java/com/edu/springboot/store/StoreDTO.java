package com.edu.springboot.store;

import lombok.Data;

@Data
public class StoreDTO {
	private int store_idx;
	private int price;
	private String emoji;
	private String title;
}