package com.hein.empti.emp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class EmpVO {
	String emp_id;
	String name;
	String pwd;
	String pwd2;
	String phone;
	String zip_code;
	String address;
	String address_detail;
	String email;
	String hire_date;
	String salary;
	String position;
	String status;
	String bank_name;
	String account_no;
	String dept_id;
	String mgr_id;
	String profile;
	MultipartFile uploadFile;
	
//	emplist_view의 VO
	String dept_name;
	String manager;
}