package com.mig.blb.member.model.vo;

import com.mig.blb.member.model.vo.PageforOrders;

public class PaginationOrders {

	public static PageforOrders getPageforOrders(int currentPage,
												   int pageLimit,
												   int boardLimit,
												   int totalGroups) {
		
		 // 전체 페이지 수 계산 (totalPages)
        int totalPages = (int) Math.ceil((double) totalGroups / boardLimit);  
        
        // maxPage는 totalPages와 동일하게 설정 가능
        int maxPage = totalPages; 
        
        // 시작 페이지 번호와 끝 페이지 번호 계산
        int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;     
        int endPage = startPage + pageLimit - 1;                           
        
        // endPage가 maxPage보다 크면 maxPage로 설정
        if (endPage > maxPage) {
            endPage = maxPage;
        }
		
		return new PageforOrders( currentPage, totalPages,pageLimit,
				boardLimit, totalGroups,maxPage, startPage, endPage);
		
		}
}
