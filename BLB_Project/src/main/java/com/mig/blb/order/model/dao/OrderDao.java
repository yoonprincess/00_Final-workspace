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
import com.mig.blb.product.model.vo.Product;

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

	public int insertProductOrder(SqlSessionTemplate sqlSession, List<ProductOrder> productOrders) {

		int result = 0;
	    for (ProductOrder productOrder : productOrders) {
	        result += sqlSession.insert("orderMapper.insertProductOrder", productOrder);
	    }
	    return result;
	}


	public Order selectOrder(SqlSessionTemplate sqlSession, int orderNo) {
		return sqlSession.selectOne("orderMapper.selectOrder", orderNo);
	}


	public List<ProductOrder> selectProductOrderList(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.selectList("orderMapper.selectProductOrderList", orderNo);
	}


	public ArrayList<Order> selectMyOrder(SqlSessionTemplate sqlSession, String orderNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyOrder", orderNo);
	}


	public int updateOrderStatus(SqlSessionTemplate sqlSession, String merchantUid, String orderNo) {

		Map<String, String> params = new HashMap<>();
		params.put("orderNo", orderNo);
		params.put("merchantUid", merchantUid);
        return sqlSession.update("orderMapper.updateOrderStatus", params);
	}

	public Order selectOrderComplete(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.selectOne("orderMapper.selectOrderComplete", orderNo);
	}


	public List<Product> getSelectedProducts(SqlSessionTemplate sqlSession, List<Integer> optNos) {
		return sqlSession.selectList("productMapper.getSelectedProducts", optNos);
	}


	public Order selectCancelOrder(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.selectOne("orderMapper.selectOrderComplete", orderNo);
	}


	public List<Product> selectCancelProductOrders(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.selectOne("orderMapper.selectProductOrderList", orderNo);
	}


	public int selectOptNo(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.selectOne("orderMapper.selectOptNo", orderNo);
	}

	public int updateOrderCancel(SqlSessionTemplate sqlSession, String orderNo, String refundReason) {
		
		Map<String, String> params = new HashMap<>();
		params.put("orderNo", orderNo);
		params.put("refundReason", refundReason);
		
		return sqlSession.update("orderMapper.updateOrderCancel", params);
	}

}
