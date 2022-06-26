package com.uni.spring.reservation.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.common.CommException;
import com.uni.spring.reservation.model.dao.ReservationDao;
import com.uni.spring.reservation.model.dto.Resources;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {
	
	private final ReservationDao reservationDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Resources> getRoomList() {
		return (ArrayList)reservationDao.getRoomList(sqlSession);
	}

	@Override
	public ArrayList<Resources> getSupplyList() {
		return (ArrayList)reservationDao.getSupplyList(sqlSession);
	}

	@Override
	public ArrayList<Resources> getRscList() {
		return (ArrayList)reservationDao.getRscList(sqlSession);
	}
	
	@Override
	public void insertRsc(Resources rsc) {
		int result = reservationDao.insertRsc(sqlSession, rsc);
		
		if(result < 0) {
			throw new CommException();
		}
	}

	@Override
	public void updateRsc(Resources rsc) {
		int result = reservationDao.updateRsc(sqlSession, rsc);
		
		if(result < 0) {
			throw new CommException();
		}
	}

	@Override
	public void deleteRsc(Resources rsc) {
		int result = reservationDao.deleteRsc(sqlSession, rsc);
		
		if(result < 0) {
			throw new CommException();
		}
	}
}
