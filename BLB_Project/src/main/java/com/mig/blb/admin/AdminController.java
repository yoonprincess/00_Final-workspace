package com.mig.blb.admin;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.helpdesk.model.service.FaqService.FaqService;
import com.mig.blb.helpdesk.model.service.InquiryService.InquiryService;
import com.mig.blb.helpdesk.model.service.NoticeService.NoticeService;
import com.mig.blb.helpdesk.model.vo.Faq;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.Notice;
import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;




@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FaqService faqService;
	
	@Autowired
	private InquiryService inquiryService;
	
	@Autowired
	private NoticeService noticeService;
	
	
	@GetMapping("admin.blb")
	public String admin() {
		
		return "admin/admin";
	}
	
	@GetMapping("adminMember.me")
	public ModelAndView adminMemberList(ModelAndView mv) {
		
		ArrayList<Member> mList = memberService.selectMemberList();
		mv.addObject("mList",mList);
		mv.setViewName("admin/admin_member2");
		return mv;
	}
	
	@PostMapping("adminDetailMember.me")
	public ModelAndView adminDetailMember(ModelAndView mv,
										String memberId
										) {
		
		System.out.println(memberId);
		Member member = memberService.selectMemberAdmin(memberId);
		Delivery d = memberService.selectDefaultDelivery(memberId);
		mv.addObject("d", d);
		System.out.println(d);
		mv.addObject("m",member);
		mv.setViewName("admin/admin_member_detail");
		return mv;
	}
	
	@GetMapping("adminFAQ.blb")
	public ModelAndView adminFAQList(ModelAndView mv) {
		
		ArrayList<Faq> fList = faqService.selectFaqList();
		mv.addObject("fList", fList);
		mv.setViewName("admin/admin_FAQ");
		return mv;
	}
	
	@GetMapping("adminInquiry.blb")
	public ModelAndView adminInquiryList(ModelAndView mv) {
		
		ArrayList<Inquiry> iList = inquiryService. selectAdminInquiryList();
		mv.addObject("iList",iList);
		mv.setViewName("admin/admin_inquiry");
		return mv;
	}
	
	@GetMapping("adminNotice.blb")
	public ModelAndView adminNoticeList(ModelAndView mv) {
		
		ArrayList<Notice> nList = noticeService. selectAdminNoticeList();
		mv.addObject("nList",nList);
		mv.setViewName("admin/admin_notice");
		return mv;
	}
}
