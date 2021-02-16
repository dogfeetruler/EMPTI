package com.hein.empti.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.hein.empti.emp.EmpVO;
import com.hein.empti.emp.mapper.EmpMapper;

@Component("loginSuccessHandler")
public class LoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	
	@Autowired EmpMapper empMapper;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		super.setDefaultTargetUrl("/main");
		super.onAuthenticationSuccess(request, response, authentication);
		EmpVO empVO = new EmpVO();
		User vo  =  (User) authentication.getPrincipal();
		empVO.setEmp_id(vo.getUsername());
		request.getSession().setAttribute("login", empMapper.getEmp(empVO));
	}
}