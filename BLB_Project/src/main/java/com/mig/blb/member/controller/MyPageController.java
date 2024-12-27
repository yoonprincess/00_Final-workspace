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
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.cart.model.service.CartService;
import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.service.InquiryService.InquiryService;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.member.model.vo.PageforOrders;
import com.mig.blb.member.model.vo.PaginationOrders;
import com.mig.blb.member.model.vo.Point;
import com.mig.blb.option.model.service.OptionService;
import com.mig.blb.option.model.vo.Option;
import com.mig.blb.order.model.service.OrderService;
import com.mig.blb.order.model.vo.Order;
import com.mig.blb.product.model.service.ProductService;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.review.model.service.ReviewService;
import com.mig.blb.review.model.vo.Review;

@Controller
public class MyPageController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private OptionService optionService;
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
				ArrayList<Inquiry> qlist = inquiryService.selectProdQnaTop4(memberId);
				ArrayList<Product> wlist = memberService.selectMyWishTop4(memberId); 
				
				HashMap<String, Integer> myOrderCounts = orderService.myOrderCounts(memberId);
				
				int listCount = reviewService.myReviewListCount(memberId);
				int cartCount = cartService.myCartCount(memberId);
				
				mv.addObject("myOrderComplete", myOrderCounts.get("COMPLETE"));
				mv.addObject("myOrderDelivery", myOrderCounts.get("DELIVERY"));
				mv.addObject("myOrderWait", myOrderCounts.get("WAIT"));
				
				mv.addObject("list", list);
				mv.addObject("qlist", qlist);
				mv.addObject("wlist",wlist);
				
				mv.addObject("cartCount",cartCount);
				session.setAttribute("listCount", listCount); // menubar.jsp 
				

				mv.setViewName("member/myPage");
			
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
			return mv;
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
		    
		    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    String formattedStartDate = formatter.format(startDate);
			    String formattedEndDate = formatter.format(endDate);
		    dateMap.put("startDate", formattedStartDate);
		    dateMap.put("endDate", formattedEndDate);
			    System.out.println(dateMap);
			ArrayList<Order> myOrders = orderService.selectAllMyOrders(dateMap);
			System.out.println(myOrders);
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
		    
		    //리뷰 있는지 여부 
		  
		    mv.addObject("myOrderComplete", myOrderCounts.get("COMPLETE"));
			mv.addObject("myOrderWait", myOrderCounts.get("WAIT"));
			mv.addObject("myOrderDelivery", myOrderCounts.get("DELIVERY"));
			
			mv.addObject("pi",po);
			mv.addObject("myListbyDate",pagedOrdersByDate);
			mv.setViewName("member/myOrderList");
		
		}else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
		return mv;
	}
	
	// 주문 상세페이지 요청 
	@GetMapping("orderDetail.me")
	public ModelAndView myOrderDetail(ModelAndView mv
								, HttpSession session,
								@RequestParam(value = "orderNo", required = false) String orderNo) {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		if( loginUser != null) {
			//System.out.println(orderNo);
			
			ArrayList<Order> olist = orderService.selectMyOrder(orderNo);
			
			mv.addObject("olist",olist);
			
			//System.out.println(olist);
			
			mv.setViewName("member/myOrderDetail");
			
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
			if(d.getDeliNickname() == null || d.getDeliNickname().isEmpty()) {
				
				d.setDeliNickname(d.getDeliName());
			}
			
			int result = memberService.updateMyDelivery(d);
			
			if(result>0) {
				int deliCode = d.getDeliCode();
				Delivery updateDelivery = memberService.selectMemberDelivery(deliCode);
				mv.addObject("d",updateDelivery);
				session.setAttribute("alertMsg", "배송지 정보가 수정되었습니다.");
				
				ArrayList<Delivery> dlist =  memberService.selectDeliveryList(loginUser.getMemberId());
				
				for(Delivery deli : dlist) {
					String maskingPhone = masking(d.getDeliPhone());
					deli.setDeliPhone(maskingPhone);
					
					if(deli.getDeliDefault().equals("Y")) {
						deli.setDeliDefault("기본배송지");
					}else {
						deli.setDeliDefault("");
					}
				}
				
				mv.addObject("dlist",dlist);
				mv.setViewName("member/myDeliveryList");
			
			}else {
				
				session.setAttribute("alertMsg", "배송지수정실패");
				mv.setViewName("member/updateDelivery");
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
				
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 
							 pageLimit, boardLimit);
				
				ArrayList<Review> rlist = reviewService.selectMyReviewList(loginUser.getMemberId(),pi); 
			
				mv.addObject("pi",pi);
				mv.addObject("rlist",rlist);
				mv.addObject("listCount",listCount);
				
				session.setAttribute("listCount", listCount);
				
				mv.setViewName("member/myReviewList");
				
			
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
			return mv;
		}
		
		// 내가 찜한 목록 페이지요청 
		@GetMapping("wishList.me")
		public ModelAndView myWishList(ModelAndView mv,
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
				int listCount = memberService.myWishListCount(memberId);
				
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
				
				ArrayList<Product> wlist = memberService.selectMyWishList(loginUser.getMemberId(),pi); 
				mv.addObject("pi",pi);
				mv.addObject("wlist",wlist);
				mv.addObject("listCount",listCount);// menubar.jsp 
				
				mv.setViewName("member/myWishList");
				
			
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
			return mv;
		}
		
		// 찜 해제 요청 
		@PostMapping("deleteWish.me")
		public ModelAndView deleteWish(ModelAndView mv
										, HttpSession session
										, int prodNo){
			
			Member loginUser =(Member)session.getAttribute("loginUser");
			
			if( loginUser != null) {
				
				int result = memberService.deleteWish(prodNo);
				
				if (result>0) {
					
					session.setAttribute("alertMsg", "찜 해제");
					mv.setViewName("member/myWishList");
				
				}else {
					
					session.setAttribute("alertMsg", "찜 해제 실패");
					mv.setViewName("member/myWishList");
					
				}
				
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
				
			return mv;
		}	
		
		// 찜 전체 삭제 요청 
		@PostMapping("deleteAllWish.me")
		public ModelAndView deleteWish(ModelAndView mv
										, HttpSession session){
			
			Member loginUser =(Member)session.getAttribute("loginUser");
			
			if( loginUser != null) {
				
				int result = memberService.deleteAllWish(loginUser.getMemberId());
				
				if (result>0) {
					
					session.setAttribute("alertMsg", "찜 해제");
					mv.setViewName("member/myWishList");
				
				}else {
					
					session.setAttribute("alertMsg", "찜 해제 실패");
					mv.setViewName("member/myWishList");
					
				}
				
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
				
			return mv;
		}	
		// 장바구니 넣기전 상품 옵션 불러오기 
		@GetMapping("selectCartOption.me")			
		public ModelAndView selectCartOption(ModelAndView mv
										, HttpSession session
										,   @RequestParam("prodNo") int prodNo) {
			
			Member loginUser =(Member)session.getAttribute("loginUser");
				
			if( loginUser != null) {
				
				ArrayList<Option> optList = optionService.selectCartOption(prodNo);
				
				if (optList != null) {
					mv.addObject("optList", optList);
					mv.setViewName("member/optForm");
					
				}else {
					
					session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
					mv.setViewName("member/myWishList");
				}
					
			
			}else {
				
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
				
			return mv;
		}
				
		// 장바구니 넣기 
		@ResponseBody
		@PostMapping("insertCart.me")
		public Map<String, Object> insertCart(
										 HttpSession session
										, Cart c
										, @RequestParam("prodNo") Integer prodNo
										,  @RequestParam("optNo") int optNo) {
			
			Member loginUser =(Member)session.getAttribute("loginUser");
			
			Map<String, Object> response = new HashMap<>();
			
			if( loginUser != null) {
				Cart checkCart = new Cart();
				checkCart.setMemberId(loginUser.getMemberId());
				checkCart.setOptNo(optNo);
				
				Integer cartNo = cartService.selectCart(checkCart);
				
				if (cartNo == null) {
					
					c.setMemberId(loginUser.getMemberId());
					c.setProdNo(prodNo);
					c.setOptNo(optNo);
					c.setCartQty(1);

					int result1 = cartService.insertCart(c);
					
					if(result1>0) {
						response.put("success", true);
			            response.put("message", "상품이 장바구니에 추가되었습니다.");

					}else {
						response.put("success", false);
						response.put("message", "장바구니 추가 실패.");
						
					}
				
				}else {
					
		            int cartQty = cartService.selectCartQty(cartNo); // 현재 장바구니에 있는 수량을 조회
		            int updatedQty = cartQty + 1;  // 수량을 1 증가시킴
					int result2 = cartService.updateCartQty(cartNo, updatedQty);
					
					if(result2>0) {
						response.put("success", true);
			            response.put("message", "상품이 장바구니에 추가되었습니다.");

					}else {
						response.put("success", false);
						response.put("message", "장바구니 추가 실패.");
						
					}
				}
				
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				response.put("success", false);
		        response.put("message", "로그인 필요");
			}
			
			  return response; 
		}
		
		// 적립금 내역 페이지 이동 
		@GetMapping("pointList.me")
		public ModelAndView myPointList(ModelAndView mv,
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
				
			    
				ArrayList<Point> plist = memberService.selectMyPoints(dateMap);
				
				
				Map<String, List<Point>>  pointDateList = new LinkedHashMap<>();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
				for (Point point : plist) {
					
				    String pointDate = dateFormat.format(point.getPointDate()); 
				    pointDateList.putIfAbsent(pointDate, new ArrayList<>()); // 값이 없으면 초기화
				    pointDateList.get(pointDate).add(point); 
				}
				// 페이징처리
				int boardLimit = 5;
				// 한 번에 보여줄 페이지 수
				int pageLimit = 10;
				
				int listCount = memberService.myPointListCount(loginUser.getMemberId());
				
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 
							 pageLimit, boardLimit);
				
				mv.addObject("pi",pi);
				mv.addObject("plist",plist);
				mv.addObject("pointDateList", pointDateList); 
				mv.addObject("loginUser",loginUser);
				mv.setViewName("member/myPointList");
			
			}else {
				session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
				mv.setViewName("/main");
			}
			return mv;
		}		
			
}			
		
	

