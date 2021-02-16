package com.hein.empti.dept;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DeptVO {
	String dept_id;
	String dept_name;
	String emp_id;

	//조인
	String name;
}
