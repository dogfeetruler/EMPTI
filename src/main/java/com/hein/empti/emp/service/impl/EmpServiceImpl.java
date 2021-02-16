package com.hein.empti.emp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.dept.DeptVO;
import com.hein.empti.emp.EmpVO;
import com.hein.empti.emp.mapper.EmpMapper;
import com.hein.empti.emp.service.EmpService;

@Service
public class EmpServiceImpl implements EmpService {

	@Autowired
	EmpMapper empMapper;
	
	//단건
	@Override
	public EmpVO getEmp(EmpVO empVO) {
		return empMapper.getEmp(empVO);
	}

	//전체
	@Override
	public List<EmpVO> getEmpList(EmpVO empVO) {
		return empMapper.getEmpList(empVO);
	}

	//등록
	@Override
	public void setInsertEmp(EmpVO empVO) {
		empMapper.setInsertEmp(empVO);
	}

	//수정
	@Override
	public void setUpdateEmp(EmpVO empVO) {
		empMapper.setUpdateEmp(empVO);
	}

	//삭제
	@Override
	public void setDeleteEmp(EmpVO empVO) {
		empMapper.setDeleteEmp(empVO);
	}
	
	//차트데이터
	@Override
	public List<Map<String, Object>> getDeptEmpCnt() {
		return empMapper.getDeptEmpCnt();
	}

	@Override
	public List<Map<String, Object>> getEmpMap(EmpVO vo) {
		return empMapper.getEmpMap(vo);
	}
	
	@Override
	public int getDeptCount(DeptVO deptVO) {
		return empMapper.getDeptCount(deptVO);
	}

	//사번 max
	@Override
	public EmpVO empIdMax(EmpVO empVO) {
		return empMapper.empIdMax(empVO);
	}
	
	
	
	
}