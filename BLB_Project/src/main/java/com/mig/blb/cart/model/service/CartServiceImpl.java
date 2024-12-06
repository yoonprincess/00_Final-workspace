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
	}}
