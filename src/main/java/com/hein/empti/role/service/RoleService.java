package com.hein.empti.role.service;

import java.util.List;

import com.hein.empti.role.RoleVO;

public interface RoleService {
	//롤 전체조회
	public List<RoleVO> getRoleList(RoleVO roleVO);
	
	//사원 롤 부여, 삭제
	public void setInsertEmpRole(RoleVO roleVO);
	public void setDeleteEmpRole(RoleVO roleVO);
}
