package com.hein.empti.buyorderdetails.mapper;

import java.util.List;
import java.util.Map;

import com.hein.empti.buyorderdetails.BuyorderdetailsVO;

public interface BuyorderdetailsMapper {
	public void setBuyorderdetailInsert (List<BuyorderdetailsVO> vo);
	public void setBuyorderdetailDelete (BuyorderdetailsVO buyorderdetailsVO);

	public List<Map<String, Object>> getBuyorderdetailList(BuyorderdetailsVO buyorderdetailsVO);
}
