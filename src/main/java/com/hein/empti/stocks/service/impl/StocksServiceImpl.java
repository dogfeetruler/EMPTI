package com.hein.empti.stocks.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.stocks.StocksVO;
import com.hein.empti.stocks.mapper.StocksMapper;
import com.hein.empti.stocks.service.StocksService;

@Service
public class StocksServiceImpl implements StocksService {
	
	@Autowired 
	StocksMapper stocksMapper;
	
	//단건조회
	@Override
	public StocksVO getStocks(StocksVO stocksVO) {
		return stocksMapper.getStocks(stocksVO);
	}
	
	//전체조회
	@Override
	public List<StocksVO> getStocksList(StocksVO stocksVO) {
		return stocksMapper.getStocksList(stocksVO);
	}
	
	//입고 조회
	@Override
	public List<StocksVO> getWarehousingList(StocksVO stocksVO) {
		return stocksMapper.getWarehousingList(stocksVO);
	}

	//출고조회
	@Override
	public List<StocksVO> getReleaseList(StocksVO stocksVO) {
		return stocksMapper.getReleaseList(stocksVO);
	}

	//등록
	@Override
	public void setInsertStocks(StocksVO stocksVO) {
		stocksVO.setStock_date(stocksVO.getStock_date().replace('T', ' '));
			stocksMapper.setInsertStocks(stocksVO);
	}
	
	//수정
	@Override
	public void setUpdateStocks(StocksVO stocksVO) {
		stocksVO.setStock_date(stocksVO.getStock_date().replace('T', ' '));
			stocksMapper.setUpdateStocks(stocksVO);
	}
	//pdf
	@Override
	public List<Map<String, Object>> getStocksMap(StocksVO vo) {
		return stocksMapper.getStocksMap(vo);
	}

	//0814부터
	//findStockBorderNo, 구매 조회
	@Override
	public List<StocksVO> findStockBorderNo(StocksVO stocksVO) {
		return stocksMapper.findStockBorderNo(stocksVO);
	}
	
	//다중 Insert
	@Override
	public void setInsertStockBorders(List<StocksVO> list) {
		stocksMapper.setInsertStockBorders(list);
	}

	//출고 insert
	@Override
	public void setInsertStockRelease(List<StocksVO> list) {
		stocksMapper.setInsertStockRelease(list);
	}

	//출고 후 실수량 수정
	@Override
	public void setUpdateReal(List<StocksVO> list) {
		for(StocksVO vo : list) {
			stocksMapper.setUpdateReal(vo);
		}
	}
	
	
	
}