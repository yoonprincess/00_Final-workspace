package com.mig.blb.option.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mig.blb.option.model.vo.Option;

public interface OptionService {

	// 장바구니 상품 각각의 옵션 목록 조회
	ArrayList<Option> selectCartOption(int prodNo);

	// 상품 등록 시 옵션 등록
	int insertOption(Map<String, Object> option);
	
	// 전체 옵션 및 추가정보 조회
	List<Object> selectOptionList();

	// 옵션 수정
	int updateOption(Option option);
	
	

}
