package com.hein.empti.bank.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hein.empti.bank.BankVO;
import com.hein.empti.bank.service.BankService;

@Controller
public class BankController {

	@Autowired
	BankService bankService;
	
	@RequestMapping("/findBank")
	public String findBank(Model model, BankVO bankVO) {
		List<BankVO> list = bankService.getBankList(bankVO);
		for (BankVO bc : list) {
			if(bc.getBank_code().length() == 1) {
				bankVO.setBank_code("00"+ bc.getBank_code());
			} else if(bc.getBank_code().length() == 2) {
				bankVO.setBank_code("0"+ bc.getBank_code());
			} else {
				bankVO.setBank_code(bc.getBank_code());
			}
		}
		model.addAttribute("findBank", list);
		return "common/findBank";
	}
	
}
