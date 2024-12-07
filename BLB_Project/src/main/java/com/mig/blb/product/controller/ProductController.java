package com.mig.blb.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductController {

	@GetMapping("list.pr")
	public String selectProductList(@RequestParam(value="ppage", defaultValue="1")int currentPage,
									Model model) {
		return "product/productListView";
	}
}
