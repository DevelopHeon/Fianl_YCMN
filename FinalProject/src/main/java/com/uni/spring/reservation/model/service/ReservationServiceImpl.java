package com.uni.spring.reservation.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.reservation.model.dao.ReservationDao;
import com.uni.spring.reservation.model.dto.Reservation;
import com.uni.spring.reservation.model.dto.Resources;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {
	
	private final ReservationDao reservationDao;
	private final SqlSessionTemplate sqlSession;
	// 회의실 목록
	@Override
	public ArrayList<Resources> getRoomList() {
		return (ArrayList)reservationDao.getRoomList(sqlSession);
	}
	// 비품 목록
	@Override
	public ArrayList<Resources> getSupplyList() {
		return (ArrayList)reservationDao.getSupplyList(sqlSession);
	}
	// 자원 목록
	@Override
	public ArrayList<Resources> getRscList() {
		return (ArrayList)reservationDao.getRscList(sqlSession);
	}
	// 자원 추가
	@Override
	public void insertRsc(Resources rsc) {
		int result = reservationDao.insertRsc(sqlSession, rsc);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	// 자원 수정
	@Override
	public void updateRsc(Resources rsc) {
		int result = reservationDao.updateRsc(sqlSession, rsc);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	// 자원 삭제
	@Override
	public void deleteRsc(Resources rsc) {
		int result = reservationDao.deleteRsc(sqlSession, rsc);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	
	// 예약 전체 목록
	@Override
	public List<Reservation> getRezList() {
		return reservationDao.getRezList(sqlSession);
	}
	// 예약 추가
	@Override
	public void insertReserve(Reservation rez) {
		int result = reservationDao.insertReserve(sqlSession, rez);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	
	// 나의 예약 목록 조회
	@Override
	public List<Reservation> myRezList(int empNo, PageInfo pi) {
		return reservationDao.myRezList(sqlSession, empNo, pi);
	}
	// 페이징 용
	@Override
	public int selectListCount(int empNo) {
		return reservationDao.selectListCount(sqlSession, empNo);
	}
	// 예약 반납
	@Override
	public void returnReserve(int rezNo) {
		int result = reservationDao.returnReserve(sqlSession, rezNo);
		
		if(result < 0) {
			throw new CommException();
		}
	}
	// 예약 취소
	@Override
	public void cancleReserve(int rezNo) {
		int result = reservationDao.cancleReserve(sqlSession, rezNo);
		
		if(result < 0) {
			throw new CommException();
		}
	}
}
