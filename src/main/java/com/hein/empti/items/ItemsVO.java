package com.hein.empti.items;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemsVO {

		String	item_no;
		String	item_name;
		String	category;
		String	unit;
		String	exp_date;
		String	item_price;

}
