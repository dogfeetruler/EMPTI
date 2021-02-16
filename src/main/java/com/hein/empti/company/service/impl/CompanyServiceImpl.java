package com.hein.empti.company.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.company.CompanyVO;
import com.hein.empti.company.mapper.CompanyMapper;
import com.hein.empti.company.service.CompanyService;

@Service
public class CompanyServiceImpl implements CompanyService {

	@Autowired CompanyMapper companyMapper;

	@Override
	public List<CompanyVO> getCompanyList(CompanyVO companyVO) {
		return companyMapper.getCompanyList(companyVO);
	}

	@Override
	public List<CompanyVO> findCompany(CompanyVO companyVO) {
		return companyMapper.findCompany(companyVO);
	}

	@Override
	public CompanyVO getCompany(CompanyVO companyVO) {
		return companyMapper.getCompany(companyVO);
	}

	@Override
	public CompanyVO comNoMax(CompanyVO companyVO) {
		return companyMapper.comNoMax(companyVO);
	}

	@Override
	public void setInsertCompany(CompanyVO companyVO) {
		companyMapper.setInsertCompany(companyVO);
	}

	@Override
	public void setUpdateCompany(CompanyVO companyVO) {
		companyMapper.setUpdateCompany(companyVO);
	}

	@Override
	public void setDeleteCompany(CompanyVO companyVO) {
		companyMapper.setDeleteCompany(companyVO);
	}

	@Override
	public List<Map<String, Object>> getCompanyMap(CompanyVO vo) {
		return companyMapper.getCompanyMap(vo);
	}
	
	//삭제 count
	@Override
	public int getBuyCount(CompanyVO companyVO) {
		return companyMapper.getBuyCount(companyVO);
	}

	@Override
	public int getSaleCount(CompanyVO companyVO) {
		return companyMapper.getSaleCount(companyVO);
	}

	//가장 주문량 많은 거래처
	@Override
	public CompanyVO getVipCompany(CompanyVO vo) {
		return companyMapper.getVipCompany(vo);
	}
}