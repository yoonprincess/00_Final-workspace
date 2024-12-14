package com.mig.blb.option.model.service;

import java.util.ArrayList;

import com.mig.blb.option.model.vo.Option;

public interface OptionService {

	// 장바구니 상품 각각의 옵션 목록 조회
	ArrayList<Option> selectCartOption(int prodNo);

}
