package com.mig.blb.product.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.product.model.vo.Product;

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

}
