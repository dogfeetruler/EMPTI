package com.hein.empti.menu.mapper;

import java.util.List;

import com.hein.empti.menu.MenuVO;

public interface MenuMapper {
	public MenuVO getMenu(MenuVO menuVO);
	public List<MenuVO> getMenuList(MenuVO menuVO);
	
}
