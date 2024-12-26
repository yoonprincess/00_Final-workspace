package com.mig.blb.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.member.model.vo.CertEmail;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.member.model.vo.Point;
import com.mig.blb.order.model.vo.Order;
import com.mig.blb.product.model.vo.Product;

public interface MemberService {

	// 로그인 서비스 (select) 
	Member loginMember(Member m);
	
	// 회원가입서비스 (insert)
	int insertMember(Member m);
	
	// 회원정보수정 서비스 (update)
	int updateMember(Member m);
	
	// 회원탈퇴 서비스 (delete : update 구문 이용할 것 )
	int deleteMember(String memberId);
	
	// 아이디 중복체크 서비스 (select)
	int idCheck(String checkId);
	
	// 회원 전체 조회 서비스 (select)
	ArrayList<Member> selectMemberList();

	// 회원가입시 기본배송지 등록
	int insertDelivery(Delivery d);

	// 이메일 인증코드 발송용 
	int insertCertEmail(CertEmail certEmail);
	
	// 이메일 인증코드 대조용 + 인증시간 5분
	int selectCertEmail(CertEmail validate);
	
	// 발송한 인증데이터 삭제용
	int deleteCertEmail(CertEmail validate);
	
	// 기본주소 변경 
	int updateDelivery(Delivery d);

	// 회원주소 조회
	Delivery selectDefaultDelivery(String memberId);
	
	// 비번찾기용 회원정보 확인 
	int validateMemberData(Member m);
	
	// 아이디찾기용 회원정보확인
	String findMemberId(Member m);
	
	// 비번변경용 회원조회용
	Member checkMember(String ckMemberId);
	
	// 새비번으로변경
	int updateMemberPwd(String memberId, String encPwd);

	// 내 배송지 목록조회용
	ArrayList<Delivery> selectDeliveryList(String memberId);
	
	// 내 배송지 삭제
	int deleteDelivery(int deliCode);
	
	// 수정할 내 배송지 조회
	Delivery selectMemberDelivery(int deliCode);
	
	// 내 배송지 정보 수정
	int updateMyDelivery(Delivery d);
	
	// 기본배송지로 설정
	int updateDeliDefault(Delivery d);
	
	// 찜한 제품 갯수조회용
	int myWishListCount(String memberId);

	ArrayList<Product> selectMyWishList(String memberId, PageInfo pi);

	ArrayList<Product> selectMyWishTop4(String memberId);

	int deleteWish(int prodNo);

	int findSnsId(String snsId);

	Member loginMember(String snsId);

	int insertKakao(Member m);

	ArrayList<Point> selectMyPoints(HashMap<String, Object> dateMap);

	int myPointListCount(String memberId);

	int deleteAllWish(String memberId);

	Member selectMemberAdmin(String memberId);

	ArrayList<Delivery> selectDeliveryListAll();

	int updateAdminMember(Member member);

	int updateDeliveryAdmin(Delivery deli);

	List<Map<String, Object>> selectMemberCount();

	int insertWelcomePoint(String memberId);



	
	
	
}
