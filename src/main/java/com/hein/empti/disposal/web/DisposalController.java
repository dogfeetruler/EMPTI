package com.hein.empti.disposal.web;

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

import com.hein.empti.disposal.DisposalVO;
import com.hein.empti.disposal.service.DisposalService;
import com.hein.empti.items.ItemsVO;
import com.hein.empti.items.service.ItemsService;
import com.hein.empti.storages.StoragesVO;
import com.hein.empti.storages.service.StoragesService;

@Controller
public class DisposalController {

	@Autowired	DisposalService disposalService;
	@Autowired 	StoragesService	storagesService;
	@Autowired	ItemsService	itemsService;

	// AJAX페이지 호출
	@RequestMapping("/setDisposalForm")
	public String setInsertFormDisposal(Model model, ItemsVO itemsVO, StoragesVO storagesVO) {
		model.addAttribute("storages", storagesService.getStoragesList(storagesVO));
		model.addAttribute("items", itemsService.getItemsList(itemsVO));
		return "admin/disposal/disposalAjax";
	}

	// 등록
	@RequestMapping(value = "/disposals", method = RequestMethod.POST)
	@ResponseBody
	public Map setInsertDisposal(DisposalVO disposalVO, Model model) {
		disposalVO.setPrice(disposalVO.getPrice().replace(",", ""));
		disposalService.setInsertDisposal(disposalVO);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("kkk", "ok");
		return map;
	}

	// 수정
	@RequestMapping(value = "/disposals", method = RequestMethod.PUT, consumes = "application/json")
	// ,headers = {"Content-type=application/json"})
	// 요청헤더
	@ResponseBody
	public DisposalVO setUpdateDisposal(@RequestBody DisposalVO disposalVO, Model model) {
		disposalVO.setPrice(disposalVO.getPrice().replace(",", ""));
		disposalService.setUpdateDisposal(disposalVO);
		return disposalVO;
	}

	// 단건조회
	@RequestMapping(value = "/disposals/{disposal_no}", method = RequestMethod.GET)
	@ResponseBody
	public DisposalVO getDisposal(@PathVariable String disposal_no, DisposalVO disposalVO, Model model) {

		disposalVO.setDisposal_no(disposal_no);
		disposalVO = disposalService.getDisposal(disposalVO);
		if (disposalVO.getDisposal_date() != null)
			disposalVO.setDisposal_date(disposalVO.getDisposal_date().replace(' ', 'T'));
		disposalVO.setDisposal_date(disposalVO.getDisposal_date().substring(0, 16));
		return disposalVO;
	}

	// 전체조회
	@RequestMapping(value = "/disposals", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> disposalList(Model model, DisposalVO disposalVO) {
		return disposalService.getDisposalList(disposalVO);
	}
	
	//삭제처리
	@RequestMapping(value="/disposals/{disposal_no}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> setDeleteDisposal(@PathVariable String disposal_no,DisposalVO disposalVO, Model model) {
		disposalVO.setDisposal_no(disposal_no);
		disposalService.setDeleteDisposal(disposalVO);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", Boolean.TRUE);
		return result;
	}

	// 내역 조회
	@RequestMapping("/getDisposalList")
	public String getDisposalList(Model model, DisposalVO VO) {
		model.addAttribute("disposalList", disposalService.getDisposalList(null));
		return "admin/disposal/disposalList";
	}

	//view resolver 방식
	@RequestMapping("disposal_list.do")
	public ModelAndView getDisposalListReport(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
	ModelAndView mv = new ModelAndView();
	mv.setViewName("pdfView");
	mv.addObject("filename", "/reports/disposal_list2.jrxml");
	return mv;
	}
	
	
	// excel 출력
	@RequestMapping("disposal_excel.do")
	public ModelAndView disposalexcel(DisposalVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("commonExcelView");
		mv.addObject("datas", disposalService.getDisposalMap(vo));// Map객체를 조회해서 시트를 생성한다.
		mv.addObject("filename", "diposallist");// 파일이름을 바꿔준다.
		mv.addObject("headers", new String[] { "날짜", "수량","가격","구분","제품번호","창고번호"}); // 헤더의 값만 출력된다.
		return mv;
	}
}