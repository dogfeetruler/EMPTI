package com.hein.empti.menu.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hein.empti.menu.MenuVO;
import com.hein.empti.menu.service.MenuService;

@Controller
public class MenuController {
	
	@Autowired
	MenuService menuService;
	
	@RequestMapping("/getMenu")
	public MenuVO getMenu(MenuVO menuVO, Model model) {
		
		return menuService.getMenu(menuVO);
	}
	
	@RequestMapping("/getMenuList")
	public List<MenuVO> getMenuList(MenuVO menuVO, Model model) {
		
		return menuService.getMenuList(menuVO);
	}
}
