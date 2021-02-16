package com.hein.empti.items.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hein.empti.items.ItemsVO;
import com.hein.empti.items.service.ItemsService;

@Controller
public class ItemsController {

	@Autowired
	ItemsService itemsService;

	// 등록폼
	@RequestMapping("/setInsertFormItems")
	public String setInsertFormItems(ItemsVO vo) {

		return "admin/items/insertItems";
	}

	// 등록 처리
	@RequestMapping("/setInsertItems")
	public String setInsertItems(ItemsVO vo) {// 1.커맨드객체는 자동으로 모델에 저장됨. model.addAttribute
		vo.setItem_price(vo.getItem_price().replace(",", ""));
		itemsService.setInsertItems(vo);
		return "redirect:getItemsList";
	}

	// 품목 전체 조회
	@RequestMapping("/getItemsList")
	public String getItemsList(Model model, ItemsVO vo) {
		model.addAttribute("itemsList", itemsService.getItemsList(vo));
		return "admin/items/itemsList";
	}

	// 품목 단건 조회
	@RequestMapping("/getItems/{item_no}") // getEmp?employeeId=aaaa
	public String getItems(@PathVariable String item_no) { // @PathVariable 경로(/)에 값을 그대로 넘김
		return "admin/home";
	}

	// 품목 수정폼
	@RequestMapping("/setUpdateFormItems")
	public String setUpdateFormItems(Model model, ItemsVO vo) {
		model.addAttribute("updateList", itemsService.getItems(vo));
		System.out.println(vo);
		return "admin/items/updateItems";
	}
	
	// 수정처리
	@RequestMapping("/setUpdateItems")
	public String setUpdateItems(ItemsVO vo) {
		vo.setItem_price(vo.getItem_price().replace(",", ""));
		itemsService.setUpdateItems(vo);
		return "redirect:getItemsList";
	}
	
	//삭제처리
	@RequestMapping("/setDeleteItems")
	public String setDeleteItems(Model model, ItemsVO itemsVO) {
		if(itemsService.getDisposalCount(itemsVO) > 0 || itemsService.getBuyDetailCount(itemsVO) >0
			|| itemsService.getSaleDetailCount(itemsVO) >0 ) {
			model.addAttribute("msg", "품목 내역이 있어 삭제할 수 없습니다.");
			model.addAttribute("loc", "getItemsList");
			return "common/msg";
		} else {
			itemsService.setDeleteItems(itemsVO);
			model.addAttribute("msg", "품목이 삭제되었습니다.");
			model.addAttribute("loc", "getItemsList");
			return "common/msg";		
		}
	}
	

	// 품목검색
	@RequestMapping("/findItems")
	public String findItems(ItemsVO itemsVO, Model model) {
		model.addAttribute("findItems", itemsService.getItemsList(itemsVO));
		return "common/findItems";
	}

	// view resolver 방식
	@RequestMapping("items_list.do")
	public ModelAndView getSaleLedgerListReport(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pdfView");
		mv.addObject("filename", "/reports/itemlist_view.jrxml");
		return mv;
	}

	// excel 출력
	@RequestMapping("items_excel.do")
	public ModelAndView itemsExcel(ItemsVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("commonExcelView");
		mv.addObject("datas", itemsService.getItemsMap(vo));// Map객체를 조회해서 시트를 생성한다.
		mv.addObject("filename", "itemslist");// 파일이름을 바꿔준다.
		mv.addObject("headers", new String[] { "품목코드", "품목명", "단위", "가공품원가", "유통기한", "유형" }); // 헤더의 값만 출력된다.
		return mv;
	}

}