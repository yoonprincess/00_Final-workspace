package com.mig.blb.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.member.model.vo.CertEmail;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.member.model.vo.Point;
import com.mig.blb.product.model.vo.Product;


@Repository 
public class MemberDao {

	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		
		// select문 (단일행조회) : selectOne 메소드 
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		
		// insert문  : insert 메소드 
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		// update문 : update 메소드 
		return sqlSession.update("memberMapper.updateMember",m);
	}

	public int deleteMember(SqlSessionTemplate sqlSession, String memberId) {
		// update문 : update 메소드 
		return sqlSession.update("memberMapper.deleteMember",memberId);
	}

	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		// select문 (단일행): selectOne 메소드 
		return sqlSession.selectOne("memberMapper.idCheck",checkId);
	}

	public ArrayList<Member> selectMemberList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectMemberList");
	}

	public int insertDelivery(SqlSessionTemplate sqlSession, Delivery d) {
		
		return sqlSession.insert("memberMapper.insertDelivery", d);
	}

	public int insertCertEmail(SqlSessionTemplate sqlSession, CertEmail certEmail) {
		
		return sqlSession.insert("memberMapper.insertCertEmail", certEmail);
	}

	public int selectCertEmail(SqlSessionTemplate sqlSession, CertEmail validate) {
	
		return sqlSession.selectOne("memberMapper.selectCertEmail", validate);
	}

	public int deleteCertEmail(SqlSessionTemplate sqlSession, CertEmail validate) {
		
		return sqlSession.delete("memberMapper.deleteCertEmail", validate);
	}

	public Delivery selectDefaultDelivery(SqlSessionTemplate sqlSession, String memberId) {
		
		return sqlSession.selectOne("memberMapper.selectDefaultDelivery", memberId);
	}
	public int updateDelivery(SqlSessionTemplate sqlSession, Delivery d) {
		
		String memberId = d.getMemberId();
		
		Delivery findDelivery = sqlSession.selectOne("memberMapper.selectDefaultDelivery",memberId);
		
		if(findDelivery != null) {
			
			return sqlSession.update("memberMapper.updateDelivery", d);
		
		}else {
			
			return sqlSession.insert("memberMapper.insertDelivery", d);
		}
	}

	public int validateMemberData(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.validateMemberData", m);
	}

	public String findMemberId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.findMemberId", m);
	}

	public Member checkMember(SqlSessionTemplate sqlSession, String ckMemberId) {
		return sqlSession.selectOne("memberMapper.checkMember", ckMemberId);
	}
	
	public int updateMemberPwd(SqlSessionTemplate sqlSession, String memberId, String encPwd) {
		
		Map<String, String> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("newPwd", encPwd);
		
		return sqlSession.update("memberMapper.updateMemberPwd",params);
	}


	public ArrayList<Delivery> selectDeliveryList(SqlSessionTemplate sqlSession, String memberId) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectDeliveryList",memberId);
	}

	public int deleteDelivery(SqlSessionTemplate sqlSession, int deliCode) {
		
		return sqlSession.delete("memberMapper.deleteDelivery", deliCode);
	
	}

	public Delivery selectMemberDelivery(SqlSessionTemplate sqlSession, int deliCode) {
		
		return sqlSession.selectOne("memberMapper.selectMemberDelivery", deliCode);
	}

	public int updateMyDelivery(SqlSessionTemplate sqlSession, Delivery d) {
		
	  return sqlSession.update("memberMapper.updateMyDelivery", d);
	}

	public int updateDeliDefault1(SqlSessionTemplate sqlSession,Delivery d) {
		
			return sqlSession.update("memberMapper.updateDeliDefault1", d);
	}
	
	public int updateDeliDefault2(SqlSessionTemplate sqlSession,Delivery d) {
	
		return sqlSession.update("memberMapper.updateDeliDefault2", d);
	
	}

	public int myWishListCount(SqlSessionTemplate sqlSession, String memberId) {
		
		
		return sqlSession.selectOne("memberMapper.myWishListCount",memberId);
	}

	public ArrayList<Product> selectMyWishList(SqlSessionTemplate sqlSession, String memberId, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyWishList",memberId,rowBounds);
	}

	public ArrayList<Product> selectMyWishTop4(SqlSessionTemplate sqlSession, String memberId) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyWishTop4",memberId);
	}

	public int deleteWish(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.delete("memberMapper.deleteWish",prodNo);
	}

	public int findSnsId(SqlSessionTemplate sqlSession, String snsId) {
		
		return sqlSession.selectOne("memberMapper.findSnsId", snsId);
	}

	public Member loginMember(SqlSessionTemplate sqlSession, String snsId) {
		return sqlSession.selectOne("memberMapper.kakaoLogin", snsId);
	}

	public int insertKakao(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertKakao", m);
	}

	public ArrayList<Point> selectMyPoints(SqlSessionTemplate sqlSession, HashMap<String, Object> dateMap) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyPoints", dateMap);
	}

	public int myPointListCount(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.myPointListCount", memberId);
	}

	public int deleteAllWish(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.delete("memberMapper.deleteAllWish",memberId);
	}

	public Member selectMemberAdmin(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.selectMemberAdmin",memberId);
	}

	public ArrayList<Delivery> selectDeliveryListAll(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectDeliveryListAll");
	}

	public int updateAdminMember(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.update("memberMapper.updateAdminMember",member);
	}

	public int updateDeliveryAdmin(SqlSessionTemplate sqlSession, Delivery deli) {
		return sqlSession.update("memberMapper.updateDeliveryAdmin",deli);
	}

	public List<Map<String, Object>> selectMemberCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("memberMapper.selectMemberCount");
	}

	public int insertWelcomePoint(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.insert("memberMapper.insertWelcomePoint",memberId);
	}

	
	

}
