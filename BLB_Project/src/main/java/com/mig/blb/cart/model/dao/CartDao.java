package com.mig.blb.cart.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.cart.model.vo.Cart;

@Repository
public class CartDao {

//	public int selectCartListCount(SqlSessionTemplate sqlSession) {
//		return sqlSession.selectOne("cartMapper.selectCartListCount");
//	}

	public ArrayList<Cart> selectCartList(SqlSessionTemplate sqlSession, String memberId) {
		return (ArrayList)sqlSession.selectList("cartMapper.selectCartList", memberId);
	}

	public int deleteCartOne(SqlSessionTemplate sqlSession, int cartNo) {
		return sqlSession.delete("cartMapper.deleteCartOne", cartNo);
	}

//	public int updateCartOption(SqlSessionTemplate sqlSession, Cart ct) {
//		return sqlSession.update("cartMapper.updateCartOption", ct);
//	}


}
