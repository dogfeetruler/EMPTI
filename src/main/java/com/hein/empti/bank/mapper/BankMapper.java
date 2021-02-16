package com.hein.empti.bank.mapper;

import java.util.List;

import com.hein.empti.bank.BankVO;

public interface BankMapper {
	public List<BankVO> getBankList(BankVO bankVO);
}
