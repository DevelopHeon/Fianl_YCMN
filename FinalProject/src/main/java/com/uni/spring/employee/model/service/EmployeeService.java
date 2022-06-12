package com.uni.spring.employee.model.service;

import java.util.ArrayList;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.WorkingDay;

public interface EmployeeService {

	void insertEmployee(Employee emp) throws Exception;

	Employee loginEmployee(BCryptPasswordEncoder bCryptPasswordEncoder, Employee emp);

	int idCheck(String userId);

	Employee updateEmp(Employee emp)throws Exception;

	WorkingDay insertStart(WorkingDay w);
	
	WorkingDay updateFinish(WorkingDay w);

	ArrayList<Employee> selectEmpAddress();

	ArrayList<WorkingDay> selectWorkingInfo(int empNo);

	Attachment updateImg(Attachment attachment);

}
