package com.hein.empti.buyorderdetails.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hein.empti.buyorderdetails.BuyorderdetailsVO;
import com.hein.empti.buyorderdetails.service.BuyorderdetailsService;

@Controller
public class BuyorderdetailsController {
	
	@Autowired BuyorderdetailsService service;
	
	//테스트 해볼려고 넣은 경로 (삭제해도 무방)
	@RequestMapping("/Buydetail")
	public String goBuyorderdetails() {
		return "buyorderdetails/buyorderdetails";
	}
	
	//구매상세주문 다중 Insert
	@RequestMapping("/setBuyorderdetailInsert")
	@ResponseBody
	public Map setBuyorderdetailInsert(@RequestBody List<BuyorderdetailsVO> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", true);
		service.setBuyorderdetailInsert(list);
		return map;
	}
}