package com.mig.blb.helpdesk.model.service.NoticeService;

import java.util.ArrayList;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Notice;

public interface NoticeService {

	int selectListCount();

	ArrayList<Notice> selectList(PageInfo pi);

	
}
