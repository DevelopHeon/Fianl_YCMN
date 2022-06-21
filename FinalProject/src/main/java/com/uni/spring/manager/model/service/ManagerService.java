package com.uni.spring.manager.model.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.JobPosition;
import com.uni.spring.hr.model.dto.Hr;

public interface ManagerService {
	
	ArrayList<Employee> selectList(); // 사원 정보 전체 조회

	Object selectEmp(int eno); // 선택한 사원 정보 조회

	Object selectHr(int eno); // 선택한 사원 인사정보 조회

	void updateEmpDetail(Employee e, Hr hr); // 선택한 사원 전체 정보 수정

	ArrayList<JobPosition> getPosList(); // 직위 정보 조회
	
	void insertJobPosition(JobPosition job); // 직위 추가
	
	void updateJobPosition(JobPosition job); // 직위 수정
	
	void deleteJobPosition(JobPosition job); // 직위 삭제
	
	ArrayList<Department> getDepList(); // 부서 정보 조회

	void insertDepartment(Department dep); // 부서 추가
	
	void updateDepartment(Department dep); // 부서 수정
	
	void deleteDepartment(Department dep); // 부서 삭제
	
	ArrayList<Employee> selectExcelList(); // 엑셀 다운로드용 직원 정보 조회

	ArrayList<Employee> selectList(String find, String keyword, int i); // 검색기능추가
	
}