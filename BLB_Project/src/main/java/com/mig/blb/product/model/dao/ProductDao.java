package com.mig.blb.product.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductAtt;
import com.mig.blb.wish.model.vo.Wish;

@Repository
public class ProductDao {

	public int selectProductCount(SqlSessionTemplate sqlSession, Map<String, Object> params) {
		return sqlSession.selectOne("productMapper.selectProductCount", params);
	}

	public ArrayList<Product> selectProductList(SqlSessionTemplate sqlSession, PageInfo pi, Map<String, Object> params) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("productMapper.selectProductList", params, rowBounds);
	}

	public int increaseViewCount(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.update("productMapper.increaseViewCount", prodNo);
	}

	public Product selectProduct(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.selectOne("productMapper.selectProduct", prodNo);
	}

	public ArrayList<ProductAtt> selectProductAtt(SqlSessionTemplate sqlSession, int prodNo) {
		return (ArrayList)sqlSession.selectList("productMapper.selectProductAtt", prodNo);
	}

	public int selectProdInquiryCount(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.selectOne("productMapper.selectProdInquiryCount", prodNo);
	}

	public ArrayList<Inquiry> selectProdInquiryList(SqlSessionTemplate sqlSession, PageInfo qnaPi, int prodNo) {
		
		int offset = (qnaPi.getCurrentPage() - 1) * qnaPi.getBoardLimit();
		int limit = qnaPi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("productMapper.selectProdInquiryList", prodNo, rowBounds);
	}

	public boolean checkPurchase(SqlSessionTemplate sqlSession, int prodNo, String memberId) {
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("prodNo", prodNo);
		paramMap.put("memberId", memberId);
		
		return (int)sqlSession.selectOne("productMapper.checkPurchase", paramMap) > 0;
	}

	public List<Map<String, Object>> getPurchaseInfo(SqlSessionTemplate sqlSession, String memberId, int prodNo) {
		return sqlSession.selectList("productMapper.getPurchaseInfo", Map.of("memberId", memberId, "prodNo", prodNo));
	}

	public Map<String, Object> getInfoByRevNo(SqlSessionTemplate sqlSession, int revNo) {
		return sqlSession.selectOne("productMapper.getInfoByRevNo", revNo);
	}

	public int insertProdInquiry(SqlSessionTemplate sqlSession, Inquiry inquiry) {
		return sqlSession.insert("productMapper.insertProdInquiry", inquiry);
	}

	public int deleteProdInquiry(SqlSessionTemplate sqlSession, int inquiryNo) {
		return sqlSession.update("productMapper.deleteProdInquiry", inquiryNo);
	}

	public Inquiry selectProdInquiry(SqlSessionTemplate sqlSession, int inquiryNo) {
		return sqlSession.selectOne("productMapper.selectProdInquiry", inquiryNo);
	}

	public int updateProdInquiry(SqlSessionTemplate sqlSession, Inquiry inquiry) {
		return sqlSession.update("productMapper.updateProdInquiry", inquiry);
	}

	public int isWished(SqlSessionTemplate sqlSession, Wish wish) {
		return sqlSession.selectOne("productMapper.isWished", wish);
	}

	public int addWish(SqlSessionTemplate sqlSession, Wish wish) {
		return sqlSession.insert("productMapper.addWish", wish);
	}

	public int removeWish(SqlSessionTemplate sqlSession, Wish wish) {
		return sqlSession.delete("productMapper.removeWish", wish);
	}

	public Product getInfoByProdNo(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.selectOne("productMapper.getInfoByProdNo", prodNo);
	}

	public Cart getCartByMemberAndOption(SqlSessionTemplate sqlSession, String memberId, int optNo) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("optNo", optNo);
        return sqlSession.selectOne("productMapper.getCartByMemberAndOption", paramMap);
	}

	public int updateCart(SqlSessionTemplate sqlSession, Cart cart) {
		return sqlSession.update("productMapper.updateCart", cart);
	}

	public int insertCart(SqlSessionTemplate sqlSession, Cart cart) {
		return sqlSession.insert("productMapper.insertCart", cart);
	}

}
