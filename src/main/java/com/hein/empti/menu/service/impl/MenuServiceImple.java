package com.hein.empti.menu.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.menu.MenuVO;
import com.hein.empti.menu.mapper.MenuMapper;
import com.hein.empti.menu.service.MenuService;

@Service
public class MenuServiceImple implements MenuService {

	@Autowired
	MenuMapper menuMapper;
	
	
	@Override
	public MenuVO getMenu(MenuVO menuVO) {
		return menuMapper.getMenu(menuVO);
	}

	@Override
	public List<MenuVO> getMenuList(MenuVO menuVO) {
		return menuMapper.getMenuList(menuVO);
	}

}
