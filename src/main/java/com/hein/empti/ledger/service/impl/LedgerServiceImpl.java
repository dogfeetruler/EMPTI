package com.hein.empti.ledger.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.ledger.LedgerVO;
import com.hein.empti.ledger.mapper.LedgerMapper;
import com.hein.empti.ledger.service.LedgerService;

@Service
public class LedgerServiceImpl implements LedgerService {
	
	@Autowired LedgerMapper ledgerMapper;
	
	@Override 
	public List<LedgerVO> getLedgerList(LedgerVO ledgerVO) {
		return ledgerMapper.getLedgerList(ledgerVO);
	}

	@Override
	public LedgerVO getLedgerNo(LedgerVO ledgerVO) {
		return ledgerMapper.getLedgerNo(ledgerVO);
	}

	@Override
	public LedgerVO getLedgerStatus(LedgerVO ledgerVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setInsertLedger(LedgerVO ledgerVO) {
		ledgerVO.setLdgr_date(ledgerVO.getLdgr_date().replace('T', ' '));
		
		ledgerMapper.setInsertLedger(ledgerVO);
	}

	@Override
	public void setUpdateLedger(LedgerVO ledgerVO) {
		ledgerVO.setLdgr_date(ledgerVO.getLdgr_date().replace('T', ' '));
		ledgerMapper.setUpdateLedger(ledgerVO);
	}

	@Override
	public List<Map<String, Object>> getLdgrExcelMap(LedgerVO vo) {
		return ledgerMapper.getLdgrExcelMap(vo);
	}
	
	//월별 매출 통계 차트
	@Override
	public List<Map<String, Object>> getMonthlySaleAmount() {
		return ledgerMapper.getMonthlySaleAmount();
	}

	@Override
	public String getProfits(LedgerVO vo) {
		return ledgerMapper.getProfits(vo);
	}

	@Override
	public List<LedgerVO> getLedgerPdfList(LedgerVO ledgerVO) {
		return ledgerMapper.getLedgerPdfList(ledgerVO);
	}
	
	
}