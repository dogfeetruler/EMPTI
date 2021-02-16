package com.hein.empti.saleorderdetails.mapper;

import java.util.List;
import java.util.Map;

import com.hein.empti.saleorderdetails.SaleorderdetailsVO;

public interface SaleorderdetailsMapper {
	//전체조회 Where:주문번호
	public List<Map<String, Object>> getSaleorderdetailList(SaleorderdetailsVO vo);
	
	//다중 Insert
	public void setSaleorderdetailInsert(List<SaleorderdetailsVO> list);
	
	//삭제
	public void setSaleorderdetailDelete(SaleorderdetailsVO vo);
}
