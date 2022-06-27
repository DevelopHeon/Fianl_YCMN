package com.uni.spring.employee.model.service;

import java.util.ArrayList;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.TimeOff;
import com.uni.spring.employee.model.dto.TimeOffContent;
import com.uni.spring.employee.model.dto.WorkingDay;

public interface EmployeeService {

	void insertEmployee(Employee emp) throws Exception;

	Employee loginEmployee(BCryptPasswordEncoder bCryptPasswordEncoder, Employee emp);

	int idCheck(String userId);

	Employee updateEmp(Employee emp)throws Exception;

	WorkingDay insertStart(WorkingDay w, int empNo);
	
	WorkingDay updateFinish(WorkingDay w);

	ArrayList<Employee> selectEmpAddress();

	ArrayList<WorkingDay> selectWorkingInfo(int empNo);

	Attachment updateImg(Attachment attachment);

	int updateWorkHour(WorkingDay w);

	int selectStartCheck(int empNo);
	
	int selectFinishCheck(int empNo);

	void deleteImg(String empNo);

	Employee detailEmp(int empNo);

	ArrayList<Employee> selectSearchEmp(String empName);

	TimeOff selectTimeOff(int empNo);

	ArrayList<TimeOffContent> selectTimeOffContent(int empNo, PageInfo pi);

	int selectListCount(int empNo);

	void updateWorkStatusE(int empNo);

	void updateWorkStatusL(int empNo);

	void updateEmpOnOff(Employee loginUser);

	Employee selectEmpMypage(int empNo);

}
