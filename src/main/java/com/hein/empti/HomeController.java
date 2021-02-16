package com.hein.empti;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hein.empti.menu.MenuVO;
import com.hein.empti.menu.service.MenuService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	//우리의 점화 페이지 (로그인 페이지)
	@RequestMapping("/")
	public String home(Model model) {
		return "common/login";
		//return "admin/index";
	}
	
	//404에러 페이지
	@RequestMapping("/404error")
	public String error(Model model) {
		return "admin/common/404";
	}
	
	//메인 페이지
	@RequestMapping("/main")
	public String main(Model model) {
		return "admin/index";
	}
}
