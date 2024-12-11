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
	public int selectListCount() {
		return noticeDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> selectList(PageInfo pi) {
		return noticeDao.selectList(sqlSession, pi);
	}

	@Override
	@Transactional
	public int insertNotice(Notice n, List<NoticeAtt> noticeAttList) {
		
		int result1 = noticeDao.insertNotice(sqlSession, n);
		int result2 = noticeDao.insertNoticeAtt(sqlSession, noticeAttList);
		
		return result1 * result2;
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
