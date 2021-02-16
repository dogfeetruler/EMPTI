package com.hein.empti.bank.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.bank.BankVO;
import com.hein.empti.bank.mapper.BankMapper;
import com.hein.empti.bank.service.BankService;

@Service
public class BankServiceImpl implements BankService {

	@Autowired
	BankMapper bankMapper;
	
	@Override
	public List<BankVO> getBankList(BankVO bankVO) {
		return bankMapper.getBankList(bankVO);
	}

}
