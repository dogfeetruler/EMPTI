package com.hein.empti.ledger;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LedgerVO {
	String ldgr_no;
	String ldgr_date;
	String total_amount;
	String condition;
	String border_no;
	String sorder_no;
	String note;
	String status;
	
	//건수(count)
	String count;
	
	//월별 검색
	String radioStatus;
	String startDate;
	String endDate;
	
	//영업이익
	String profits;
}