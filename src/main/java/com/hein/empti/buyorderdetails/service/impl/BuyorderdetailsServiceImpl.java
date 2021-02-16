package com.hein.empti.buyorderdetails.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.buyorderdetails.BuyorderdetailsVO;
import com.hein.empti.buyorderdetails.mapper.BuyorderdetailsMapper;
import com.hein.empti.buyorderdetails.service.BuyorderdetailsService;

@Service
public class BuyorderdetailsServiceImpl implements BuyorderdetailsService{
	
	@Autowired BuyorderdetailsMapper buyorderdetailsMapper;

	@Override
	public void setBuyorderdetailInsert(List<BuyorderdetailsVO> list) {
		buyorderdetailsMapper.setBuyorderdetailInsert(list);
		System.out.println("구매주문 다중 Insert 완료.");
	}

	@Override
	public void setBuyorderdetailDelete(BuyorderdetailsVO buyorderdetailsVO) {
		buyorderdetailsMapper.setBuyorderdetailDelete(buyorderdetailsVO);
	}

	@Override
	public List<Map<String, Object>> getBuyorderdetailList(BuyorderdetailsVO buyorderdetailsVO) {
		return buyorderdetailsMapper.getBuyorderdetailList(buyorderdetailsVO);
	}
	
	
	

}
