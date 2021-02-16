package com.hein.empti.company.mapper;

import java.util.List;
import java.util.Map;

import com.hein.empti.company.CompanyVO;

public interface CompanyMapper {
	public List<CompanyVO> getCompanyList(CompanyVO companyVO);
	public CompanyVO getCompany(CompanyVO companyVO);
	public void setInsertCompany(CompanyVO companyVO);
	public void setUpdateCompany(CompanyVO companyVO);
	public void setDeleteCompany(CompanyVO companyVO);
	
	// 거래처 번호 MAX 
	public CompanyVO comNoMax(CompanyVO companyVO);
	
	//삭제 count
	public int getBuyCount(CompanyVO companyVO);
	public int getSaleCount(CompanyVO companyVO);
	
	//거래처 검색
	public List<CompanyVO> findCompany(CompanyVO companyVO);
	
	//거래처 리스트 (Map) 엑셀
	public List<Map<String, Object>> getCompanyMap(CompanyVO vo);
 
	// 가장 주문량이 많은 거래처
	public CompanyVO getVipCompany(CompanyVO vo);
}
