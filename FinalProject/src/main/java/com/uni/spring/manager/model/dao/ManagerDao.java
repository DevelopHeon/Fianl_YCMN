package com.uni.spring.manager.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.JobPosition;
import com.uni.spring.hr.model.dto.Hr;
import com.uni.spring.manager.model.dto.Search;

@Repository
public class ManagerDao {

	// 사원 정보 전체 불러오기
	public ArrayList<Employee> selectList(SqlSessionTemplate sqlSession, PageInfo pi, Search search) {
//		public ArrayList<Employee> selectList(SqlSessionTemplate sqlSession, PageInfo pi, String find, String keyword) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("managerMapper.employeeList", search, rowBounds);
	}
	// 선택한 사원 정보 불러오기
	public static Employee selectEmp(SqlSessionTemplate sqlSession, int eno) {
		return sqlSession.selectOne("managerMapper.selectEmployee", eno);
	}
	// 선택한 사원 인사기록 조회
	public static Employee selectHr(SqlSessionTemplate sqlSession, int eno) {
		return sqlSession.selectOne("managerMapper.selectEmpHr", eno);
	}
	// 사원 기본정보 수정
	public int updateEmpDetail(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.update("managerMapper.updateEmp", e);
	}
	// 사원 인사정보 수정
	public int updateEmpHr(SqlSessionTemplate sqlSession, Hr hr) {
		return sqlSession.update("managerMapper.updateEmpHr", hr);
	}
	
	// 직위 정보 불러오기
	public ArrayList<JobPosition> getPosList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("managerMapper.selectPosList");
	}
	// 직위 추가
	public int insertJobPosition(SqlSessionTemplate sqlSession, JobPosition job) {
		return sqlSession.insert("managerMapper.insertJobPosition", job);
	}
	// 직위 수정
	public int updateJobPosition(SqlSessionTemplate sqlSession, JobPosition job) {
		return sqlSession.update("managerMapper.updateJobPosition", job);
	}
	// 직위 삭제
	public int deleteJobPosition(SqlSessionTemplate sqlSession, JobPosition job) {
		return sqlSession.update("managerMapper.deleteJobPosition", job);
	}
	
	// 부서 정보 불러오기
	public ArrayList<Department> getDepList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("managerMapper.selectDepList");
	}
	// 부서 추가
	public int insertDepartment(SqlSessionTemplate sqlSession, Department dep) {
		return sqlSession.insert("managerMapper.insertDepartment", dep);
	}
	// 부서 수정
	public int updateDepartment(SqlSessionTemplate sqlSession, Department dep) {
		return sqlSession.update("managerMapper.updateDepartment", dep);
	}
	// 부서 삭제
	public int deleteDepartment(SqlSessionTemplate sqlSession, Department dep) {
		return sqlSession.update("managerMapper.deleteDepartment", dep);
	}
	
	// 엑셀 다운로드
	public ArrayList<Employee> selectExcelList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("managerMapper.selectExcelList");
	}
//	// 검색 용
//	public ArrayList<Employee> selectList(SqlSessionTemplate sqlSession, String find, String keyword) {
//		return (ArrayList)sqlSession.selectMap("managerMapper.selectFindEmp", find, keyword);
//	}
	//	public ArrayList<Employee> selectList(SqlSessionTemplate sqlSession) {
//	return (ArrayList)sqlSession.selectList("managerMapper.employeeList");
	// 페이징 용
	public int selectListCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("managerMapper.selectListCount", search);
	}
}
