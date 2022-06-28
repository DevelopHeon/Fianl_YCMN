package com.uni.spring.employee.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.TimeOff;
import com.uni.spring.employee.model.dto.TimeOffContent;
import com.uni.spring.employee.model.dto.WorkingDay;
import com.uni.spring.hr.model.dto.Hr;

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
	//몇주차?
	public int updateThisWeek(SqlSessionTemplate sqlSession, WorkingDay w) {
		return sqlSession.update("employeeMapper.updateThisWeek");	
	}
	//근무상태(정상,지각)
	public int updateWorkStatusL(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.update("employeeMapper.updateWorkStatusL", empNo);	
	}

	//퇴근체크
	public int updateFinish(SqlSessionTemplate sqlSession, WorkingDay w) {	
		return sqlSession.update("employeeMapper.updateFinish", w);
	}
	//출근 여부
	public int selectStartCheck(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("employeeMapper.selectStartCheck", empNo);
	}
	
	//퇴근 여부
	public int selectFinishCheck(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("employeeMapper.selectFinishCheck", empNo);
	}
	//근무상태(조퇴)
	public int updateWorkStatusE(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.update("employeeMapper.updateWorkStatusE", empNo);
		
	}
	//주소록
	public ArrayList<Employee> selectEmpAddress(SqlSessionTemplate sqlSession) {	
		return (ArrayList)sqlSession.selectList("employeeMapper.selectEmpAddress");
	}
	
	//프로필 변경
	public int updateImg(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.insert("employeeMapper.updateImg", attachment);
	}
	//오늘 근무시간
	public int updateWorkHour(SqlSessionTemplate sqlSession, WorkingDay w) {
		return sqlSession.update("employeeMapper.updateWorkHour", w);
	}
	//프로필 삭제
	public int deleteImg(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.delete("employeeMapper.deleteImg", empNo);
	}
	//주소록_사원정보
	public Employee selectDetailEmp(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("employeeMapper.selectDetailEmp", empNo);
	}
	//주소록_사원검색
	public ArrayList<Employee> selectSearchEmp(SqlSessionTemplate sqlSession, String empName) {
		return (ArrayList)sqlSession.selectList("employeeMapper.selectSearchEmp", empName);
	}
	//연차개수조회
	public TimeOff selectTimeOff(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("employeeMapper.selectTimeOff", empNo);
	}
	//연차내역 업데이트
	public int updateTimeOffContent(SqlSessionTemplate sqlSession) {
		return sqlSession.update("employeeMapper.updateTimeOffContent");
	}
	//잔여연차 업데이트
	public int updateRemainNum(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.update("employeeMapper.updateRemainNum", empNo);
	}
	//잔여연차 업데이트 후 연차개수 차감
	public int updateTimeOffNum(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.update("employeeMapper.updateTimeOffNum", empNo);
	}
	//연차내역조회
	public ArrayList<TimeOffContent> selectTimeOffContent(SqlSessionTemplate sqlSession, int empNo, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		// * offset : 몇 개의 게시글을 건너 뛰고 조회할 지에 대해 계산
		// ex) boardLimit : 5
		// currentPage = 1		1~5		0개의 게시글 건너 뛰고 1부터 5개 조회
		// currentPage = 2		6~10	5개의 게시글 건너 뛰고 6부터 5개 조회
		// currentPage = 3		11~15	10개의 게시글 건너 뛰고 11부터 5개 조회
		// currentPage = 4		16~20	15개의 게시글 건너 뛰고 16부터 5개 조회
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("employeeMapper.selectTimeOffContent", empNo, rowBounds);
	}
	//현재 연차 페이지 수?
	public int selectListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("employeeMapper.selectListCount", empNo);
	}
	
	//사원 상태(온라인, 오프라인, 자리비움)
	public int updateEmpOnOff(SqlSessionTemplate sqlSession, Employee loginUser) {
		return sqlSession.update("employeeMapper.updateEmpOnOff", loginUser);
	}
	//사원 마이페이지
	public Employee selectEmpMypage(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("employeeMapper.selectEmpMypage", empNo);
	}
	//사원 인사정보
	public Hr selectEmpPersonnel(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("employeeMapper.selectEmpPersonnel", empNo);

	}



}
