package com.mig.blb.helpdesk.model.service.NoticeService;

import java.util.ArrayList;
import java.util.List;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Notice;
import com.mig.blb.helpdesk.model.vo.NoticeAtt;

public interface NoticeService {

	
	
	int selectListCount(String searchKeyword);

	ArrayList<Notice> selectList(PageInfo pi, String searchKeyword);

    int insertNotice(Notice n, List<NoticeAtt> noticeAttList);

	Notice selectNotice(int nno);

	ArrayList<NoticeAtt> selectNoticeAtt(int nno);
	
	int deleteNotice(int nno);

	int deleteNoticeAtt(int nno);

	int updateNotice(Notice n);

	ArrayList<Notice> selectSearchNoticeList(String searchKeywrod, PageInfo pi);

	// 첨부파일 단일 저장
	int insertNoticeAtt(NoticeAtt newAtt);

	Notice selectPreviousNotice(int nno);

	Notice selectNextNotice(int nno);

	int selectAdminListCount();

	ArrayList<Notice> selectAdminList(PageInfo pi);

	ArrayList<Notice> selectAdminNoticeList();

	int deleteAtt(String deleteFileName);

	int updateAtt(NoticeAtt na);
	
	
	
}
