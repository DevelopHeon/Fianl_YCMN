package com.uni.spring.manager.model.service;

import java.io.OutputStream;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.uni.spring.common.CommException;
import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.JobPosition;
import com.uni.spring.hr.model.dto.Hr;
import com.uni.spring.manager.model.dao.ManagerDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ManagerServiceImpl implements ManagerService {

	private final ManagerDao managerDao;
	private final SqlSessionTemplate sqlSession;
	private final SqlSessionFactory sqlSessionFactory;
	
	// 사원 정보 전체 조회
	@Override
	public ArrayList<Employee> selectList() {
		return (ArrayList)managerDao.selectList(sqlSession);
	}
	
	// 선택한 사원 정보 조회
	@Override
	public Object selectEmp(int eno) {
		Employee e = ManagerDao.selectEmp(sqlSession, eno);
		return e;
	}
	// 선택한 사원 인사정보 조회
	@Override
	public Object selectHr(int eno) {
		Employee e = ManagerDao.selectHr(sqlSession, eno);
		return e;
	}
	
	// 선택한 사원 전체 정보 수정
	@Override
	public void updateEmpDetail(Employee e, Hr hr) {
		int result1 = managerDao.updateEmpDetail(sqlSession, e);
		int result2 = managerDao.updateEmpHr(sqlSession, hr);
		
		if(result1 < 0 || result2 < 0) {
			throw new CommException();
		}
	}
	
	// 직위 정보 조회
	@Override
	public ArrayList<JobPosition> getPosList() {
		return (ArrayList)managerDao.getPosList(sqlSession);
	}
	// 직위 추가
	@Override
	public void insertJobPosition(JobPosition job) {
		int result = managerDao.insertJobPosition(sqlSession, job);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	// 직위 수정
	@Override
	public void updateJobPosition(JobPosition job) {
		int result = managerDao.updateJobPosition(sqlSession, job);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	// 직위 삭제
	@Override
	public void deleteJobPosition(JobPosition job) {
		int result = managerDao.deleteJobPosition(sqlSession, job);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	
	// 부서 목록 조회
	@Override
	public ArrayList<Department> getDepList() {
		return (ArrayList)managerDao.getDepList(sqlSession);
	}
	// 부서 추가
	@Override
	public void insertDepartment(Department dep) {
		int result = managerDao.insertDepartment(sqlSession, dep);
		
		if(result < 0) {
			throw new CommException();
		}
	}

	// 부서 수정
	@Override
	public void updateDepartment(Department dep) {
		int result = managerDao.updateDepartment(sqlSession, dep);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	
	// 부서 삭제
	@Override
	public void deleteDepartment(Department dep) {
		int result = managerDao.deleteDepartment(sqlSession, dep);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	
	// 엑셀 다운로드용 직원 정보 조회
	@Override
	public ArrayList<Employee> selectExcelList() {
		return (ArrayList)managerDao.selectExcelList(sqlSession);
	}

	@Override
	public ArrayList<Employee> selectList(String find, String keyword, int i) {
		// TODO Auto-generated method stub
		return null;
	}
	
//	// 사원 검색
//	@Override
//	public ArrayList<Employee> selectList(String find, String keyword, int i) {
//		return (ArrayList)managerDao.selectList(sqlSession, find, keyword, i);
//	}
	
}
