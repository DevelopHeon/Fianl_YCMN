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
	
	@Override
	public ArrayList<Employee> selectList() {
		return (ArrayList)managerDao.selectList(sqlSession);
	}

	@Override
	public Object selectEmp(int eno) {
		Employee e = ManagerDao.selectEmp(sqlSession, eno);
		return e;
	}

	@Override
	public ArrayList<JobPosition> getPosList() {
		return (ArrayList)managerDao.getPosList(sqlSession);
	}

	@Override
	public void updateEmpDetail(Employee e, Hr hr) {
		int result1 = managerDao.updateEmpDetail(sqlSession, e);
		int result2 = managerDao.updateEmpHr(sqlSession, hr);
		
		if(result1 < 0 || result2 < 0) {
			throw new CommException();
		}
	}

	@Override
	public Object selectHr(int eno) {
		Employee e = ManagerDao.selectHr(sqlSession, eno);
		return e;
	}

	@Override
	public ArrayList<Department> getDepList() {
		return (ArrayList)managerDao.getDepList(sqlSession);
	}

	@Override
	public ArrayList<Employee> selectExcelList() {
		return (ArrayList)managerDao.selectExcelList(sqlSession);
	}
	
	
}
