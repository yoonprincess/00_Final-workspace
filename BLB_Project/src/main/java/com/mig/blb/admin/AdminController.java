package com.mig.blb.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ModelAndView admin(ModelAndView mv) {
		// 회원 수 관련
		List<Map<String,Object>> memberCounts = memberService.selectMemberCount();
		
		mv.addObject("memberCounts",memberCounts);
		
		mv.setViewName( "admin/admin");
		
		return mv;
	}
	
	@GetMapping("adminMember.me")
	public ModelAndView adminMemberList(ModelAndView mv) {
		
		ArrayList<Member> mList = memberService.selectMemberList();
		mv.addObject("mList",mList);
		ArrayList<Delivery> dList = memberService.selectDeliveryListAll();
		
		Map<String, String> addressMap = new HashMap<>();
		for (Delivery d : dList) {
		    addressMap.put(d.getMemberId(), d.getDeliAddress());
		}
		mv.addObject("addressMap", addressMap);
		
		mv.setViewName("admin/admin_member");
		return mv;
	}
	
	@GetMapping("adminDetailMember.me")
	public ModelAndView adminDetailMember(ModelAndView mv,
										@RequestParam String memberId) {
		
		Member member = memberService.selectMemberAdmin(memberId);
		ArrayList<Delivery> dlist = memberService.selectDeliveryList(memberId);
		Delivery d = memberService.selectDefaultDelivery(memberId);
		mv.addObject("d",d);
		mv.addObject("dList", dlist);
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
