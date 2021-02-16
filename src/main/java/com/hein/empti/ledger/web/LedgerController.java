package com.hein.empti.ledger.web;

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
import com.hein.empti.ledger.LedgerVO;
import com.hein.empti.ledger.service.LedgerService;
import com.hein.empti.saleorders.SaleordersVO;
import com.hein.empti.saleorders.service.SaleordersService;

@Controller
public class LedgerController {

	@Autowired
	LedgerService ledgerService;
	@Autowired
	SaleordersService saleordersService;
	@Autowired
	BuyordersService buyordersService;

	// 등록폼
	@RequestMapping("/setLedgerForm")
	public String setInsertFormLedger(Model model, SaleordersVO saleordersVO, BuyordersVO buyordersVO) {
		model.addAttribute("saleorders", saleordersService.getSaleordersListMap(saleordersVO));
		model.addAttribute("buyorders", buyordersService.getBuyordersListMap(buyordersVO));
		return "admin/ledger/ledgerAjax";
	}

	// 등록
	@RequestMapping(value = "/ledgers", method = RequestMethod.POST)
	@ResponseBody
	public Map setInsertLedger(LedgerVO ledgerVO, Model model) {
		ledgerVO.setTotal_amount(ledgerVO.getTotal_amount().replace(",", ""));
		ledgerService.setInsertLedger(ledgerVO);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("kkk", "ok");
		return map;
	}

	// 수정
	@RequestMapping(value = "/ledgers", method = RequestMethod.PUT, consumes = "application/json")
	// ,headers = {"Content-type=application/json"})
	// 요청헤더
	@ResponseBody
	public LedgerVO setUpdateLedger(@RequestBody LedgerVO ledgerVO, Model model) {
		ledgerVO.setTotal_amount(ledgerVO.getTotal_amount().replace(",", ""));
		ledgerService.setUpdateLedger(ledgerVO);
		return ledgerVO;
	}

	// 장부번호 조건 조회
	@RequestMapping(value = "/ledgers/{ldgr_no}", method = RequestMethod.GET)
	@ResponseBody
	public LedgerVO getLedgerNo(@PathVariable String ldgr_no, LedgerVO ledgerVO, Model model) {

		ledgerVO.setLdgr_no(ldgr_no);
		ledgerVO = ledgerService.getLedgerNo(ledgerVO);
		if (ledgerVO.getLdgr_date() != null)
			ledgerVO.setLdgr_date(ledgerVO.getLdgr_date().replace(' ', 'T'));
		ledgerVO.setLdgr_date(ledgerVO.getLdgr_date().substring(0, 16));
		return ledgerVO;
	}

	// 전체조회
	@RequestMapping(value = "/ledgers", method = RequestMethod.GET)
	@ResponseBody
	public List<LedgerVO> LedgerList(Model model, LedgerVO ledgerVO) {
		return ledgerService.getLedgerPdfList(ledgerVO);
	}

	// 내역 조회
	@RequestMapping("/getLedgerList")
	public String getLedgerList(Model model, LedgerVO VO) {
		model.addAttribute("LedgerList", ledgerService.getLedgerList(null));
		return "admin/ledger/ledgerList";
	}

	
	  // view resolver 방식
	  
	 @RequestMapping("ledger_list.do") public ModelAndView
	  getLedgerListReport(HttpServletRequest request, HttpServletResponse response)
	  throws Exception { ModelAndView mv = new ModelAndView();
	  mv.setViewName("pdfView"); mv.addObject("filename",
	  "/reports/ldgr_view2.jrxml"); return mv; }
	 

	// pdf 파라미터 지정
	/*
	 * @RequestMapping("ledger_list.do") public ModelAndView
	 * getLedgerListReport(HttpServletRequest request, HttpServletResponse response)
	 * throws Exception { // jrxml 소스 지정 String path =
	 * request.getSession().getServletContext().getRealPath("filename",
	 * "/reports/ldgr_view2.jrxml"); JasperReport jasperReport =
	 * JasperCompileManager.compileReport(path); JRDataSource JRdataSource = new
	 * JRBeanCollectionDataSource(userService.getListMap(null)); JasperPrint
	 * jasperPrint = JasperFillManager.fillReport(jasperReport, map, JRdataSource);
	 * }
	 */

	// excel 출력
	@RequestMapping("LdgrExcel.do")
	public ModelAndView ldgrexcel(LedgerVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("commonExcelView");
		mv.addObject("datas", ledgerService.getLdgrExcelMap(vo));// Map객체를 조회해서 시트를 생성한다.
		mv.addObject("filename", "ledgerlist");// 파일이름을 바꿔준다.
		mv.addObject("headers", new String[] { "장부번호", "날짜", "구분", "구매주문번호", "판매주문번호", "금액", "상태", "비고" }); // 헤더의 값만
																											// 출력된다.
		return mv; // 장부번호, 날짜, 금액, 상태, 주문번호, 비고
	}

	// 월별 매출 통계 차트
	@RequestMapping("getMonthlySaleAmount")
	public @ResponseBody List<Map<String, Object>> getMonthlySaleAmount() {
		return ledgerService.getMonthlySaleAmount();
	}

	// 영업이익
	@RequestMapping("getProfits")
	@ResponseBody
	public String getProfits(LedgerVO ledgerVO) {
		return ledgerService.getProfits(ledgerVO);
	}

}