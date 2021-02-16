package com.hein.empti.stocks.mapper;

import java.util.List;
import java.util.Map;

import com.hein.empti.saleorderdetails.SaleorderdetailsVO;
import com.hein.empti.stocks.StocksVO;

public interface StocksMapper {
	
	public StocksVO getStocks(StocksVO stocksVO);
	public List<StocksVO> getStocksList(StocksVO stocksVO);
	public void setInsertStocks(StocksVO stocksVO);
	public void setUpdateStocks(StocksVO stocksVO);
	
	//입고 조회
	public List<StocksVO> getWarehousingList(StocksVO stocksVO);
	//출고 조회
	public List<StocksVO> getReleaseList(StocksVO stocksVO);
	
	
	//findStockBorderNo, 구매 조회
	public List<StocksVO> findStockBorderNo(StocksVO stocksVO);
	
	//stock_view (Map)엑셀
	public List<Map<String, Object>> getStocksMap(StocksVO vo);
	
	//다중 Insert
	public void setInsertStockBorders(List<StocksVO> list);
	
	//출고 insert
	public void setInsertStockRelease(List<StocksVO> list);
	
	//출고 후 실수량 수정
	public void setUpdateReal(StocksVO stocksVO);
}
