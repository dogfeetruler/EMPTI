package com.hein.empti.login;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hein.empti.emp.EmpVO;
import com.hein.empti.emp.mapper.EmpMapper;


@Controller
public class LoginController {
	@Autowired EmpMapper empMapper;
	
  	//로그인 처리
	//@RequestMapping(value = "/login", method=RequestMethod.POST)
	//@ResponseBody //아작스는 데이터만 넘어감
	public Map login(EmpVO empVO, HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		EmpVO result = empMapper.getEmp(empVO);

		if(result == null) {
			map.put("errorMsg", "id오류");
			map.put("result", false);
			
		} else if (!result.getPwd().equals(empVO.getPwd())) {
			map.put("errorMsg", "pwd오류");
			map.put("result", false);
			
		} else {
			session.setAttribute("login", result);
			map.put("result", true);
		}
		return map;
	}
	
	@RequestMapping("/loginForm")
	public String loginForm(Model modle) {
		return "common/login";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "common/login";
	}
}
