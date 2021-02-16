package com.hein.empti.menu.service;

import java.util.List;

import com.hein.empti.menu.MenuVO;

public interface MenuService {
	public MenuVO getMenu(MenuVO menuVO);
	public List<MenuVO> getMenuList(MenuVO menuVO);
}
