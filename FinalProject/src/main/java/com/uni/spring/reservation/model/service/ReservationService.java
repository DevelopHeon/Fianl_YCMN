package com.uni.spring.reservation.model.service;

import java.util.ArrayList;
import java.util.List;

import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.reservation.model.dto.Reservation;
import com.uni.spring.reservation.model.dto.Resources;

public interface ReservationService {

	ArrayList<Resources> getRoomList(); // 회의실 조회

	ArrayList<Resources> getSupplyList(); // 비품 조회

	ArrayList<Resources> getRscList(); // 자원 조회
	
	void insertRsc(Resources rsc); // 자원 추가

	void updateRsc(Resources rsc); // 자원 수정

	void deleteRsc(Resources rsc); // 자원 삭제

	List<Reservation> getRezList(); // 예약 목록 조회

	void insertReserve(Reservation rez); // 예약 추가

	List<Reservation> myRezList(int empNo, PageInfo pi); // 내 예약 조회

	void returnReserve(int rezNo); // 예약 반납

	void cancleReserve(int rezNo); // 예약 취소

	int selectListCount(int empNo); // 페이징 용

	int rscListCount(); // 자원 수
}
