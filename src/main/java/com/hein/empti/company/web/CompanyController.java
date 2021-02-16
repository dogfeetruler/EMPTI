package com.hein.empti.company.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hein.empti.company.CompanyVO;
import com.hein.empti.company.service.CompanyService;

@Controller // Bean등록, Dispatcher Servlet이 인식할 수 있는 Controller로 변환// @Component상속
public class CompanyController {

	@Autowired CompanyService companyService;

	@Autowired
	@Qualifier("dataSourceSpied")
	DataSource datasource;

	// 단건조회
	@RequestMapping("/getCompany/{company_no}") // getEmp?employeeId=aaa
	public String getCompany(@PathVariable String company_no, CompanyVO companyVO, Model model) {
		model.addAttribute("company", companyService.getCompany(companyVO));
		return "company/companyDetail";
	}

	// 목록조회
	@RequestMapping("/getCompanyList")
	public String getCompanyList(Model model, CompanyVO companyVO) {
		model.addAttribute("companyList", companyService.getCompanyList(companyVO));
		return "admin/company/companyList";
	}

	// 회사코드, 회사명만 조회.
	@RequestMapping("/findCompany")
	public String findComapny(Model model, CompanyVO companyVO) {
		model.addAttribute("findCompanyList", companyService.findCompany(companyVO));
		return "common/findCompany";
	}
	
	// 등록폼
	@RequestMapping("/setInsertFormCompany")
	public String setInsertFormCompany(CompanyVO companyVO, Model model) {
		model.addAttribute("maxCom", companyService.comNoMax(companyVO));
		return "admin/company/insertCompany";
	}

	// 등록처리
	@RequestMapping("/setInsertCompany")
	private String setInsertCompany(CompanyVO companyVO) {
		companyService.setInsertCompany(companyVO);
		return "redirect:getCompanyList";
	}

	// 수정폼
	@RequestMapping("/setUpdateFormCompany")
	public String setUpdateFormCompany(Model model, CompanyVO companyVO) {
		model.addAttribute("company", companyService.getCompany(companyVO));
		return "admin/company/updateCompany";
	}

	// 수정처리
	@RequestMapping("/setUpdateCompany")
	public String setUpdateCompany(CompanyVO companyVO) {
		companyService.setUpdateCompany(companyVO);
		return "redirect:getCompanyList";
	}

	// 뭔가 크게 의미 없는 삭제처리
	@RequestMapping("/setDeleteCompany")
	public String setDeleteCompany(CompanyVO companyVO, Model model) {
		if(companyService.getBuyCount(companyVO) > 0 || companyService.getSaleCount(companyVO) >0) {
			model.addAttribute("msg", "거래이력이 있어 삭제할 수 없습니다.");
			model.addAttribute("loc", "getCompanyList");
			return "common/msg";
		} else {
			companyService.setDeleteCompany(companyVO);
			return "redirect:getCompanyList";		
		}
	}

	// view resolver 방식 pdf 출력
	@RequestMapping("companyPdf.do")
	public ModelAndView getSaleLedgerListReport(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pdfView");
		mv.addObject("filename", "/reports/companyPdf_view.jrxml");
		return mv;
	}

	// excel 출력
	@RequestMapping("company_excel.do")
	public ModelAndView companyexcel(CompanyVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("commonExcelView");
		mv.addObject("datas", companyService.getCompanyMap(vo));// Map객체를 조회해서 시트를 생성한다.
		mv.addObject("filename", "companylist");// 파일이름을 바꿔준다.
		mv.addObject("headers", new String[] {  "회사명", "전화번호", "주소", "대표자명", "거래은행", "계좌번호", "담당자명", "담당자전화번호" }); // 헤더의 값만 출력된다.
		return mv;
	}
	
	// 가장 거래량 많은 거래처
	@RequestMapping("getVipCompany")
	@ResponseBody
	public CompanyVO getVipCompany(CompanyVO vo) {
		return companyService.getVipCompany(vo);
	}
}