package com.mig.blb.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class PageforOrders {
	
	private int currentPage;
	private int totalPages;
	private int pageLimit;
	private int boardLimit;
	private int totalGroups;
	
	private int maxPage;
	private int startPage;
	private int endPage;
	

	}
