package com.hein.empti.dept.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hein.empti.dept.DeptVO;
import com.hein.empti.dept.service.DeptService;
import com.hein.empti.emp.EmpVO;
import com.hein.empti.emp.service.EmpService;

@Controller
public class DeptController {

	@Autowired
	DeptService deptService;

	@Autowired
	EmpService empService;

	// report
	@Autowired
	@Qualifier("dataSourceSpied")
	DataSource datasource;

	// 단건조회
	@RequestMapping("/getDeptList/{dept_id}")
	public String getDept(@PathVariable String dept_id) {
		return "admin/dept/deptList";
	}

	// 전체조회
	@RequestMapping("/getDeptList")
	public String getDeptList(Model model, DeptVO deptVO) {
		model.addAttribute("deptList", deptService.getDeptList(deptVO));
		return "admin/dept/deptList";
	}

	// 등록폼 필요
	@RequestMapping("/setInsertFormDept")
	public String setInsertFormDept(DeptVO deopVO, Model model, EmpVO empVO) {
		model.addAttribute("emp", empService.getEmpList(empVO));
		return "admin/dept/insertDept";
	}

	// 등록처리
	@RequestMapping("/setInsertDept")
	public String setInsertDept(Model model, DeptVO deptVO) {
		deptService.setInsertDept(deptVO);
		return "redirect:getDeptList";
	}

	// 수정폼
	@RequestMapping("/setUpdateFormDept")
	public String setUpdateFormDept(DeptVO deptVO, EmpVO empVO, Model model) {
		model.addAttribute("deptUp", deptService.getDept(deptVO));
		model.addAttribute("empList", empService.getEmpList(empVO));
		return "admin/dept/updateDept";
	}

	// 수정처리
	@RequestMapping("/setUpdateDept")
	public String setUpdateDept(Model model, DeptVO deptVO) {
		deptService.setUpdateDept(deptVO);
		return "redirect:getDeptList";
	}

	// 삭제처리
	@RequestMapping("/setDeleteDept")
	public String setDeleteDept(DeptVO deptVO, Model model) {
		if(deptService.getDeptCount(deptVO) > 0) {
			model.addAttribute("msg", "해당 부서에 사원이 있어 삭제할 수 없습니다.");
			model.addAttribute("loc", "getDeptList");
			return "common/msg";
		} else {
			deptService.setDeleteDept(deptVO);
			return "redirect:getDeptList";		
		}
	}

	// view resolver 방식
	@RequestMapping("departments_list.do")
	public ModelAndView getSaleLedgerListReport(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pdfView");
		mv.addObject("filename", "/reports/dept_view.jrxml");
		return mv;
	}

	// excel 출력
	@RequestMapping("dept_excel.do")
	public ModelAndView deptexcel(DeptVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("commonExcelView");
		mv.addObject("datas", deptService.getDeptMap(vo));// Map객체를 조회해서 시트를 생성한다.
		mv.addObject("filename", "deptlist");// 파일이름을 바꿔준다.
		mv.addObject("headers", new String[] { "부서번호", "부서명", "매니저성명" }); // 헤더의 값만 출력된다.
		return mv;
	}

}
