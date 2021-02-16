package com.hein.empti.emp.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hein.empti.dept.DeptVO;
import com.hein.empti.dept.service.DeptService;
import com.hein.empti.emp.EmpVO;
import com.hein.empti.emp.FileRenamePolicy;
import com.hein.empti.emp.service.EmpService;

@Controller //Bean등록, Dispatcher Servlet이 인식할 수 있는 Controller로 변환 //@Component 상속
public class EmpController {
	
	@Autowired EmpService empService;
	
	@Autowired DeptService deptService;
	
	//report
	@Autowired
	@Qualifier("dataSourceSpied") 
	DataSource datasource; 	
	
	//단건조회
	@RequestMapping("/getEmp/{emp_id}")
	public String getEmp(@PathVariable String emp_id, EmpVO empVO, Model model) {
		model.addAttribute("getEmp", empService.getEmp(empVO));
		return "emp/empDetail";
	}
	
	//상세정보
	@RequestMapping("/getEmpDetail")
	public String getEmpDetail(EmpVO empVO, Model model) {
		model.addAttribute("getEmp", empService.getEmp(empVO));
		return "emp/empDetail";
	}
		
	//전체조회
	@RequestMapping("/getEmpList")
	public String getEmpList(EmpVO empVO, Model model) {
		model.addAttribute( "empList",empService.getEmpList(empVO));
		return "admin/emp/empList";
	}
	
	//등록폼
	@RequestMapping("/setInsertFormEmp")
	public String setInsertFormEmp(EmpVO empVO, Model model, DeptVO deptVO) {
		model.addAttribute("empId", empService.empIdMax(empVO));
		model.addAttribute("dept", deptService.getDeptList(deptVO));
		return "admin/emp/insertEmp";
	}
	//등록처리
	@RequestMapping("/setInsertEmp")
	public String setInsertEmp(EmpVO empVO,Model model) throws IOException {
		empVO.setSalary(empVO.getSalary().replace(",", ""));
		MultipartFile file = empVO.getUploadFile();
		String filename = file.getOriginalFilename();
		if (file != null && file.getSize() > 0) {
			File upFile = FileRenamePolicy.rename(new File("D:/upload",filename));
			filename = upFile.getName();
			file.transferTo(upFile);
			}
		empVO.setProfile(filename);
		empService.setInsertEmp(empVO);
		return "redirect:getEmpList";
	}
	
	/*
	 * //수정폼
	 * 
	 * @RequestMapping("/setUpdateFormEmp/{emp_id}") public String
	 * setUpdateFormEmp(@PathVariable String emp_id,Model model, EmpVO empVO, DeptVO
	 * deptVO) { empVO.setEmp_id(emp_id); empVO = empService.getEmp(empVO);
	 * model.addAttribute("empUp", empVO); model.addAttribute("deptList",
	 * deptService.getDeptList(deptVO)); return "admin/emp/updateEmp"; }
	 */
	
	//session login 수정 폼
	@RequestMapping("/mySetUpdateFormEmp")
	public String setUpdateFormEmp(EmpVO empVO, Model model, DeptVO deptVO,HttpSession session) {

		EmpVO login =(EmpVO) session.getAttribute("login");
		empVO.setEmp_id(login.getEmp_id());
		empVO = empService.getEmp(empVO);
		model.addAttribute("empUp", empService.getEmp(empVO));
		model.addAttribute("deptList", deptService.getDeptList(deptVO));
		return "admin/emp/updateEmp";
	}
	//수정폼
	@RequestMapping("/setUpdateFormEmp")
	public String setUpdateFormEmp(Model model, EmpVO empVO, DeptVO deptVO) {
		empVO = empService.getEmp(empVO);
		model.addAttribute("empUp", empVO);
		model.addAttribute("deptList", deptService.getDeptList(deptVO));
		return "admin/emp/updateEmp";
	}
	

	
	//수정처리
	@RequestMapping("/mySetUpdateEmp")
	public String mySetUpdateEmp(EmpVO empVO, Model model, HttpSession session) throws IOException {
		MultipartFile file = empVO.getUploadFile();
		String filename = file.getOriginalFilename();
		if (file != null && file.getSize() > 0) {
			File upFile = FileRenamePolicy.rename(new File("D:/upload",filename));
			filename = upFile.getName();
			file.transferTo(upFile);
			empVO.setProfile(filename);
		}
		empService.setUpdateEmp(empVO);
		session.setAttribute("login", empService.getEmp(empVO));
		return "redirect:main";
	}
	
	//수정 처리
	@RequestMapping("/setUpdateEmp")
	public String setUpdateEmp(EmpVO empVO, Model model, HttpSession session) throws IOException {
		MultipartFile file = empVO.getUploadFile();
		String filename = file.getOriginalFilename();
		if (file != null && file.getSize() > 0) {
			File upFile = FileRenamePolicy.rename(new File("D:/upload",filename));
			filename = upFile.getName();
			file.transferTo(upFile);
			empVO.setProfile(filename);
		}
		empService.setUpdateEmp(empVO);
		return "redirect:getEmpList";
	}
	

	
	//삭제처리
	@RequestMapping("/setDeleteEmp")
	public String setDeleteEmp(EmpVO empvo, Model model) {
		empService.setDeleteEmp(empvo);
		return "redirect:getEmpList";
	}
	
	//다운로드
	@RequestMapping("/download")
	public ModelAndView download(@RequestParam String name) {

		File file = new File("D:/upload");
		if(!file.exists())
			file.mkdir();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("download");		
		mv.addObject("downloadFile", new File("D:/upload", name));
		
		return mv;
	}
	
	//view resolver 방식
	@RequestMapping("employees_list.do")
	public ModelAndView getSaleLedgerListReport(HttpServletRequest request, HttpServletResponse response) throws Exception{
	ModelAndView mv = new ModelAndView();
	mv.setViewName("pdfView");
	mv.addObject("filename", "/reports/emplist_view2.jrxml");
	return mv;
	}
	
	//차트데이터
	@RequestMapping("getDeptEmpCnt")
	public @ResponseBody List<Map<String,Object>> getDeptEmpCnt(){
		return empService.getDeptEmpCnt(); 
	}
	
	// excel 출력
	@RequestMapping("emp_excel.do")
	public ModelAndView empexcel(EmpVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("commonExcelView");
		mv.addObject("datas", empService.getEmpMap(vo));// Map객체를 조회해서 시트를 생성한다.
		mv.addObject("filename", "emplist");// 파일이름을 바꿔준다.
		mv.addObject("headers", new String[] { "사원번호","성명","부서명","전화번호","주소","이메일","구분"}); // 헤더의 값만 출력된다.
		return mv;
	}
	
}