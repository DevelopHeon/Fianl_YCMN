package com.uni.spring.reservation.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	public List<Reservation> findAll(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("reserveMapper.getReservList");
	}
	public int insertReserve(SqlSessionTemplate sqlSession, Reservation rez) {
		return sqlSession.insert("reserveMapper.insertReserve", rez);
	}
	


}
