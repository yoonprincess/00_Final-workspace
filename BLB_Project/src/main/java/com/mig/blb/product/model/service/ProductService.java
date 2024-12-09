package com.mig.blb.product.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.product.model.vo.Product;

public interface ProductService {
	
	int selectProductCount(Map<String, Object> params);
	
	ArrayList<Product> selectProductList(PageInfo pi, Map<String, Object> params);

}
