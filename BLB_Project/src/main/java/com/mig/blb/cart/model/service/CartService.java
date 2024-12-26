package com.mig.blb.cart.model.service;

import java.util.ArrayList;
import java.util.List;

import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.product.model.vo.Product;

public interface CartService {
	
	// 장바구니 목록 조회 서비스 + 페이징 처리
	// 장바구니 총 개수 조회
//	int selectCartListCount();
	
	// 장바구니 목록 조회
	ArrayList<Cart> selectCartList(String MemberId);

	// 장바구니 X버튼으로 1개 상품만 삭제
	int deleteCartOne(int cartNo);

	// 장바구니 체크박스 선택 삭제
	int deleteCheckItems(String cartNos);

	// 장바구니 수량 변경
	int updateCartQty(int cartNo, int updatedQty);

	// 장바구니 선택 옵션 변경
	int updateCartOption(int cartNo, int updatedOptNo);

	// 체크된 장바구니 상품 주문서에서 조회용
	List<Cart> getSelectedCartItems(String memberId, List<Integer> checkedCartNos);

	int insertCart(Cart c);

	int myCartCount(String memberId);

	Integer selectCart(Cart checkCart);

	int selectCartQty(int cartNo);

	// 장바구니 결제 > 결제 완료 장바구니 상품 삭제
	int deleteSelectedCarts(List<Integer> checkedCartNos);

}
