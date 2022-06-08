package com.uni.spring.employee.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.uni.spring.common.CommException;
import com.uni.spring.employee.model.dao.EmployeeDao;
import com.uni.spring.employee.model.dto.Employee;

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
}

