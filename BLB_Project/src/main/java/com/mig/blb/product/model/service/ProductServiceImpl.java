package com.mig.blb.product.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.product.model.dao.ProductDao;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductAtt;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ProductDao productDao;

	@Override
	public int selectProductCount(Map<String, Object> params) {
		return productDao.selectProductCount(sqlSession, params);
	}

	@Override
	public ArrayList<Product> selectProductList(PageInfo pi, Map<String, Object> params) {
		return productDao.selectProductList(sqlSession, pi, params);
	}

	@Override
	@Transactional
	public int increaseViewCount(int prodNo) {
		return productDao.increaseViewCount(sqlSession, prodNo);
	}

	@Override
	public Product selectProduct(int prodNo) {
		return productDao.selectProduct(sqlSession, prodNo);
	}

	@Override
	public ArrayList<ProductAtt> selectProductAtt(int prodNo) {
		return productDao.selectProductAtt(sqlSession, prodNo);
	}
}
