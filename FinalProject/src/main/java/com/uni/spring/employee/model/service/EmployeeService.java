package com.uni.spring.employee.model.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.spring.employee.model.dto.Employee;

public interface EmployeeService {

	void insertEmployee(Employee emp) throws Exception;

	Employee loginEmployee(BCryptPasswordEncoder bCryptPasswordEncoder, Employee emp);

	int idCheck(String userId);

	Employee updateEmp(Employee emp)throws Exception;

}
