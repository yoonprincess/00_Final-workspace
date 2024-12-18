package com.mig.blb.member.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.helpdesk.model.service.InquiryService.InquiryService;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.order.model.service.OrderService;
import com.mig.blb.order.model.vo.Order;

import oracle.jdbc.proxy.annotation.Post;

@Controller
public class MyPageController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private InquiryService inquiryService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// 마이페이지 요청 
		@GetMapping("myPage.me")
		public ModelAndView myPage(ModelAndView mv
								, HttpSession session) {
			
			Member loginUser =(Member)session.getAttribute("loginUser");
			
			if( loginUser != null) {
				
				String memberId = ((Member)session.getAttribute("loginUser")).getMemberId();
				
				ArrayList<Inquiry> list = inquiryService.selectInquiryListTop4(memberId);
				
				mv.addObject("list", list);
				//System.out.println(list);
				
				mv.setViewName("member/myPage");
			
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
			return mv;
		}
		
		// 회원정보 수정 페이지 요청 
		@GetMapping("updateForm.me")
		public ModelAndView updateMemberForm(ModelAndView mv, HttpSession session) {
			
			Member loginUser =(Member)session.getAttribute("loginUser");
			
			if( loginUser != null) {
				
				Delivery d = memberService.selectDefaultDelivery(loginUser.getMemberId());
				
				session.setAttribute("d", d);
				
				mv.setViewName("member/updateMemberForm");
				
			}else {
				
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
					
			return mv;
		}
		
		// 회원정보 수정 요청( 주소정보 X) 
		@PostMapping(value="update.me")	
		public ModelAndView updateMember(ModelAndView mv,
											Member m,
											Delivery d,
											HttpSession session,
											String currentPwd,
											String newPwd,
											String ckPwd) {
				
			Member loginUser =(Member)session.getAttribute("loginUser");
			//System.out.println(currentPwd);
			//System.out.println(newPwd);
			//System.out.println(ckPwd);
			
			if(currentPwd != null && !currentPwd.isEmpty() 
								&& newPwd != null && !newPwd.isEmpty()
								&& ckPwd != null &&  !ckPwd.isEmpty()) {
				// 비번 변경이 있을 경우 
				System.out.println(m);
				if(bcryptPasswordEncoder.matches(currentPwd, loginUser.getMemberPwd())){
					// 현재비번 매치되면 
					//System.out.println("현재비번 잘 작성함!");
					
					String encPwd = bcryptPasswordEncoder.encode(newPwd);
					m.setMemberPwd(encPwd);
					
					int result = memberService.updateMember(m);
					int result2 = updateDelivery(d,m);
					if(result > 0 && result2>0) { 
					
						session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
						
						loginUser.setMemberPwd(encPwd); // 불러온 로그인 정보 비번에도 넣어주고 
						session.setAttribute("loginUser", loginUser); // 갱신된 로그인정보 다시 세션에넣고
						
						Member newMember = memberService.loginMember(m);
						Delivery delivery = memberService.selectDefaultDelivery(loginUser.getMemberId());
						mv.addObject("d", delivery);
						session.setAttribute("loginUser", newMember);
						
						mv.setViewName("member/updateMemberForm"); 
						
						//System.out.println("회원정보수정 비번변경포함 완");
					
					}else {
						
						//System.out.println("비번변경있는 회원정보수정실패?");
						session.setAttribute("alertMsg", "회원정보 수정 실패..");
						mv.setViewName("member/updateMemberForm");
						
					}
				
				} else{
					// 현재 비번 잘못됨
					
					session.setAttribute("alertMsg", "현재 비밀번호가 잘못되었습니다.");
					mv.setViewName("member/updateMemberForm");
					//System.out.println("현재비번잘못?");
				}	
				
			} else {
				// 비번변경없을 경우
				
				int result = memberService.updateMember(m);
				
				int result2 = updateDelivery(d,m);
				
				if(result > 0 && result2>0) { 
				
					
					Member newMember = memberService.loginMember(m);
					session.setAttribute("loginUser", newMember);// 정보갱신 	
					
					Delivery delivery = memberService.selectDefaultDelivery(loginUser.getMemberId());
					mv.addObject("d", delivery);
					
					session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
					mv.setViewName("member/updateMemberForm");
					
				
				}else {
				
					session.setAttribute("alertMsg", "회원정보 수정 실패..");
					mv.setViewName("member/updateMemberForm");
					//System.out.println(" 비번변경없이 회원정보수정실패?");
				}
			}
			
			return mv;
		}
			
		// 기본주소 변경 메소드 
		public int updateDelivery(Delivery d, Member m) {
			
			int result = 0;

			 // 로그 추가: Delivery 객체의 값 확인
			if(!d.getPostcode().isEmpty()) {

				d.setDeliPhone(m.getPhone()); // FK 연결
				d.setDeliName(m.getMemberName()); // FK 연결
				d.setMemberId(m.getMemberId());
				
				result = memberService.updateDelivery(d);
			}
			
			return result;
		}
		
	// 내 주문,배송조회 페이지 요청 
	@GetMapping("orderList.me")
	public ModelAndView myOrderList(ModelAndView mv,
									HttpSession session,
									Member m,
					   			 	@RequestParam(value = "year", required = false) String year,
		                            @RequestParam(value = "month", required = false) String month,
		                            @RequestParam(value = "day", required = false) String day,
		                            @RequestParam(value = "year1", required = false) String year1,
		                            @RequestParam(value = "month1", required = false) String month1,
		                            @RequestParam(value = "day1", required = false) String day1) {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
	    if (year == null || month == null || day == null || year1 == null || month1 == null || day1 == null) {

	    	Date today = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        String defaultDate = sdf.format(today);
	        
	        //System.out.println(defaultDate);
	        
	        String[] dateParts = defaultDate.split("-");
	        year1 = dateParts[0];
	        month1 = dateParts[1];
	        day1 = dateParts[2];

	        // 1개월 전 날짜 계산
	        Calendar calendar = Calendar.getInstance();
	        calendar.add(Calendar.MONTH, -1);
	        String startDate = sdf.format(calendar.getTime());
	        
	        //System.out.println(startDate);
	        
	        dateParts = startDate.split("-");
	        year = dateParts[0];
	        month = dateParts[1];
	        day = dateParts[2];
	    }		
	    
		HashMap<String, String> dateMap = new HashMap<>();
	    dateMap.put("year", year);
	    dateMap.put("month", month);
	    dateMap.put("day", day);
	    dateMap.put("year1", year1);
	    dateMap.put("month1", month1);
	    dateMap.put("day1", day1);
	    
	    dateMap.put("startDate",  String.format("%s-%s-%s", year, month, day));
	    dateMap.put("endDate",  String.format("%s-%s-%s", year1, month1, day1));
	    
		if( loginUser != null) {
			String memberId = loginUser.getMemberId();
			dateMap.put("memberId", memberId);
			
			ArrayList<Order> myOrder = orderService.selectMyOrderList(dateMap); 
		    
			HashMap<String, ArrayList<Order>> myListbyDate = new HashMap<>();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
			for (Order order : myOrder) {
				String orderDate = dateFormat.format(order.getOrderDate());
				myListbyDate.putIfAbsent(orderDate, new ArrayList<>());
				myListbyDate.get(orderDate).add(order);
			}
			
			mv.addObject("myOrder",myOrder);
			mv.addObject("myListbyDate",myListbyDate);
			mv.setViewName("member/myOrderList");
		
		}else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
		return mv;
	}
	
	// 내 주문,배송조회 기간별 검색요청 
	/*
	@GetMapping("searchOrderList.me")
	public ModelAndView myOrderList(ModelAndView mv,
									 HttpSession session,
									 @RequestParam("year") String year,
	                                 @RequestParam("month") String month,
	                                 @RequestParam("day") String day,
	                                 @RequestParam("year1") String year1,
	                                 @RequestParam("month1") String month1,
	                                 @RequestParam("day1") String day1) {
		
		HashMap<String, String> searchMap = new HashMap<>();
	    searchMap.put("year", year);
	    searchMap.put("month", month);
	    searchMap.put("day", day);
	    searchMap.put("year1", year1);
	    searchMap.put("month1", month1);
	    searchMap.put("day1", day1);
	    
	    searchMap.put("startDate",  String.format("%s-%s-%s", year, month, day));
	    searchMap.put("endDate",  String.format("%s-%s-%s", year1, month1, day1));

	    Member loginUser =(Member)session.getAttribute("loginUser");
	  
	    if( loginUser != null) {
	   
	    	String memberId = loginUser.getMemberId();
	    	searchMap.put("memberId", memberId);
	    	
	    	ArrayList<Order> myOrder = orderService.searchMyOrderList(searchMap); 
	    	// System.out.println(myOrder);
	    	
	    	HashMap<String, ArrayList<Order>> myListbyDate = new HashMap<>();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
			
			for (Order order : myOrder) {
				String orderDate = dateFormat.format(order.getOrderDate());
				myListbyDate.putIfAbsent(orderDate, new ArrayList<>());
				myListbyDate.get(orderDate).add(order);
			}
			mv.addObject("year", year);
		    mv.addObject("month", month);
		    mv.addObject("day", day);
		    mv.addObject("year1", year1);
		    mv.addObject("month1", month1);
		    mv.addObject("day1", day1);				
			
		    mv.addObject("myOrder",myOrder);
			mv.addObject("myListbyDate",myListbyDate);
			mv.setViewName("member/mySearchOrderList");
	    }else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
		
		return mv;
	}
	
	*/
	// 내 배송지조회 페이지 요청 
	@GetMapping("deliveryList.me")
	public ModelAndView myDeliveryList(ModelAndView mv, HttpSession session) {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		if( loginUser != null) {
			
			String memberId = loginUser.getMemberId();
			ArrayList<Delivery> dlist =  memberService.selectDeliveryList(memberId);
			
			for(Delivery d : dlist) {
				String maskingPhone = masking(d.getDeliPhone());
				d.setDeliPhone(maskingPhone);
				
				if(d.getDeliDefault().equals("Y")) {
					d.setDeliDefault("기본배송지");
				}else {
					d.setDeliDefault("");
				}
			}
			
			mv.addObject("dlist",dlist);
			mv.setViewName("member/myDeliveryList");
			
			
		
		}else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
		return mv;
	}
	
	// 전화번호 마스킹 함수 
	public String masking(String phoneNumber) {
		if (phoneNumber == null || phoneNumber.length()<10) {
			return phoneNumber;
		}
		String maskingPhone = phoneNumber.substring(0,3)+"-****-"+phoneNumber.substring(phoneNumber.length() - 4);
		return maskingPhone;
	}
	
	// 추가 배송지 등록 페이지 요청
	@GetMapping("enrollDeliveryForm.me")			
	public ModelAndView enrollDeliveryForm(ModelAndView mv
									, HttpSession session) {
		Member loginUser =(Member)session.getAttribute("loginUser");
			
		if( loginUser != null) {

			mv.setViewName("member/enrollDelivery");
		
		}else {
			
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
			
		return mv;
	}
	
	// 추가 배송지 등록 
	@PostMapping("addDelivery.me")
	public ModelAndView addDelivery(ModelAndView mv
									, HttpSession session
									, Delivery d) {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		if( loginUser != null) {
			
			d.setMemberId(loginUser.getMemberId());
			
			
			if(d.getDeliNickname() == null || d.getDeliNickname().isEmpty()) {
				
				d.setDeliNickname(d.getDeliName());
			}
			
			//System.out.println(d);
			
			int result = memberService.insertDelivery(d);
			
			if (result>0) {
				session.setAttribute("alertMsg", "배송지등록 성공!");
				mv.setViewName("redirect:/deliveryList.me");
			
			}else {
				session.setAttribute("alertMsg", "배송지등록 실패");
				mv.setViewName("member/enrollDelivery");
				
			}
			
		}else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
			
		return mv;	
	}
	
	// 내 배송지 수정 페이지 요청
		@GetMapping("updateDeliveryForm.me")			
		public ModelAndView updateDeliveryForm(ModelAndView mv
										, HttpSession session
										, @RequestParam("deliCode") String deliCode) {
			Member loginUser =(Member)session.getAttribute("loginUser");
				
			if( loginUser != null) {
				
				Delivery d = memberService.selectMemberDelivery(deliCode);
				//System.out.println(d);
				mv.addObject("d",d);
				mv.setViewName("member/updateDelivery");
			
			}else {
				
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
				
			return mv;
		}
		
	// 내 배송지 수정 요청 
		
		
		
		
	// 배송지 삭제 요청 
	@PostMapping("deleteDelivery.me")
	public ModelAndView deleteDelivery(ModelAndView mv
									, HttpSession session
									, String deliCode){
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		if( loginUser != null) {
			
			
			//System.out.println(deliCode);
			
			int result = memberService.deleteDelivery(deliCode);
			
			if (result>0) {
				
				session.setAttribute("alertMsg", "배송지 삭제!");
				mv.setViewName("member/myDeliveryList");
			
			}else {
				session.setAttribute("alertMsg", "배송지등록 실패");
				mv.setViewName("member/myDeliveryList");
				
			}
			
		}else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
			
		
		
		
		return mv;
	}
}


