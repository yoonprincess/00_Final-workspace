package com.mig.blb.order.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.order.model.vo.Order;

@Repository
public class OrderDao {

	public int insertOrder(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.insert("orderMapper.insertOrder", o);
	}
	
	
	public ArrayList<Order> selectMyOrderList(SqlSessionTemplate sqlSession, HashMap<String, Object> dateMap, PageInfo pi ) {
		
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		System.out.println("offSet : " + offset);
		System.out.println("limit : " + limit);
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyOrderList", dateMap, rowBounds);
	}

	public HashMap<String, Integer> myOrderCounts(SqlSessionTemplate sqlSession, String memberId) {
		
		return sqlSession.selectOne("memberMapper.myOrderCounts", memberId);
	}


	public int myOrderListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> dateMap) {
		return sqlSession.selectOne("memberMapper.myOrderListCount", dateMap);
	}


	public ArrayList<Order> selectAllMyOrders(SqlSessionTemplate sqlSession, HashMap<String, Object> dateMap) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectAllMyOrders", dateMap);
	}
}
