package com.mig.blb.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.member.model.dao.MemberDao;
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
	public int updateMember(Member m) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int deleteMember(String memberId) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int idCheck(String checkId) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public ArrayList<Member> selectMemberList() {
		// TODO Auto-generated method stub
		return null;
	}

	

	
}
















