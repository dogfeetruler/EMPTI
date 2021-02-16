package com.hein.empti.buyorders.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.buyorderdetails.mapper.BuyorderdetailsMapper;
import com.hein.empti.buyorders.BuyordersVO;
import com.hein.empti.buyorders.OrderMasterVO;
import com.hein.empti.buyorders.mapper.BuyordersMapper;
import com.hein.empti.buyorders.service.BuyordersService;

@Service
public class BuyordersServiceImpl implements BuyordersService{
	
	@Autowired BuyordersMapper buyordersMapper;
	@Autowired BuyorderdetailsMapper buyorderdetailsMapper;
	
	//전체조회
	@Override
	public List<Map<String, Object>> getBuyordersListMap(BuyordersVO buyordersVO) {
		return buyordersMapper.getBuyordersListMap(buyordersVO);
	}
	
	//잔여금
	@Override
	public List<Map<String, Object>> getBuyordersBalMap(BuyordersVO buyordersVO) {
		return buyordersMapper.getBuyordersBalMap(buyordersVO);
	}

	@Override
	public BuyordersVO getBuyorders(BuyordersVO buyordersVO) {
		return buyordersMapper.getBuyorders(buyordersVO);
	}

	@Override
	public void setInsertBuyorders(OrderMasterVO mVO) {
		mVO.getVo().setBorder_date(mVO.getVo().getBorder_date().replace('T', ' '));
		buyordersMapper.setInsertBuyorders(mVO.getVo());
		buyorderdetailsMapper.setBuyorderdetailInsert(mVO.getList());
	}
	@Override
	public void setUpdateBuyorders(BuyordersVO buyordersVO) {
		buyordersVO.setBorder_date(buyordersVO.getBorder_date().replace('T', ' '));
		buyordersMapper.setUpdateBuyorders(buyordersVO);
	}
	@Override
	public void setDeleteBuyorders(BuyordersVO buyordersVO) {
		buyordersMapper.setDeleteBuyorders(buyordersVO);
	}
	
    //반품
	@Override
	public List<BuyordersVO> getReturnBuyordersList(BuyordersVO buyordersVO) {
		return buyordersMapper.getReturnBuyordersList(buyordersVO);
	}


	@Override
	public void setInsertBuyordersRetrun(BuyordersVO buyordersVO) {
		buyordersMapper.setInsertBuyordersRetrun(buyordersVO);
	}

	@Override
	public void setUpdateBuyDel(List<BuyordersVO> bList) {
		buyordersMapper.setUpdateBuyDel(bList);
	}

	//시퀀스 조회
	@Override
	public String getBuySeq() {
		return buyordersMapper.getBuySeq();
	}
	
	// 엑셀
	@Override
	public List<Map<String, Object>> getBuyordersexcelMap(BuyordersVO vo) {
		return buyordersMapper.getBuyordersexcelMap(vo);
	}
	
	// '미수령'인 주문 건수
	@Override
	public String getReadyBuyorders(BuyordersVO vo) {
		return buyordersMapper.getReadyBuyorders(vo);
	}

	
}
