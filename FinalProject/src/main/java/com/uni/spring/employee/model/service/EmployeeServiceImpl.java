package com.uni.spring.employee.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.employee.model.dao.EmployeeDao;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.WorkingDay;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {

	private final EmployeeDao employeeDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public void insertEmployee(Employee emp) throws Exception {
		int result = employeeDao.insertEmployee(sqlSession, emp);
		}

	@Override
	public Employee loginEmployee(BCryptPasswordEncoder bCryptPasswordEncoder, Employee emp) {
		
		Employee loginUser = employeeDao.loginEmployee(sqlSession, emp);
		
		if(loginUser == null) {
			throw new CommException("loginUser확인");
		}
		
		if(!bCryptPasswordEncoder.matches(emp.getEmpPwd(), loginUser.getEmpPwd())) {
			throw new CommException("비밀번호가 틀렸습니다.");
		}
		return loginUser;
	}

	@Override
	public int idCheck(String empId) {
		int result = employeeDao.idCheck(sqlSession, empId);
		
		if(result < 0) {
			throw new CommException("아이디 중복확인 실패");
		}
		
		return result;
	}

	@Override
	public Employee updateEmp(Employee emp) {
		
		int result = employeeDao.updateEmp(sqlSession, emp);
		
		if(result > 0) {
			Employee loginUser = employeeDao.loginEmployee(sqlSession, emp);
			return loginUser;
		}else {
			throw new CommException("사원 정보 수정 실패");
		}
	}
	
	//근태정보
	@Override
	public ArrayList<WorkingDay> selectWorkingInfo(int empNo) {

		return employeeDao.selectWorkingInfo(sqlSession, empNo);
	}
	
	//근태-출근체크
	@Override
	public WorkingDay insertStart(WorkingDay w) {
		
		int result = employeeDao.insertStart(sqlSession, w);
		
		//출근 체킹 완
		if(result > 0) {
			return w;
		} else {
			throw new CommException("출근 등록 실패");
		}
	}

	//근태-퇴근체크
	@Override
	public WorkingDay updateFinish(WorkingDay w) {
		int result = employeeDao.updateFinish(sqlSession, w);
		System.out.println(result);
		//퇴근 체킹 완
		if(result > 0) {	
			return w;
		} else {
			throw new CommException("퇴근 등록 실패");
		}
	}
	
	
	@Override
	public ArrayList<Employee> selectEmpAddress() {
		
		return employeeDao.selectEmpAddress(sqlSession);
	}

	//프로필 변경
	@Override
	public Attachment updateImg(Attachment attachment) {
		int result = employeeDao.updateImg(sqlSession, attachment);
		//트리거 insert실패시 쿼리짜기
		//int resultEmp = employeeDao.updateImg(sqlSession, emp);
		
		if(result > 0) {
			
			return attachment;
		}else {
			throw new CommException("프로필 변경 실패");
		}
	}

	

	

	
}

