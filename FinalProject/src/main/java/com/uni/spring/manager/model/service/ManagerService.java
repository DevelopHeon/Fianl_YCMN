package com.uni.spring.manager.model.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.JobPosition;
import com.uni.spring.hr.model.dto.Hr;

public interface ManagerService {

	ArrayList<Employee> selectList();

	Object selectEmp(int eno);

	ArrayList<JobPosition> getPosList();
	
	ArrayList<Department> getDepList();

	Object selectHr(int eno);

	void updateEmpDetail(Employee e, Hr hr);

	ArrayList<Employee> selectExcelList(); // 엑셀

}