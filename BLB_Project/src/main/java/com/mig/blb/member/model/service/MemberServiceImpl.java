package com.mig.blb.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.member.model.dao.MemberDao;
import com.mig.blb.member.model.vo.CertEmail;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;

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
		return null;
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
	@Override
	public ArrayList<Delivery> selectDeliveryList(String memberId) {
		
		return memberDao.selectDeliveryList(sqlSession,memberId);
	}
	@Override
	public int deleteDelivery(String deliCode) {
		
		return memberDao.deleteDelivery(sqlSession,deliCode);
	}
	
	@Override
	public Delivery selectMemberDelivery(String deliCode) {
		
		return memberDao.selectMemberDelivery(sqlSession,deliCode);
	}

}

















