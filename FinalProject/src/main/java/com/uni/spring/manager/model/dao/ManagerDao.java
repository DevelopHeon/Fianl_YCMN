package com.uni.spring.manager.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.JobPosition;
import com.uni.spring.hr.model.dto.Hr;

@Repository
public class ManagerDao {

	// 사원 정보 전체 불러오기
	public ArrayList<Employee> selectList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("managerMapper.employeeList");
	}
	// 선택한 사원 정보 불러오기
	public static Employee selectEmp(SqlSessionTemplate sqlSession, int eno) {
		return sqlSession.selectOne("managerMapper.selectEmployee", eno);
	}
	// 선택한 사원 인사기록 조회
	public static Employee selectHr(SqlSessionTemplate sqlSession, int eno) {
		return sqlSession.selectOne("managerMapper.selectEmpHr", eno);
	}
	// 직위 정보 불러오기
	public ArrayList<JobPosition> getPosList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("managerMapper.selectPosList");
	}
	// 부서 정보 불러오기
	public ArrayList<Department> getDepList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("managerMapper.selectDepList");
	}
	// 사원 기본정보 수정
	public int updateEmpDetail(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.update("managerMapper.updateEmp", e);
	}
	// 사원 인사정보 수정
	public int updateEmpHr(SqlSessionTemplate sqlSession, Hr hr) {
		return sqlSession.update("managerMapper.updateEmpHr", hr);
	}
	// 엑셀 다운로드
	public ArrayList<Employee> selectExcelList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("managerMapper.selectExcelList");
	}
}
