package com.mig.blb.order.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.order.model.vo.Order;

@Repository
public class OrderDao {

	public int insertOrder(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.insert("orderMapper.insertOrder", o);
	}
	
	
	public ArrayList<Order> selectMyOrderList(SqlSessionTemplate sqlSession, HashMap<String, String> dateMap) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyOrderList", dateMap);
	}


	public ArrayList<Order> searchMyOrderList(SqlSessionTemplate sqlSession, HashMap<String, String> searchMap) {
		return (ArrayList)sqlSession.selectList("memberMapper.searchMyOrderList", searchMap);
	}
}
