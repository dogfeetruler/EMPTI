package com.hein.empti.buyorderdetails.service;

import java.util.List;
import java.util.Map;

import com.hein.empti.buyorderdetails.BuyorderdetailsVO;

public interface BuyorderdetailsService {
	public void setBuyorderdetailInsert (List<BuyorderdetailsVO> list);
	public void setBuyorderdetailDelete (BuyorderdetailsVO buyorderdetailsVO);

	public List<Map<String, Object>> getBuyorderdetailList(BuyorderdetailsVO buyorderdetailsVO);
}
