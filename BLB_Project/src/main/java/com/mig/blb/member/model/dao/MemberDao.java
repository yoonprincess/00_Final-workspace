package com.mig.blb.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.member.model.vo.Member;


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

	public int deleteMember(SqlSessionTemplate sqlSession, String userId) {
		// update문 : update 메소드 
		return sqlSession.update("memberMapper.deleteMember",userId);
	}

	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		// select문 (단일행): selectOne 메소드 
		return sqlSession.selectOne("memberMapper.idCheck",checkId);
	}

	public ArrayList<Member> selectMemberList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectMemberList");
	}

}