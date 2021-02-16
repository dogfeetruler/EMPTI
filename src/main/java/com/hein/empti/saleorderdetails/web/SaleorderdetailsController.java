package com.hein.empti.saleorderdetails.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hein.empti.saleorderdetails.SaleorderdetailsVO;
import com.hein.empti.saleorderdetails.service.SaleorderdetailsService;

@Controller
public class SaleorderdetailsController {
	
	@Autowired SaleorderdetailsService service;
	
	//판매상세주문 다중 Insert
	@RequestMapping("/setSaleorderdetailInsert")
	@ResponseBody
	public Map setSaleorderdetailInsert(@RequestBody List<SaleorderdetailsVO> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", true);
		service.setSaleorderdetailInsert(list);
		return map;
	}
}