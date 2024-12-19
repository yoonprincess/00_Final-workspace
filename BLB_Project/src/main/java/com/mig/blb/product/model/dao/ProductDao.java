package com.mig.blb.product.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductAtt;

@Repository
public class ProductDao {

	public int selectProductCount(SqlSessionTemplate sqlSession, Map<String, Object> params) {
		return sqlSession.selectOne("productMapper.selectProductCount", params);
	}

	public ArrayList<Product> selectProductList(SqlSessionTemplate sqlSession, PageInfo pi, Map<String, Object> params) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("productMapper.selectProductList", params, rowBounds);
	}

	public int increaseViewCount(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.update("productMapper.increaseViewCount", prodNo);
	}

	public Product selectProduct(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.selectOne("productMapper.selectProduct", prodNo);
	}

	public ArrayList<ProductAtt> selectProductAtt(SqlSessionTemplate sqlSession, int prodNo) {
		return (ArrayList)sqlSession.selectList("productMapper.selectProductAtt", prodNo);
	}

	public int selectProdInquiryCount(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.selectOne("productMapper.selectProdInquiryCount", prodNo);
	}

	public ArrayList<Inquiry> selectProdInquiryList(SqlSessionTemplate sqlSession, PageInfo qnaPi, int prodNo) {
		
		int offset = (qnaPi.getCurrentPage() - 1) * qnaPi.getBoardLimit();
		int limit = qnaPi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("productMapper.selectProdInquiryList", prodNo, rowBounds);
	}

	public boolean checkPurchase(SqlSessionTemplate sqlSession, int prodNo, String memberId) {
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("prodNo", prodNo);
		paramMap.put("memberId", memberId);
		
		return (int)sqlSession.selectOne("productMapper.checkPurchase", paramMap) > 0;
	}

}
