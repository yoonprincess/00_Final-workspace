package com.mig.blb.product.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.product.model.dao.ProductDao;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductAtt;
import com.mig.blb.wish.model.vo.Wish;

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

	@Override
	public int selectProdInquiryCount(int prodNo) {
		return productDao.selectProdInquiryCount(sqlSession, prodNo);
	}

	@Override
	public ArrayList<Inquiry> selectProdInquiryList(PageInfo qnaPi, int prodNo) {
		return productDao.selectProdInquiryList(sqlSession, qnaPi, prodNo);
	}

	@Override
	public List<Map<String, Object>> getPurchaseInfo(String memberId, int prodNo) {
		return productDao.getPurchaseInfo(sqlSession, memberId, prodNo);
	}

	@Override
	public Map<String, Object> getInfoByRevNo(int revNo) {
		return productDao.getInfoByRevNo(sqlSession, revNo);
	}

	@Override
	@Transactional
	public int insertProdInquiry(Inquiry inquiry) {
		return productDao.insertProdInquiry(sqlSession, inquiry);
	}

	@Override
	@Transactional
	public int deleteProdInquiry(int inquiryNo) {
		return productDao.deleteProdInquiry(sqlSession, inquiryNo);
	}

	@Override
	public Inquiry selectProdInquiry(int inquiryNo) {
		return productDao.selectProdInquiry(sqlSession, inquiryNo);
	}

	@Override
	@Transactional
	public int updateProdInquiry(Inquiry inquiry) {
		return productDao.updateProdInquiry(sqlSession, inquiry);
	}

	@Override
	public int isWished(Wish wish) {
		return productDao.isWished(sqlSession, wish);
	}

	@Override
	@Transactional
	public int addWish(Wish wish) {
		return productDao.addWish(sqlSession, wish);
	}

	@Override
	@Transactional
	public int removeWish(Wish wish) {
		return productDao.removeWish(sqlSession, wish);
	}
}
