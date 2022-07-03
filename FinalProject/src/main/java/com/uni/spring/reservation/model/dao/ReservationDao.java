package com.uni.spring.reservation.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.JobPosition;
import com.uni.spring.reservation.model.dto.Reservation;
import com.uni.spring.reservation.model.dto.Resources;

@Repository
public class ReservationDao {
	
	// 회의실 조회
	public ArrayList getRoomList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reserveMapper.getRoomList");
	}
	// 비품 조회
	public ArrayList getSupplyList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reserveMapper.getSupplyList");
	}
	// 선택한 자원 가져오기
	public ArrayList getRscList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reserveMapper.getRscList");
	}
	// 자원 추가
	public int insertRsc(SqlSessionTemplate sqlSession, Resources rsc) {
		return sqlSession.insert("reserveMapper.insertRsc", rsc);
	}
	// 자원 수정
	public int updateRsc(SqlSessionTemplate sqlSession, Resources rsc) {
		return sqlSession.update("reserveMapper.updateRsc", rsc);
	}
	// 자원 삭제
	public int deleteRsc(SqlSessionTemplate sqlSession, Resources rsc) {
		return sqlSession.update("reserveMapper.deleteRsc", rsc);
	}
	
	// 예약 목록
	public List<Reservation> getRezList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("reserveMapper.getRezList");
	}
	// 예약 추가
	public int insertReserve(SqlSessionTemplate sqlSession, Reservation rez) {
		return sqlSession.insert("reserveMapper.insertReserve", rez);
	}
	// 내 예약 조회
	public List<Reservation> myRezList(SqlSessionTemplate sqlSession, int empNo, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return sqlSession.selectList("reserveMapper.myRezList", empNo, rowBounds);
	}
	// 페이징 용
	public int selectListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("reserveMapper.selectListCount", empNo);
	}
	// 예약 반납
	public int returnReserve(SqlSessionTemplate sqlSession, int rezNo) {
		return sqlSession.update("reserveMapper.returnReserve", rezNo);
	}
	// 예약 취소
	public int cancleReserve(SqlSessionTemplate sqlSession, int rezNo) {
		return sqlSession.update("reserveMapper.cancleReserve", rezNo);
	}
}
