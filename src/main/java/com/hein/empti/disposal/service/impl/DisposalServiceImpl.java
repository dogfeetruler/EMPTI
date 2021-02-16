package com.hein.empti.disposal.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.hein.empti.disposal.DisposalVO;
import com.hein.empti.disposal.mapper.DisposalMapper;
import com.hein.empti.disposal.service.DisposalService;

@Service
public class DisposalServiceImpl implements DisposalService{
	
	@Autowired
	DisposalMapper disposalMapper;

	@Override
	public DisposalVO getDisposal(DisposalVO disposalVO) {
		return disposalMapper.getDisposal(disposalVO);
	}

	@Override
	public List<Map<String, Object>> getDisposalList(DisposalVO disposalVO) {
		return disposalMapper.getDisposalList(disposalVO);
	}

	@Override
	public void setInsertDisposal(DisposalVO disposalVO) {
		disposalVO.setDisposal_date(disposalVO.getDisposal_date().replace('T', ' '));
		disposalMapper.setInsertDisposal(disposalVO);
	}

	@Override
	public void setUpdateDisposal(DisposalVO disposalVO) {
		disposalVO.setDisposal_date(disposalVO.getDisposal_date().replace('T', ' '));
		disposalMapper.setUpdateDisposal(disposalVO);
	}

		
	@Override
	public void setDeleteDisposal(DisposalVO disposalVO) {
		disposalMapper.setDeleteDisposal(disposalVO);
	}

	@Override
	public List<Map<String, Object>> getDisposalMap(DisposalVO vo) {
		return disposalMapper.getDisposalMap(vo);
	}
	
	// 입/출고 기준 폐기/불량률 
	@Override
	public List<Map<String, Object>> getAvgDisposal() {
		return disposalMapper.getAvgDisposal();
	}
}