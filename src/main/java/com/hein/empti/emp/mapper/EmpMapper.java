package com.hein.empti.emp.mapper;

import java.util.List;
import java.util.Map;

import com.hein.empti.dept.DeptVO;
import com.hein.empti.emp.EmpVO;

public interface EmpMapper {
	
	public EmpVO getEmp(EmpVO empVO);
	public List<EmpVO> getEmpList(EmpVO empVO);
	public void setInsertEmp(EmpVO empVO);
	public void setUpdateEmp(EmpVO empVO);
	public void setDeleteEmp(EmpVO empVO);
	public List<Map<String,Object>> getDeptEmpCnt();
	public int getDeptCount(DeptVO deptVO);
	
	//emp (Map)엑셀
	public List<Map<String, Object>> getEmpMap(EmpVO vo);
	
	//사번 max값
	public EmpVO empIdMax(EmpVO empVO);

}