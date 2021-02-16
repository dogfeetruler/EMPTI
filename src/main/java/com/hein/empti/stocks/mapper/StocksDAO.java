package com.hein.empti.stocks.mapper;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.hein.empti.stocks.StocksVO;

public class StocksDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	// 입출고 리스트조회
	public List<StocksVO> getStocksList() {
		return mybatis.selectList("StocksDAO.stocksList");
	}
	
	// 입출고 한건조회
	public StocksVO getStocks(StocksVO stocksVO) {
		return mybatis.selectOne("com.hein.empti.stocks.mapper.StocksDAO.getStock", stocksVO);
	}
	
	// 입출고 등록
	public void setInsertStocks(StocksVO stocksVO) {
		mybatis.insert("com.hein.empti.stocks.mapper.StocksDAO.insertStocks", stocksVO);
	}
	
	// 입출고 상세번호 업데이트
	
	
}