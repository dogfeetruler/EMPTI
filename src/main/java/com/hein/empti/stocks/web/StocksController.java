package com.hein.empti.stocks.web;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hein.empti.buyorders.BuyordersVO;
import com.hein.empti.buyorders.service.BuyordersService;
import com.hein.empti.items.service.ItemsService;
import com.hein.empti.stocks.StocksVO;
import com.hein.empti.stocks.service.StocksService;
import com.hein.empti.storages.StoragesVO;
import com.hein.empti.storages.service.StoragesService;

@Controller
public class StocksController {

	@Autowired StocksService stocksService;
	@Autowired ItemsService itemsService;
	@Autowired StoragesService storagesService;
	@Autowired BuyordersService buyordersService;

	// 등록
	@RequestMapping(value = "/adminStocks", method = RequestMethod.POST)
	@ResponseBody
	public Map setInsertStocks(StocksVO stocksVO, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		stocksService.setInsertStocks(stocksVO);
		map.put("result", true);
		map.put("kkk", "ok");
		return map;
	}

	// 수정
	@RequestMapping(value = "/adminStocks", method = RequestMethod.PUT, consumes = "application/json")
	@ResponseBody
	public StocksVO setUpdateStocks(@RequestBody StocksVO stocksVO, Model model) {
		stocksService.setUpdateStocks(stocksVO);
		return stocksVO;
	}

	// 단건조회
	@RequestMapping(value = "/adminStocks/{stock_no}", method = RequestMethod.GET)
	@ResponseBody
	public StocksVO getStocks(@PathVariable String stock_no, StocksVO stocksVO, Model model) {
		stocksVO.setStock_no(stock_no);
		stocksVO = stocksService.getStocks(stocksVO);
		if (stocksVO.getStock_date() != null)
			stocksVO.setStock_date(stocksVO.getStock_date().replace(' ', 'T'));
		stocksVO.setStock_date(stocksVO.getStock_date().substring(0, 16));
		return stocksVO;
	}
	
	
	//0814 부터
	// 입출고내역 조회
	@RequestMapping("/getStocksList")
	public String getStocksList(Model model, StocksVO vo) {
		model.addAttribute("stocks", stocksService.getStocksList(vo));
		return "admin/stocks/stocksList";
	}
	
	// 등록폼
	@RequestMapping("/setInsertStocks")
	public String setInsertFormStocks(Model model, StoragesVO storagesVO) {		
		LocalDateTime currentDateTime = LocalDateTime.now(); 
		String currentTime =currentDateTime.toString().replace(" ", "T");
		int loc = currentTime.lastIndexOf(":");
		model.addAttribute("serverTime", currentTime.substring(0,loc));
		return "admin/stocks/insertStocks";
	}
	
	@RequestMapping(value="/findStockBorderNo", method=RequestMethod.GET)
	@ResponseBody
	public List<StocksVO> findStockBorderNo(Model model, StocksVO stocksVO) {
		return stocksService.findStockBorderNo(stocksVO);
	}
	
	// view resolver 방식

	@RequestMapping("stockslist.do")
	public ModelAndView getStocksListReport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pdfView");
		mv.addObject("filename", "/reports/stocks_view2.jrxml");
		return mv;
	}

	// excel 출력
	@RequestMapping("stocksexcell.do")
	public ModelAndView stocksexcel(StocksVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("commonExcelView");
		mv.addObject("datas", stocksService.getStocksMap(vo));// Map객체를 조회해서 시트를 생성한다.
		mv.addObject("filename", "stockslist");// 파일이름을 바꿔준다.
		mv.addObject("headers",
				new String[] { "입출고날짜", "유형", "판매주문번호", "구매주문번호", "수량", "품목명", "품목코드", "거래처명", "창고번호", "창고명", "비고" }); // 헤더의
																														// 값만
																														// 출력된다.
		return mv;
	}
	
	//다중 Insert
	//판매상세주문 다중 Insert
	@RequestMapping("/setInsertStockBorders/{border_no}")
	@ResponseBody
	public String setInsertStockBorders(@RequestBody List<StocksVO> list, BuyordersVO buyordersVO, @PathVariable String border_no) {
		for (StocksVO vo : list) {
			vo.setStock_date(vo.getStock_date().replace("T", " "));
			buyordersVO.setBorder_no(vo.getBorder_no());
			BuyordersVO bvo = buyordersService.getBuyorders(buyordersVO);
			bvo.setStatus("수령완료");
			buyordersService.setUpdateBuyorders(bvo);
		}
		stocksService.setInsertStockBorders(list);
		return "jhi";
	}
	
	//출고 처리
	@RequestMapping(value = "/setInsertStockRelease", method = RequestMethod.POST)
	@ResponseBody
	public String setInsertStockRelease(@RequestBody List<StocksVO> list) {
		stocksService.setInsertStockRelease(list);
		stocksService.setUpdateReal(list);
		return "jhi";
	}
	
	
	
	//입고 조회
	@RequestMapping("/getWarehousingList")
	public String getWarehousingList(StocksVO stocksVO, Model model) {
		model.addAttribute("wareList", stocksService.getWarehousingList(stocksVO)) ;
		return "admin/stocks/wareList";
	}
	
	//출고 조회
	@RequestMapping("/getReleaseList")
	public String getReleaseList(StocksVO stocksVO, Model model) {
		model.addAttribute("releList", stocksService.getReleaseList(stocksVO));
		return "admin/stocks/releList";
	}
}