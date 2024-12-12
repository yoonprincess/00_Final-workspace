package com.mig.blb.helpdesk.model.service.NoticeService;

import java.util.ArrayList;
import java.util.List;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Notice;
import com.mig.blb.helpdesk.model.vo.NoticeAtt;

public interface NoticeService {

	
	
	int selectListCount();

	ArrayList<Notice> selectList(PageInfo pi);

    int insertNotice(Notice n, List<NoticeAtt> noticeAttList);

	Notice selectNotice(int nno);

	ArrayList<NoticeAtt> selectNoticeAtt(int nno);
	
	int deleteNotice(int nno);

	int updateNotice(Notice n);

	

	
}
