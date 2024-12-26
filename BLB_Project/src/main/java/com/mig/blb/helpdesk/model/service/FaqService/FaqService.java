package com.mig.blb.helpdesk.model.service.FaqService;

import java.util.ArrayList;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Faq;

public interface FaqService {

	int selectFaqListCount();

	ArrayList<Faq> selectFaqList(PageInfo pi);

	int insertFaq(Faq f);

	int deleteFaq(int fno);

	int updateFaq(Faq f);

	ArrayList<Faq> selectFaqList();

}
