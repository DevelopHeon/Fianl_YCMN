package com.uni.spring.employee.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.WorkingDay;

@Repository
public class EmployeeDao {

	public int insertEmployee(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.insert("employeeMapper.insertEmployee", emp);
	}

	public Employee loginEmployee(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.selectOne("employeeMapper.loginEmployee", emp);
	}

	public int idCheck(SqlSessionTemplate sqlSession, String empId) {
		return sqlSession.selectOne("employeeMapper.idCheck", empId);
	}
	//사원정보 수정
	public int updateEmp(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.update("employeeMapper.updateEmp", emp);
	}

	//근태정보
	public ArrayList<WorkingDay> selectWorkingInfo(SqlSessionTemplate sqlSession, int empNo) {	
		return (ArrayList)sqlSession.selectList("employeeMapper.selectWorkingInfo", empNo);
	}
	
	//출근체크
	public int insertStart(SqlSessionTemplate sqlSession, WorkingDay w) {	
		return sqlSession.insert("employeeMapper.insertStart", w);
	}

	//퇴근체크
	public int updateFinish(SqlSessionTemplate sqlSession, WorkingDay w) {	
		return sqlSession.update("employeeMapper.updateFinish", w);
	}
	
	//주소록
	public ArrayList<Employee> selectEmpAddress(SqlSessionTemplate sqlSession) {	
		return (ArrayList)sqlSession.selectList("employeeMapper.selectEmpAddress");
	}
	
	//프로필 변경
	public int updateImg(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.insert("employeeMapper.updateImg", attachment);
	}





	


}
