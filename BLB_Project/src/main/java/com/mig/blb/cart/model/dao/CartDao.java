package com.mig.blb.cart.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public int deleteCheckItems(SqlSessionTemplate sqlSession, String cartNos) {
		return sqlSession.delete("cartMapper.deleteCheckItems", cartNos);
	}

	public int updateCartQty(SqlSessionTemplate sqlSession, int cartNo, int updatedQty) {

		Map<String, Integer> params = new HashMap<>();
	    params.put("cartNo", cartNo);
	    params.put("updatedQty", updatedQty);
	    
	    return sqlSession.update("cartMapper.updateCartQuantity", params);
	}

	public int updateCartOption(SqlSessionTemplate sqlSession, int cartNo, int updatedOptNo) {
		
		Map<String, Integer> params = new HashMap<>();
		params.put("cartNo", cartNo);
		params.put("updatedOptNo", updatedOptNo);
		
		return sqlSession.update("cartMapper.updateCartOption", params);
	}

	public List<Cart> getSelectedCartItems(SqlSessionTemplate sqlSession, String memberId, List<Integer> checkedCartNos) {
        
		Map<String, Object> params = new HashMap<>();
        params.put("memberId", memberId);
        params.put("checkedCartNos", checkedCartNos);
        
        return sqlSession.selectList("cartMapper.getSelectedCartItems", params);
    }

	public int insertCart(SqlSessionTemplate sqlSession, Cart c) {
		
		return sqlSession.insert("memberMapper.insertCart", c);
	}

	public int myCartCount(SqlSessionTemplate sqlSession, String memberId) {
		
		return sqlSession.selectOne("memberMapper.myCartCount", memberId);
	}

	public Integer selectCart(SqlSessionTemplate sqlSession, Cart checkCart) {
	
		return sqlSession.selectOne("memberMapper.selectCart", checkCart);
	}

	public int selectCartQty(SqlSessionTemplate sqlSession, int cartNo) {

		return sqlSession.selectOne("memberMapper.selectCartQty", cartNo);
	}

	public int deleteSelectedCarts(SqlSessionTemplate sqlSession, List<Integer> checkedCartNos) {
		return sqlSession.delete("cartMapper.deleteSelectedCarts", checkedCartNos);
	}

}
