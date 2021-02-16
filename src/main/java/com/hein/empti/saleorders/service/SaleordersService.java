package com.hein.empti.saleorders.service;

import java.util.List;
import java.util.Map;

import com.hein.empti.saleorders.SaleordersVO;
import com.hein.empti.saleorders.SorderMasterVO;

public interface SaleordersService {
	public List<SaleordersVO> getSaleordersList(SaleordersVO saleordersVO);	
	public SaleordersVO getSaleorders(SaleordersVO saleordersVO);
	public void setInsertSaleorders(SorderMasterVO sorderMasterVO);
	
	public void setDeleteSaleorders(SaleordersVO saleordersVO);
	
	//시퀀스 조회
	public String getSaleSeq();
	
	//판매주문(JOIN name, company_name) Map 객체에 담아서 조회
	public List<Map<String, Object>> getSaleordersListMap(SaleordersVO saleordersVO);
	
	//엑셀
	public List<Map<String, Object>> getSaleOrdersExcelMap(SaleordersVO vo);

	//반품 조회
	public List<SaleordersVO> getReturnSaleordersList(SaleordersVO saleordersVO);
	
	//반품 처리(Insert)
	public void setInsertSaleordersRetrun(SaleordersVO vo);
	
	//수정처리(배송상태만)
	public void setUpdateSaleDel(List<SaleordersVO> sList);
	
	//'배송준비중'인 주문 건수
	public String getReadySaleorders(SaleordersVO vo);
	
	//판매량 높은 품목 Best5
	public List<Map<String,Object>> getHigherSaleItems();
}