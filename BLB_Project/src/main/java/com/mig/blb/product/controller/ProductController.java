package com.mig.blb.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.product.model.service.ProductService;
import com.mig.blb.product.model.vo.Product;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;

	@GetMapping("list.pr")
	public String selectProductList(@RequestParam(value="ppage", defaultValue="1")int currentPage,
									@RequestParam(value="category", defaultValue="전체제품")String category,
									@RequestParam(value="subcategories", required=false) List<String> subcategories,
									@RequestParam(value="sortBy", defaultValue="recommended") String sortBy,
							        @RequestParam(value="boardLimit", defaultValue="12") int boardLimit,
									Model model) {
		// params를 생성하여 전달
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("subcategories", subcategories);
		
		int listCount = productService.selectProductCount(params);
		
		int pageLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 
											 pageLimit, boardLimit);
		
		ArrayList<Product> pList = productService.selectProductList(pi, params);
		
		model.addAttribute("pList", pList);
		model.addAttribute("pi", pi);
		model.addAttribute("category", category);
		model.addAttribute("subcategories", subcategories);
	    model.addAttribute("sortBy", sortBy);
	    model.addAttribute("boardLimit", boardLimit);
		
		return "product/productListView";
	}
}
