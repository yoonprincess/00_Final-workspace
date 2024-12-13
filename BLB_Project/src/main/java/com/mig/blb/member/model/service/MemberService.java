package com.mig.blb.member.model.service;

import java.util.ArrayList;

import com.mig.blb.member.model.vo.CertEmail;
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

	// 이메일 인증코드 발송용 
	int insertCertEmail(CertEmail certEmail);
	
	// 이메일 인증코드 대조용 + 인증시간 5분
	int selectCertEmail(CertEmail validate);
	
	// 발송한 인증데이터 삭제용
	int deleteCertEmail(CertEmail validate);
	
	// 기본 주소 변경 
	int updateDelivery(Delivery d);

	// 기본주소 조회
	Delivery selectDefaultDelivery(String memberId);
	
	// 비번찾기용 회원정보 확인 
	int validateMemberData(Member m);
	
	// 아이디찾기용 회원정보확인
	String findMemberId(Member m);
	
	
	
}
