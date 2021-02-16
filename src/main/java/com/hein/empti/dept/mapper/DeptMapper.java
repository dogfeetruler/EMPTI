package com.hein.empti.dept.mapper;

import java.util.List;
import java.util.Map;

import com.hein.empti.dept.DeptVO;

public interface DeptMapper {

	public DeptVO getDept(DeptVO deptVO);
	public List<DeptVO> getDeptList(DeptVO deptVO);
	public void setInsertDept(DeptVO deptVO);
	public void setUpdateDept(DeptVO deptVO);
	public void setDeleteDept(DeptVO deptVO);
	public int getDeptCount(DeptVO deptVO);
	
	//폐기 불량 리스트(Map) 엑셀
	public List<Map<String, Object>> getDeptMap(DeptVO vo);
	
}
