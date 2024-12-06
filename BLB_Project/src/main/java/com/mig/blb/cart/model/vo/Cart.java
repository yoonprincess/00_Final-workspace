package com.mig.blb.cart.model.vo;

public class Cart {
	
	private int cartNo;			//	CART_NO	NUMBER
	private String memberId;	//	MEMBER_ID	VARCHAR2(20 BYTE)
	private int probNo;			//	PROD_NO	NUMBER
	private int optNo;			//	OPT_NO	NUMBER
	private int cartQty;		//	CART_QTY	NUMBER
	
	public Cart() {}

	public Cart(int cartNo, String memberId, int probNo, int optNo, int cartQty) {
		super();
		this.cartNo = cartNo;
		this.memberId = memberId;
		this.probNo = probNo;
		this.optNo = optNo;
		this.cartQty = cartQty;
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getProbNo() {
		return probNo;
	}

	public void setProbNo(int probNo) {
		this.probNo = probNo;
	}

	public int getOptNo() {
		return optNo;
	}

	public void setOptNo(int optNo) {
		this.optNo = optNo;
	}

	public int getCartQty() {
		return cartQty;
	}

	public void setCartQty(int cartQty) {
		this.cartQty = cartQty;
	}

	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", memberId=" + memberId + ", probNo=" + probNo + ", optNo=" + optNo
				+ ", cartQty=" + cartQty + "]";
	}
	
}
