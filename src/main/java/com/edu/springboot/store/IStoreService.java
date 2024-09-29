package com.edu.springboot.store;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IStoreService {
	
	// 상점 이모지 목록 
	public List<StoreDTO> storeList();
	
}