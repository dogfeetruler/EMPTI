package com.hein.empti.role.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hein.empti.role.RoleVO;
import com.hein.empti.role.service.RoleService;

@Controller
public class RoleController {

	@Autowired RoleService roleService;
	
	//롤 전체 조회
	@RequestMapping("/getRoleList")
	public String getRoleList(Model model, RoleVO roleVO) {
		//roleVO.setEmp_id(((EmpVO)session.getAttribute("emp_id")).getEmp_id());
		model.addAttribute("roleList", roleService.getRoleList(roleVO));
		return "role/roleList";
	}
	
	//롤 등록
	@RequestMapping(value = "/setInsertEmpRole", method = RequestMethod.POST)
	@ResponseBody
	public Map setInsertStocks(@RequestBody RoleVO roleVO, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		roleService.setInsertEmpRole(roleVO);
		map.put("result", true);
		return map;
	}
	
	//롤 삭제
	@RequestMapping(value= "/setDeleteEmpRole", method = RequestMethod.POST)
	@ResponseBody
	public Map setDeletStocks(@RequestBody RoleVO roleVO, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		roleService.setDeleteEmpRole(roleVO);
		map.put("result", true);
		return map;
	}
}