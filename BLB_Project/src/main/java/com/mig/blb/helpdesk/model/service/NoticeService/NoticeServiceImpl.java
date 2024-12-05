package com.mig.blb.helpdesk.model.service.NoticeService;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.dao.NoticeDao;
import com.mig.blb.helpdesk.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public int selectListCount() {
		return noticeDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> selectList(PageInfo pi) {
		return noticeDao.selectList(sqlSession, pi);
	}

	@Override
	public int insertNotice(Notice n) {
		return noticeDao.insertNotice(sqlSession, n);
	}
	
	@Override
	public int increaseCount(int nno) {
		return noticeDao.increaseCount(sqlSession, nno);
	}

	@Override
	public Notice selectNotice(int nno) {
		return noticeDao.selectNotice(sqlSession, nno);
	}

	@Override
	public int deleteNotice(int nno) {
		return noticeDao.deleteNotice(sqlSession, nno);
	}

	@Override
	public int updateNotice(Notice n) {
		return noticeDao.updateNotice(sqlSession, n);
	}

	

}
