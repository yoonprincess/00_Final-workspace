package com.mig.blb.helpdesk.model.service.NoticeService;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.dao.NoticeDao;
import com.mig.blb.helpdesk.model.vo.Notice;
import com.mig.blb.helpdesk.model.vo.NoticeAtt;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public int selectListCount(String searchKeyword) {
		return noticeDao.selectListCount(sqlSession, searchKeyword);
	}

	@Override
	public ArrayList<Notice> selectList(PageInfo pi,String searchKeyword) {
		return noticeDao.selectList(sqlSession, pi, searchKeyword);
	}

	@Override
	@Transactional
	public int insertNotice(Notice n, List<NoticeAtt> noticeAttList) {
		
		int result1 = noticeDao.insertNotice(sqlSession, n);
		int result2 = noticeDao.insertNoticeAtt(sqlSession, noticeAttList);
		
		return result1 + result2;
	}
	
	@Override
	public Notice selectNotice(int nno) {
		return noticeDao.selectNotice(sqlSession, nno);
	}
	
	// 공지사항 이전글 조회
	@Override
	public Notice selectPreviousNotice(int nno) {
		return noticeDao.selectPreviousNotice(sqlSession, nno);
	}

	// 공지사항 다음글 조회
	@Override
	public Notice selectNextNotice(int nno) {
		return noticeDao.selectNextNotice(sqlSession, nno);
	}
	
	@Override
	public ArrayList<NoticeAtt> selectNoticeAtt(int nno) {
		return noticeDao.selectNoticeAtt(sqlSession, nno);
	}

	@Override
	public int deleteNotice(int nno) {
		return noticeDao.deleteNotice(sqlSession, nno);
	}

	@Override
	public int deleteNoticeAtt(int nno) {
		return noticeDao.deleteNoticeAtt(sqlSession, nno);
	}

	@Override
	public int updateNotice(Notice n) {
		return noticeDao.updateNotice(sqlSession, n);
	}

	@Override
	public ArrayList<Notice> selectSearchNoticeList(String searchKeyword, PageInfo pi) {
		return noticeDao.selectSearchNoticeList(sqlSession, searchKeyword, pi);
	}

	@Override
	public int insertNoticeAtt(NoticeAtt newAtt) {
		return noticeDao.insertNoticeAtt(sqlSession, newAtt);
	}

	// 관리자
	@Override
	public int selectAdminListCount() {
		return noticeDao.selectAdminListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> selectAdminList(PageInfo pi) {
		return noticeDao.selectAdminList(sqlSession, pi);
	}

	@Override
	public ArrayList<Notice> selectAdminNoticeList() {
		return noticeDao.selectAdminNoticeList(sqlSession);
	}

	@Override
	public int deleteAtt(String deleteFileName) {
		return noticeDao.deleteAtt(sqlSession, deleteFileName);
	}

	@Override
	public int updateAtt(NoticeAtt na) {
		return noticeDao.updateAtt(sqlSession, na);
	}

	

	
}


