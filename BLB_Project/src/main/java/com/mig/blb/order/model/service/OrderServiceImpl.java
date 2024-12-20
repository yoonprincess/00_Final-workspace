package com.mig.blb.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.order.model.dao.OrderDao;
import com.mig.blb.order.model.vo.Order;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertOrder(Order o) {
		return orderDao.insertOrder(sqlSession, o);
	}

	
	
	@Override
	public int myOrderListCount(HashMap<String, Object> dateMap) {
		return orderDao.myOrderListCount(sqlSession, dateMap);
	}
	
	@Override
	public ArrayList<Order> selectMyOrderList(HashMap<String, Object> dateMap,PageInfo pi ) {
		
		return orderDao.selectMyOrderList(sqlSession, dateMap,pi);
	}

	@Override
	public HashMap<String, Integer> myOrderCounts(String memberId) {
		return orderDao.myOrderCounts(sqlSession, memberId);
	}

	@Override
	public ArrayList<Order> selectAllMyOrders(HashMap<String, Object> dateMap) {
		
		return orderDao.selectAllMyOrders(sqlSession, dateMap);
	}


	
}
