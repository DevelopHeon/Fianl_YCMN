package com.uni.spring.employee.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dao.EmployeeDao;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.TimeOff;
import com.uni.spring.employee.model.dto.TimeOffContent;
import com.uni.spring.employee.model.dto.WorkingDay;
import com.uni.spring.hr.model.dto.Hr;

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
	//사원정보 수정
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
	public WorkingDay insertStart(WorkingDay w, int empNo) {
		
		int result = employeeDao.insertStart(sqlSession, w);
		
		//출근 체킹 완
		if(result > 0) {
			//오늘은 이달의 몇주차?
			employeeDao.updateThisWeek(sqlSession, w);

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
	//오늘 근태시간
	@Override
	public int updateWorkHour(WorkingDay w) {
		int result = employeeDao.updateWorkHour(sqlSession, w);
		if(result > 0) {
			return result;

		}else {
			throw new CommException("근태 기록 실패");
		}
	}
	//출근 여부
	@Override
	public int selectStartCheck(int empNo) {
		int result = employeeDao.selectStartCheck(sqlSession, empNo);
		
		if(result < 0) {
			throw new CommException("출근확인 여부 실패");
		}
		
		return result;
	}
	
	//퇴근 여부
	@Override
	public int selectFinishCheck(int empNo) {
		int result = employeeDao.selectFinishCheck(sqlSession, empNo);
		
		if(result < 0) {
			throw new CommException("퇴근확인 여부 실패");
		}
		
		return result;
	}
	//근무상태(지각)
	@Override
	public void updateWorkStatusL(int empNo) {
		
		employeeDao.updateWorkStatusL(sqlSession, empNo);
		
	}
	//퇴근 미체크(조퇴)
	@Override
	public void updateWorkStatusE(int empNo) {

		employeeDao.updateWorkStatusE(sqlSession, empNo);
		
	}
	
	//주소록
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
	
	//프로필 삭제
	@Override
	public void deleteImg(String empNo) {
		int result = employeeDao.deleteImg(sqlSession, empNo);
		
		if(result < 0) {
			throw new CommException("프로필 변경 실패");		
		}
		
	}
	//주소록_사원정보
	@Override
	public Employee detailEmp(int empNo) {

		return employeeDao.selectDetailEmp(sqlSession, empNo);
	}

	//주소록_사원검색
	@Override
	public ArrayList<Employee> selectSearchEmp(String empName) {
		
		return employeeDao.selectSearchEmp(sqlSession, empName);
	}
	
	//내 연차 조회
	@Override
	public TimeOff selectTimeOff(int empNo) {
		
		return employeeDao.selectTimeOff(sqlSession, empNo);
	}

	@Override
	public  ArrayList<TimeOffContent> selectTimeOffContent(int empNo, PageInfo pi) {
		
		//update해줌 -> 승인되었을때 (결재완료:C) 연차내역테이블 업데이트
		int result = employeeDao.updateTimeOffContent(sqlSession);
		if(result > 0) {
			//잔여연차 계산
			employeeDao.updateRemainNum(sqlSession, empNo);
			//연차 개수 업데이트
			employeeDao.updateTimeOffNum(sqlSession, empNo);
			
		}

		return employeeDao.selectTimeOffContent(sqlSession, empNo, pi);
	}

	//현재 연차 페이지 수?
	@Override
	public int selectListCount(int empNo) {
		return employeeDao.selectListCount(sqlSession, empNo);
	}
	
	//사원 상태(온라인,오프라인,자리비움)
	@Override
	public void updateEmpOnOff(Employee loginUser) {
		int result = employeeDao.updateEmpOnOff(sqlSession, loginUser);
		
		if(result < 0) {
			throw new CommException("사원 상태 변경 실패");		
		}
	}
	//사원 마이페이지
	@Override
	public Employee selectEmpMypage(int empNo) {
		return employeeDao.selectEmpMypage(sqlSession, empNo);
	}
	//사원 인사정보
	@Override
	public Hr selectEmpPersonnel(int empNo) {
		return employeeDao.selectEmpPersonnel(sqlSession, empNo);
	}
	//근무시간 합계
	@Override
	public String selectWorkingWeekTotal(int empNo) {
		return employeeDao.selectWorkingWeekTotal(sqlSession, empNo);

	}

}

