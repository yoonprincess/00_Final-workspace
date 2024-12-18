package com.mig.blb.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public ArrayList<Order> selectMyOrderList(HashMap<String, String> dateMap) {
		
		return orderDao.selectMyOrderList(sqlSession, dateMap);
	}


	@Override
	public ArrayList<Order> searchMyOrderList(HashMap<String, String> searchMap) {
		return orderDao.searchMyOrderList(sqlSession, searchMap);
	}

	
}
