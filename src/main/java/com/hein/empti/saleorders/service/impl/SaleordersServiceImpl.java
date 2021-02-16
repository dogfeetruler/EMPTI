package com.hein.empti.saleorders.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.saleorderdetails.mapper.SaleorderdetailsMapper;
import com.hein.empti.saleorders.SaleordersVO;
import com.hein.empti.saleorders.SorderMasterVO;
import com.hein.empti.saleorders.mapper.SaleordersMapper;
import com.hein.empti.saleorders.service.SaleordersService;

@Service
public class SaleordersServiceImpl implements SaleordersService {

	@Autowired SaleordersMapper saleordersMapper;
	@Autowired SaleorderdetailsMapper saleorderdetailsMapper;

	@Override
	public List<SaleordersVO> getSaleordersList(SaleordersVO saleordersVO) {
		return saleordersMapper.getSaleordersList(saleordersVO);
	}

	@Override
	public SaleordersVO getSaleorders(SaleordersVO saleordersVO) {
		return saleordersMapper.getSaleorders(saleordersVO);
	}

	@Override
	public void setInsertSaleorders(SorderMasterVO sVO) {
		sVO.getVo().setSorder_date(sVO.getVo().getSorder_date().replace('T', ' '));
		saleordersMapper.setInsertSaleorders(sVO.getVo());
		saleorderdetailsMapper.setSaleorderdetailInsert(sVO.getList());
	}

	// 수정처리 (배송상태만)
	@Override
	public void setUpdateSaleDel(List<SaleordersVO> sList) {
		saleordersMapper.setUpdateSaleDel(sList);
	}

	// 삭제처리
	@Override
	public void setDeleteSaleorders(SaleordersVO saleordersVO) {
		saleordersMapper.setDeleteSaleorders(saleordersVO);
	}

	// 시퀀스 조회
	@Override
	public String getSaleSeq() {
		return saleordersMapper.getSaleSeq();
	}

	// 판매주문(JOIN name, company_name) Map 객체에 담아서 조회
	@Override
	public List<Map<String, Object>> getSaleordersListMap(SaleordersVO saleordersVO) {
		return saleordersMapper.getSaleordersListMap(saleordersVO);
	}

	// 엑셀
	@Override
	public List<Map<String, Object>> getSaleOrdersExcelMap(SaleordersVO vo) {
		return saleordersMapper.getSaleOrdersExcelMap(vo);
	}

	// 반품 조회
	@Override
	public List<SaleordersVO> getReturnSaleordersList(SaleordersVO saleordersVO) {
		return saleordersMapper.getReturnSaleordersList(saleordersVO);
	}
	
	// 반품 입력
	@Override
	public void setInsertSaleordersRetrun(SaleordersVO vo) {
		saleordersMapper.setInsertSaleordersRetrun(vo);
	}
	
	// '배송준비중'인 주문 건수
	@Override
	public String getReadySaleorders(SaleordersVO vo) {
		return saleordersMapper.getReadySaleorders(vo);
	}
	
	//판매량 높은 품목 Best5
	@Override
	public List<Map<String, Object>> getHigherSaleItems() {
		return saleordersMapper.getHigherSaleItems();
	}
}