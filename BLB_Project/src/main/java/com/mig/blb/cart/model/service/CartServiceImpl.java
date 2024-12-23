package com.mig.blb.cart.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mig.blb.cart.model.dao.CartDao;
import com.mig.blb.cart.model.vo.Cart;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private CartDao cartDao;

//	@Override
//	public int selectCartListCount() {
//		return cartDao.selectCartListCount(sqlSession);
//	}

	@Override
	public ArrayList<Cart> selectCartList(String memberId) {
		return cartDao.selectCartList(sqlSession, memberId);
	}

	@Override
	public int deleteCartOne(int cartNo) {
		return cartDao.deleteCartOne(sqlSession, cartNo);
	}

	@Override
	public int deleteCheckItems(String cartNos) {
		return cartDao.deleteCheckItems(sqlSession, cartNos);
	}

	@Override
	public int updateCartQty(int cartNo, int updatedQty) {
		return cartDao.updateCartQty(sqlSession, cartNo, updatedQty);
	}

	@Override
	public int updateCartOption(int cartNo, int updatedOptNo) {
		
		return cartDao.updateCartOption(sqlSession, cartNo, updatedOptNo);
	}

	@Override
	public int myCartCount(String memberId) {
	
		return cartDao.myCartCount(sqlSession,memberId);
	}

	@Override
	public int insertCart(Cart c) {
		return cartDao.insertCart(sqlSession,c);
	}

}