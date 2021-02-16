package com.hein.empti.buyorders.service;

import java.util.List;
import java.util.Map;

import com.hein.empti.buyorders.BuyordersVO;
import com.hein.empti.buyorders.OrderMasterVO;
import com.hein.empti.company.CompanyVO;

public interface BuyordersService {
	public BuyordersVO getBuyorders(BuyordersVO buyordersVO);
	public void setInsertBuyorders(OrderMasterVO mVO);
	public void setUpdateBuyorders(BuyordersVO buyordersVO);
	public void setDeleteBuyorders(BuyordersVO buyordersVO);

	//잔여금
	public List<Map<String, Object>> getBuyordersBalMap(BuyordersVO buyordersVO);
	

	//시퀀스 조회
	public String getBuySeq();
	
	//엑셀
	public List<Map<String, Object>> getBuyordersexcelMap(BuyordersVO vo);

	//구매주문 map담기
	public List<Map<String, Object>> getBuyordersListMap(BuyordersVO buyordersVO);
	
	//반품 조회
	public List<BuyordersVO> getReturnBuyordersList(BuyordersVO buyordersVO);
		
	//반품 처리(insert)
	public void setInsertBuyordersRetrun(BuyordersVO buyordersVO);

	//수정처리(배송상태만)
	public void setUpdateBuyDel(List<BuyordersVO> bList);
	
	//'미수령'인 주문 건수
	public String getReadyBuyorders(BuyordersVO vo);
}