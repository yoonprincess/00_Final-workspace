package com.mig.blb.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.member.model.dao.MemberDao;
import com.mig.blb.member.model.vo.CertEmail;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.member.model.vo.Point;
import com.mig.blb.product.model.vo.Product;

//@Component
@Service // Service 역할을 해주는 빈으로 등록할 것임을 명시한다!
public class MemberServiceImpl implements MemberService {
	
	//SqlSessionTemplate 객체를 얻어오는 과정 
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// MemberDao 객체 또한 빈으로 등록 후 자동으로 객체 얻어내자 !! 
	@Autowired
	private MemberDao memberDao;
	
	@Override

	public Member loginMember(Member m) {
		return memberDao.loginMember(sqlSession, m);
	}	
	@Override
	@Transactional 
	public int insertMember(Member m) {
		
		return  memberDao.insertMember(sqlSession, m);
	}
	
	@Override
	public Delivery selectDefaultDelivery(String memberId) {
		
		return memberDao.selectDefaultDelivery(sqlSession, memberId);
	}
	
	@Transactional 
	@Override
	public int updateMember(Member m) {
		
		return memberDao.updateMember(sqlSession, m);
	}
	
	@Override
	@Transactional
	public int updateDelivery(Delivery d) {
		
		return memberDao.updateDelivery(sqlSession,d);
	}
	
	
	@Transactional 
	@Override
	public int deleteMember(String memberId) {
		
		return memberDao.deleteMember(sqlSession,memberId);
	}
	
	@Override
	public int idCheck(String checkId) {
		
		return memberDao.idCheck(sqlSession, checkId);
	}
	
	@Override
	public ArrayList<Member> selectMemberList() {
		return memberDao.selectMemberList(sqlSession);
	}
	
	@Transactional
	@Override
	public int insertDelivery(Delivery d) {
		
		return  memberDao.insertDelivery(sqlSession, d);
	}
	
	@Transactional
	@Override
	public int insertCertEmail(CertEmail certEmail) {
		
		return memberDao.insertCertEmail(sqlSession,certEmail);
	}
	
	@Override
	public int selectCertEmail(CertEmail validate) {
		
		return memberDao.selectCertEmail(sqlSession,validate);
	}
	
	@Override
	@Transactional
	public int deleteCertEmail(CertEmail validate) {
		
		return memberDao.deleteCertEmail(sqlSession,validate);
	}
	
	@Override
	public int validateMemberData(Member m) {
		
		return memberDao.validateMemberData(sqlSession,m);
	}
	@Override
	public String findMemberId(Member m) {
		return memberDao.findMemberId(sqlSession,m);
	}
	@Override
	public Member checkMember(String ckMemberId) {
	
		return memberDao.checkMember(sqlSession,ckMemberId);
	}
	@Transactional
	@Override
	public int updateMemberPwd(String memberId, String encPwd) {
		return memberDao.updateMemberPwd(sqlSession,memberId,encPwd);
	}
	
	@Override
	public ArrayList<Delivery> selectDeliveryList(String memberId) {
		
		return memberDao.selectDeliveryList(sqlSession,memberId);
	}
	@Override
	public int deleteDelivery(int deliCode) {
		
		return memberDao.deleteDelivery(sqlSession,deliCode);
	}
	
	@Override
	public Delivery selectMemberDelivery(int deliCode) {
		
		return memberDao.selectMemberDelivery(sqlSession,deliCode);
	}

	@Override
	@Transactional
	public int updateMyDelivery(Delivery d) {
		
		return memberDao.updateMyDelivery(sqlSession,d);
	}
	
	@Override
	@Transactional
	public int updateDeliDefault(Delivery d) {
		int result1 = memberDao.updateDeliDefault1(sqlSession,d);
		int result2 = memberDao.updateDeliDefault2(sqlSession,d);
		
		if (result1 > 0 && result2 > 0) {
	        return 1;  
	    } else {
	        return 0; 
	    }
	}
	
	@Override
	public int myWishListCount(String memberId) {
		
		return memberDao.myWishListCount(sqlSession,memberId);
	}
	@Override
	public ArrayList<Product> selectMyWishList(String memberId, PageInfo pi) {
		return memberDao.selectMyWishList(sqlSession,memberId,pi);
	}
	@Override
	public ArrayList<Product> selectMyWishTop4(String memberId) {
		
		return memberDao.selectMyWishTop4(sqlSession,memberId);
	}
	@Transactional
	@Override
	public int deleteWish(int prodNo) {
		return memberDao.deleteWish(sqlSession,prodNo);
	}
	@Transactional
	@Override
	public int findSnsId(String snsId) {
		return memberDao.findSnsId(sqlSession, snsId);
	}
	@Override
	public Member loginMember(String snsId) {
		return memberDao.loginMember(sqlSession, snsId);
	}
	
	@Transactional
	@Override
	public int insertKakao(Member m) {
		return  memberDao.insertKakao(sqlSession, m);
	}
	@Override
	public ArrayList<Point> selectMyPoints(HashMap<String, Object> dateMap) {
		
		return memberDao.selectMyPoints(sqlSession, dateMap);
	}
	@Override
	public int myPointListCount(String memberId) {
		return memberDao.myPointListCount(sqlSession, memberId);
	}
	@Override
	public int deleteAllWish(String memberId) {
		return memberDao.deleteAllWish(sqlSession,memberId);
	}
	@Override
	public Member selectMemberAdmin(String memberId) {
		return memberDao.selectMemberAdmin(sqlSession,memberId);
	}
	@Override
	public ArrayList<Delivery> selectDeliveryListAll() {
		return memberDao.selectDeliveryListAll(sqlSession);
	}
	
	@Transactional
	@Override
	public int updateAdminMember(Member member) {
		return memberDao.updateAdminMember(sqlSession,member);
	}
	
	@Override
	public int updateDeliveryAdmin(Delivery deli) {
		return memberDao.updateDeliveryAdmin(sqlSession,deli);
	}
	@Override
	public List<Map<String, Object>> selectMemberCount() {
		return memberDao.selectMemberCount(sqlSession);
	}
	@Override
	public int insertWelcomePoint(String memberId) {
		
		return memberDao.insertWelcomePoint(sqlSession,memberId);
	}
	
	

}


