package com.hein.empti.buyorders;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BuyordersVO {
	//Buyorders
	String border_no;
	String border_date;
	String buy_sum;
	String status;
	String company_no;
	String emp_id;
	
	//반품
	String return_date;
	String return_no;
	
	//Join
	String name;
	String company_name;
	
	//count
	String count;
	
	// 잔금
	String balance;
	
}
