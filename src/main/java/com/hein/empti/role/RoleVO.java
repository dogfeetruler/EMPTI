package com.hein.empti.role;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RoleVO {
	String id;
	String role_name;
	String description;
	
	//EMP_ROLE의 프로퍼티
	String role_id;
	String emp_id;
	    
	String roleYn;
}