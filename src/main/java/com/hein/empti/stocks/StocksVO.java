package com.hein.empti.stocks;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class StocksVO {
		String stock_no;
		String stock_date;
		String stock_qty;
		String stock_category;
		String strg_no;
		String item_no;
		String stock_status;
		String release_no;
		String border_no;
		String real_qty;
		
		//입력값
		String input_qty;
		
		//JOIN
		String item_name;
		String company_no;
		String company_name;
		String strg_category;
		String border_date;
		String border_qty;
		String borderdetail_no;
		//검색
		/*
		 * String selectCategory; String startDate; String endDate;
		 */
}
