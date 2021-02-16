package com.hein.empti.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hein.empti.emp.service.EmpService;
import com.hein.empti.menu.service.MenuService;
import com.hein.empti.role.service.RoleService;

public class RoleInterceptor extends HandlerInterceptorAdapter {
	// controller로 보내기 전에 처리하는 인터셉터
	// 반환이 false라면 controller로 요청을 안함
	// 매개변수 Object는 핸들러 정보를 의미한다.
	
	@Autowired MenuService menuService;
	@Autowired RoleService roleService;
	
	// 컨트롤러가 호출되기 전에 실행되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, 
							 HttpServletResponse response, 
							 Object obj) throws Exception {
		
		
		return true;
	}
}