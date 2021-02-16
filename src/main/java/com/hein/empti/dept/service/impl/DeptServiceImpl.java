package com.hein.empti.dept.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.dept.DeptVO;
import com.hein.empti.dept.mapper.DeptMapper;
import com.hein.empti.dept.service.DeptService;

@Service
public class DeptServiceImpl implements DeptService {

	@Autowired
	DeptMapper deptMapper;
	
	@Override
	public DeptVO getDept(DeptVO deptVO) {
		return deptMapper.getDept(deptVO);
	}

	@Override
	public List<DeptVO> getDeptList(DeptVO deptVO) {
		return deptMapper.getDeptList(deptVO);
	}

	@Override
	public void setInsertDept(DeptVO deptVO) {
		deptMapper.setInsertDept(deptVO);
	}

	@Override
	public void setUpdateDept(DeptVO deptVO) {
		deptMapper.setUpdateDept(deptVO);
	}

	@Override
	public void setDeleteDept(DeptVO deptVO) {
		deptMapper.setDeleteDept(deptVO);
	}

	@Override
	public List<Map<String, Object>> getDeptMap(DeptVO vo) {
		return deptMapper.getDeptMap(vo);
	}

	@Override
	public int getDeptCount(DeptVO deptVO) {
		return deptMapper.getDeptCount(deptVO);
	}
	
	

}
