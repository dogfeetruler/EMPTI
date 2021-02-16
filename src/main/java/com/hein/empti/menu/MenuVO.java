package com.hein.empti.menu;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MenuVO {
	String menu_no;
	String menu_name;
	String menu_addr;
	String group_name;
	String role_id;
	
	//Join용 프로퍼티
	String emp_id;
}
