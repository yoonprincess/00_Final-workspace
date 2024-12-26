package com.mig.blb.helpdesk.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Notice;
import com.mig.blb.helpdesk.model.vo.NoticeAtt;

@Repository
public class NoticeDao {

	public int selectListCount(SqlSessionTemplate sqlSession, String searchKeyword) {
		return sqlSession.selectOne("helpdeskMapper.selectListCount", searchKeyword);
	}

	public ArrayList<Notice> selectList(SqlSessionTemplate sqlSession, PageInfo pi, String searchKeyword) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectList", searchKeyword, rowBounds);
	}

	public int insertNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("helpdeskMapper.insertNotice", n);
	}
	
	public int insertNoticeAtt(SqlSessionTemplate sqlSession, List<NoticeAtt> na) {
		
		int result = 0;
		
		// NoticeAtt리스트의 길이만큼 반복하여 INSERT 쿼리 실행
		for(NoticeAtt att : na) {
			result += sqlSession.insert("helpdeskMapper.insertNoticeAtt", att);
		}
		
		return result;
	}
	
	public Notice selectNotice(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.selectOne("helpdeskMapper.selectNotice", nno);
	}
	
	// 공지사항 이전글 조회
	public Notice selectPreviousNotice(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.selectOne("helpdeskMapper.selectPreviousNotice", nno);
	}

	// 공지사항 다음글 조회
	public Notice selectNextNotice(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.selectOne("helpdeskMapper.selectNextNotice", nno);
	}
	
	public ArrayList<NoticeAtt> selectNoticeAtt(SqlSessionTemplate sqlSession, int nno) {
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectNoticeAtt", nno);
	}

	public int deleteNotice(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.update("helpdeskMapper.deleteNotice", nno);
	}
	
	public int updateNotice(SqlSessionTemplate sqlSession, Notice n) {
        return sqlSession.update("helpdeskMapper.updateNotice", n);
    }

	public int deleteNoticeAtt(SqlSessionTemplate sqlSession, int noticeAttNo) {
		return sqlSession.delete("helpdeskMapper.deleteNoticeAtt",noticeAttNo);
	}

	public ArrayList<Notice> selectSearchNoticeList(SqlSessionTemplate sqlSession, String searchKeyword, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		//System.out.println(searchKeyword);
		
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectSearchNoticeList", searchKeyword, rowBounds);
	}

	public int insertNoticeAtt(SqlSessionTemplate sqlSession, NoticeAtt newAtt) {
		return sqlSession.insert("helpdeskMapper.insertNewNotice", newAtt);
	}

	
	// 관리자
	public int selectAdminListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("helpdeskMapper.selectAdminListCount");
	}

	public ArrayList<Notice> selectAdminList(SqlSessionTemplate sqlSession, PageInfo pi) {
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectAdminList", pi);
	}

	public ArrayList<Notice> selectAdminNoticeList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectAdminNoticeList");
	}

	public int deleteAtt(SqlSessionTemplate sqlSession, String deleteFileName) {
		return sqlSession.delete("helpdeskMapper.deleteAtt", deleteFileName);
	}

	public int updateAtt(SqlSessionTemplate sqlSession, NoticeAtt na) {
		return sqlSession.update("helpdeskMapper.updateAtt", na);
	}

	

}
