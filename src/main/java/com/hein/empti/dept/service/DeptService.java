package com.hein.empti.dept.service;

import java.util.List;
import java.util.Map;

import com.hein.empti.dept.DeptVO;

public interface DeptService {

	public DeptVO getDept(DeptVO deptVO);
	public List<DeptVO> getDeptList(DeptVO deptVO);
	public void setInsertDept(DeptVO deptVO);
	public void setUpdateDept(DeptVO deptVO);
	public void setDeleteDept(DeptVO deptVO);
	public int getDeptCount(DeptVO deptVO);

	
	//Dept_view (Map) 엑셀
	public List<Map<String, Object>> getDeptMap(DeptVO vo);
}
