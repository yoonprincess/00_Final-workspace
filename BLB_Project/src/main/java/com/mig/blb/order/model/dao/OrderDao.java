package com.mig.blb.order.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.order.model.vo.Order;

@Repository
public class OrderDao {

	public int insertOrder(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.insert("orderMapper.insertOrder", o);
	}

}
