package com.hein.empti.buyorders.web;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hein.empti.buyorderdetails.BuyorderdetailsVO;
import com.hein.empti.buyorderdetails.service.BuyorderdetailsService;
import com.hein.empti.buyorders.BuyordersVO;
import com.hein.empti.buyorders.OrderMasterVO;
import com.hein.empti.buyorders.service.BuyordersService;
import com.hein.empti.saleorders.SaleordersVO;

@Controller
public class BuyordersController {
	@Autowired BuyordersService buyordersService;
	@Autowired BuyorderdetailsService buyorderdetailsService;
	@Autowired
	@Qualifier("dataSourceSpied")
	DataSource datasource;

	// 상세조회를 뺀 구매주문 내역 전체 조회
	@RequestMapping("/getBuyordersListForm")
	public String getBuyordersList(BuyordersVO buyordersVO, Model model) {
		return "admin/buyorders/buyordersList";
	}
	
	// 구매주문 전체조회 Map
	@RequestMapping("/getBuyordersListMap")
	public String getSaleordersListMap(Model model, BuyordersVO buyordersVO) {
		model.addAttribute("buyordersMap", buyordersService.getBuyordersListMap(buyordersVO));
		return "admin/buyorders/buyordersList";
	}

	// 구매주문 단건조회
	@RequestMapping("/getBuyorders")
	public String getBuyorders(BuyordersVO buyordersVO, Model model) {
		model.addAttribute("buyorders", buyordersService.getBuyorders(buyordersVO));
		return "buyorders/buyorderdetails";
	}
	
	//상세정보 새창
	@RequestMapping("/getBuyorderdetailList")
	public String getBuyorderdetailList(BuyorderdetailsVO buyorderdetailsVO, Model model) {
		model.addAttribute("buyDetails", buyorderdetailsService.getBuyorderdetailList(buyorderdetailsVO));
		return "buyorderdetails/buyorderdetailList";
	}
	
	// 구매주문 시퀀스
	@RequestMapping("/getBuySeq")
	@ResponseBody
	public String getBuySeq(String seq) {
		return buyordersService.getBuySeq();
	}
	
	// 등록폼
	@RequestMapping("/setInsertFormBuyorders")
	public String setInsertFormBuyorders(BuyordersVO vo,Model model) {
		LocalDateTime currentDateTime = LocalDateTime.now(); 
		String currentTime =currentDateTime.toString().replace(" ", "T");
		int loc = currentTime.lastIndexOf(":");
		System.out.println(currentTime.substring(0,loc));
		
		model.addAttribute("serverTime", currentTime.substring(0,loc));
		
		return "admin/buyorders/insertBuyorders";
	}

	// 등록처리(구매주문)
	@RequestMapping("/setInsertBuyorders")
	@ResponseBody
	public String setInsertBuyorders(@RequestBody OrderMasterVO mVO, Model model) {
		buyordersService.setInsertBuyorders(mVO);
		return "redirect:getBuyordersListMap";
	}

	// 수정처리(구매주문)
	@RequestMapping("/setUpdateBuyorders")
	public String setUpdateBuyorders(BuyordersVO buyordersVO) {
		buyordersService.setUpdateBuyorders(buyordersVO);
		return "redirect:getBuyordersListMap";
	}
	
	// 삭제처리
	@RequestMapping("/setDeleteBuyorders")
	public String setDeleteBuyorders(BuyordersVO buyordersVO, BuyorderdetailsVO buyorderdetailsVO) {
		buyorderdetailsService.setBuyorderdetailDelete(buyorderdetailsVO);
		buyordersService.setDeleteBuyorders(buyordersVO);
		return "redirect:getBuyordersListMap";
	}
	
	// 주문번호조회
	@RequestMapping("/findBuyorderNo")
	public String findBuyorderNo(BuyordersVO buyordersVO, Model model) {
		model.addAttribute("findBuyorderNo", buyordersService.getBuyordersBalMap(buyordersVO));
		return "common/findBuyorderNo";
	}
	
	// 반품목록 조회
	@RequestMapping("/getReturnBuyordersList")
	public String getReturnBuyordersList(BuyordersVO buyordersVO, Model model) {
		model.addAttribute("returnBorders", buyordersService.getReturnBuyordersList(buyordersVO));
		return "admin/buyorders/returnBuyLordersList";
	}
	
	//반품처리(Insert)
	@RequestMapping("/setInsertBuyordersRetrun")
	public String setInsertBuyordersRetrun(BuyordersVO buyordersVO) {
		buyordersService.setInsertBuyordersRetrun(buyordersVO);
		return "redirect:getReturnBuyordersList";
	}
	
	// 수정처리 (배송상태만)
	@RequestMapping("/setUpdateBuyDel")
	@ResponseBody
	public void setUpdateSaleDel(@RequestBody List<BuyordersVO> bList) {
		buyordersService.setUpdateBuyDel(bList);
	}
	
	// view resolver 방식 pdf 출력
	@RequestMapping("buyorders_list.do")
	public ModelAndView getBuyorderListReport(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pdfView");
		mv.addObject("filename", "/reports/buyorders_list2.jrxml");
		return mv;
	}
	
	// excel 출력
	@RequestMapping("buyOrdersexcel.do")
	public ModelAndView buyordersexcel(BuyordersVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("commonExcelView");
		mv.addObject("datas", buyordersService.getBuyordersexcelMap(vo));// Map객체를 조회해서 시트를 생성한다.
		mv.addObject("filename", "buyorderlist");// 파일이름을 바꿔준다.
		mv.addObject("headers", new String[] { "구매일자", "품목", "단가", "주문수량", "합계", "담당사원", "거래처", "상태"}); // 헤더의 값만 출력된다.
		return mv;    //구매일자/품목/ 단가/주문수량/합계/담당사원/거래처/상태
	}
	
	// '배송준비중'인 주문 건수
	@RequestMapping("getReadyBuyorders")
	@ResponseBody
	public String getReadyBuyorders(BuyordersVO vo, Model model) {
		return buyordersService.getReadyBuyorders(vo);
	}
}