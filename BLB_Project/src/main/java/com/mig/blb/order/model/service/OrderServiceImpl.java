package com.mig.blb.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.order.model.dao.OrderDao;
import com.mig.blb.order.model.vo.Order;
import com.mig.blb.order.model.vo.ProductOrder;

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
	public ArrayList<Order> selectAllMyOrders(HashMap<String, Object> dateMap) {
		
		return orderDao.selectAllMyOrders(sqlSession, dateMap);
	}

	@Override
	public HashMap<String, Integer> myOrderCounts(String memberId) {
		return orderDao.myOrderCounts(sqlSession, memberId);
	}
	
	@Override
	public int selectOrderNo() {
		return orderDao.selectOrderNo(sqlSession);
	}

	@Override
	public int insertProductOrder(List<ProductOrder> productOrders) {
		return orderDao.insertProductOrder(sqlSession, productOrders);
	}

	@Override
	public Order selectOrder(int orderNo) {
		return orderDao.selectOrder(sqlSession, orderNo);
	}

	@Override
	public List<ProductOrder> selectProductOrderList(int orderNo) {
		return orderDao.selectProductOrderList(sqlSession, orderNo);
	}

	@Override
	public ArrayList<Order> selectMyOrder(String orderNo) {
		return orderDao.selectMyOrder(sqlSession, orderNo);
	}
	
}
