package com.hein.empti.saleorderdetails;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SaleorderdetailsVO {
	String sorderdetail_no;
	String sorder_no;
	String sorder_qty;
	String item_no;
	
	//ITEMS JOIN
	String item_name;
	String item_price;
}