package com.mig.blb.order.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.order.model.vo.Order;
import com.mig.blb.order.model.vo.ProductOrder;

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
	
	public int selectOrderNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("orderMapper.selectOrderNo");
	}

	public int insertProductOrder(SqlSessionTemplate sqlSession, int orderNo, List<Integer> checkedCartNos) {

		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("orderNo", orderNo);           // ORDER_NO 전달
	    paramMap.put("checkedCartNos", checkedCartNos); // 장바구니 번호 리스트 전달

	    return sqlSession.insert("orderMapper.insertProductOrder", paramMap);
	}


	public Order selectOrder(SqlSessionTemplate sqlSession, int orderNo) {
		return sqlSession.selectOne("orderMapper.selectOrder", orderNo);
	}


	public List<ProductOrder> selectProductOrderList(SqlSessionTemplate sqlSession, int orderNo) {
		return sqlSession.selectList("orderMapper.selectProductOrderList", orderNo);
	}
}
