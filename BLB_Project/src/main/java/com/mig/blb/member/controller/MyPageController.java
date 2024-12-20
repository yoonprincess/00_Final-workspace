package com.mig.blb.member.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.service.InquiryService.InquiryService;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.member.model.vo.PageforOrders;
import com.mig.blb.member.model.vo.PaginationOrders;
import com.mig.blb.order.model.service.OrderService;
import com.mig.blb.order.model.vo.Order;
import com.mig.blb.review.model.service.ReviewService;

@Controller
public class MyPageController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private InquiryService inquiryService;
	
	@Autowired
	private ReviewService reviewService;
	
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
				
				HashMap<String, Integer> myOrderCounts = orderService.myOrderCounts(memberId);
				
				int listCount = reviewService.myReviewListCount(loginUser.getMemberId());
				
				
				mv.addObject("myOrderComplete", myOrderCounts.get("COMPLETE"));
				mv.addObject("myOrderWait", myOrderCounts.get("WAIT"));
				
				mv.addObject("list", list);
				
				session.setAttribute("listCount", listCount); // menubar.jsp 

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
				
				//System.out.println(m);
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
				d.setDeliNickname(d.getDeliName());
				d.setDeliDefault("Y");
				
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
		                            @RequestParam(value = "day1", required = false) String day1,
		                            @RequestParam(value="ppage", defaultValue="1")int currentPage) throws ParseException {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
	    if (year == null || month == null || day == null || year1 == null || month1 == null || day1 == null) {

	    	Date today = new Date();
	       
	    	String defaultDate = sdf.format(today);
	        
	        String[] dateParts = defaultDate.split("-");
	        year1 = dateParts[0];
	        month1 = dateParts[1];
	        day1 = dateParts[2];

	        // 1개월 전 날짜 계산
	        Calendar calendar = Calendar.getInstance();
	        calendar.add(Calendar.MONTH, -1);
	        String startDate = sdf.format(calendar.getTime());
	        
	        
	        dateParts = startDate.split("-");
	        year = dateParts[0];
	        month = dateParts[1];
	        day = dateParts[2];
	    }		
	    
	   
		HashMap<String, Object> dateMap = new HashMap<>();
	    dateMap.put("year", year);
	    dateMap.put("month", month);
	    dateMap.put("day", day);
	    dateMap.put("year1", year1);
	    dateMap.put("month1", month1);
	    dateMap.put("day1", day1);
	    
	    
	    
		if( loginUser != null) {
			String memberId = loginUser.getMemberId();
			dateMap.put("memberId", memberId);
			
			Date startDate = sdf.parse(String.format("%s-%s-%s", year, month, day));
		    Date endDate = sdf.parse(String.format("%s-%s-%s", year1, month1, day1));
		    
		    dateMap.put("startDate", startDate);
		    dateMap.put("endDate", endDate);
			    
			ArrayList<Order> myOrders = orderService.selectAllMyOrders(dateMap);
			
			LinkedHashMap<String, ArrayList<Order>> myListbyDate = new LinkedHashMap<>();
						
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
			for (Order order : myOrders) {
				String orderDate = dateFormat.format(order.getOrderDate());
				myListbyDate.putIfAbsent(orderDate, new ArrayList<>());
				myListbyDate.get(orderDate).add(order);
			}
			
			// 페이징처리
			int boardLimit = 3;
			// 한 번에 보여줄 페이지 수
			int pageLimit = 5;
			
			int totalDateGroups = myListbyDate.size();
			
			// 현재페이지에 해당 날짜그룹만 
			int startIndex = (currentPage - 1) * boardLimit;
			int endIndex = Math.min(startIndex + boardLimit, totalDateGroups);
			
			LinkedHashMap<String, ArrayList<Order>> pagedOrdersByDate = new LinkedHashMap<>();
		    List<String> dateKeys = new ArrayList<>(myListbyDate.keySet());
		    
		    for(int i = startIndex; i < endIndex; i++) {
		        String date = dateKeys.get(i);
		        pagedOrdersByDate.put(date, myListbyDate.get(date));
		    }
		    
		    // PageInfo 객체 생성
		    PageforOrders po = PaginationOrders.getPageforOrders(currentPage, pageLimit, boardLimit, totalDateGroups);
		    
		    // 주문 상태 카운트
		    HashMap<String, Integer> myOrderCounts = orderService.myOrderCounts(memberId);

		    mv.addObject("myOrderComplete", myOrderCounts.get("COMPLETE"));
			mv.addObject("myOrderWait", myOrderCounts.get("WAIT"));
			
			mv.addObject("pi",po);
			mv.addObject("myListbyDate",pagedOrdersByDate);
			mv.setViewName("member/myOrderList");
		
		}else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
		return mv;
	}
	
	
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
			
			d.setHomeAddressYN("N");
			
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
										, @RequestParam("deliCode") int deliCode) {
			
			Member loginUser =(Member)session.getAttribute("loginUser");
				
			if( loginUser != null) {
				
				Delivery d = memberService.selectMemberDelivery(deliCode);
				mv.addObject("d",d);
				mv.setViewName("member/updateDelivery");
			
			}else {
				
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
				
			return mv;
		}
		
	// 내 배송지 수정 요청 
		@PostMapping("updateMyDelivery.me")
		public ModelAndView updateDelivery(ModelAndView mv,
											HttpSession session,
											Delivery d,
											String deliDefault) {
			
			Member loginUser =(Member)session.getAttribute("loginUser");
	
			d.setMemberId(loginUser.getMemberId());
			d.setDeliDefault(deliDefault);
			
			int result = memberService.updateMyDelivery(d);
			
			if(result>0) {
				int deliCode = d.getDeliCode();
				Delivery updateDelivery = memberService.selectMemberDelivery(deliCode);
				mv.addObject("d",updateDelivery);
				session.setAttribute("alertMsg", "배송지 정보가 수정되었습니다.");
				mv.setViewName("member/updateDelivery");
			
			}else {
				
				session.setAttribute("alertMsg", "배송지수정실패");
				mv.setViewName("member/myDeliveryList");
			}
			return mv;
		}
		
		// 기본 배송지로 설정하기
		@PostMapping("updateDeliDefault.me")
		public ModelAndView updateDeliDefault(ModelAndView mv,
										HttpSession session,
										int deliCode) {
			Member loginUser = (Member)session.getAttribute("loginUser");
			if( loginUser != null) {
				
				Delivery d = new Delivery();
		        d.setMemberId(loginUser.getMemberId());
		        d.setDeliCode(deliCode);
				
				int result = memberService.updateDeliDefault(d);
				
				if(result>0) {
					
					mv.addObject("deliDefault", "Y"); 
					mv.setViewName("member/myDeliveryList");
				}else {
					
					session.setAttribute("alertMsg", "배송지등록 실패");
					mv.addObject("deliDefault", "N"); 
					mv.setViewName("member/myDeliveryList");
				}
			}
			
			return mv;
		}
		
		
	// 배송지 삭제 요청 
	@PostMapping("deleteDelivery.me")
	public ModelAndView deleteDelivery(ModelAndView mv
									, HttpSession session
									, int deliCode){
		
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
	
	// 내 리뷰 목록 페이지요청 
		@GetMapping("reviewList.me")
		public ModelAndView myOrderList(ModelAndView mv,
										HttpSession session,
										Member m,						   			 
			                            @RequestParam(value="ppage", defaultValue="1")int currentPage){
			
			Member loginUser =(Member)session.getAttribute("loginUser");
			
		    
			if( loginUser != null) {
				String memberId = loginUser.getMemberId();
				
				// 페이징처리
				int boardLimit = 10;
				
				// 한 번에 보여줄 페이지 수
				int pageLimit = 5;
				int listCount = reviewService.myReviewListCount(loginUser.getMemberId());
				//System.out.println("리뷰갯수 :"  + listCount);
				
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 
							 pageLimit, boardLimit);
				
				List<Map<String, Object>> rlist = reviewService.selectMyReviewList(loginUser.getMemberId(),pi); 
			    //System.out.println(rlist);
				
				mv.addObject("pi",pi);
				mv.addObject("rlist",rlist);
				mv.addObject("listCount",listCount);
				
				mv.setViewName("member/myReviewList");
				
			
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
			return mv;
		}
	
		// 내 상품문의 페이지 요청 
		@GetMapping("productQna.me")
		public ModelAndView myProdQnaList(ModelAndView mv,
										HttpSession session,
										Member m,
						   			 	@RequestParam(value = "year", required = false) String year,
			                            @RequestParam(value = "month", required = false) String month,
			                            @RequestParam(value = "day", required = false) String day,
			                            @RequestParam(value = "year1", required = false) String year1,
			                            @RequestParam(value = "month1", required = false) String month1,
			                            @RequestParam(value = "day1", required = false) String day1,
			                            @RequestParam(value="ppage", defaultValue="1")int currentPage) throws ParseException {
			
			Member loginUser =(Member)session.getAttribute("loginUser");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
		    if (year == null || month == null || day == null || year1 == null || month1 == null || day1 == null) {

		    	Date today = new Date();
		       
		    	String defaultDate = sdf.format(today);
		        
		        String[] dateParts = defaultDate.split("-");
		        year1 = dateParts[0];
		        month1 = dateParts[1];
		        day1 = dateParts[2];

		        // 1개월 전 날짜 계산
		        Calendar calendar = Calendar.getInstance();
		        calendar.add(Calendar.MONTH, -1);
		        String startDate = sdf.format(calendar.getTime());
		        
		        
		        dateParts = startDate.split("-");
		        year = dateParts[0];
		        month = dateParts[1];
		        day = dateParts[2];
		    }		
		    
		   
			HashMap<String, Object> dateMap = new HashMap<>();
		    dateMap.put("year", year);
		    dateMap.put("month", month);
		    dateMap.put("day", day);
		    dateMap.put("year1", year1);
		    dateMap.put("month1", month1);
		    dateMap.put("day1", day1);
		    
		    Date startDate = sdf.parse(String.format("%s-%s-%s", year, month, day));
		    Date endDate = sdf.parse(String.format("%s-%s-%s", year1, month1, day1));
		    
		    dateMap.put("startDate", startDate);
		    dateMap.put("endDate", endDate);
		    
			if( loginUser != null) {
				String memberId = loginUser.getMemberId();
				dateMap.put("memberId", memberId);
				System.out.println(dateMap);
				
				// 페이징처리
				int boardLimit = 10;
				
				// 한 번에 보여줄 페이지 수
				int pageLimit = 5;
				
				int listCount = inquiryService.myProdQnaListCount(loginUser.getMemberId());
				
				System.out.println("qlistCount : " + listCount);
				
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 
							 pageLimit, boardLimit);
				
				List<Map<String, Object>> qlist = inquiryService.selectMyProdQnaList(loginUser.getMemberId(),pi); 
			    System.out.println(qlist);
				
				mv.addObject("pi",pi);
				mv.addObject("qlist",qlist);
				mv.setViewName("member/myOrderList");
			
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
			
			return null;
		}
		
		 
}


