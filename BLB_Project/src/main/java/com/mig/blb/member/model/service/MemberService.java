package com.mig.blb.member.model.service;

import java.util.ArrayList;

import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;

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
	
	
}
