package com.uni.spring.reservation.model.service;

import java.util.ArrayList;
import java.util.List;

import com.uni.spring.reservation.model.dto.Reservation;
import com.uni.spring.reservation.model.dto.Resources;

public interface ReservationService {

	ArrayList<Resources> getRoomList();

	ArrayList<Resources> getSupplyList();

	ArrayList<Resources> getRscList();
	
	void insertRsc(Resources rsc);

	void updateRsc(Resources rsc);

	void deleteRsc(Resources rsc);

	List<Reservation> findAll();

	void insertReserve(Reservation rez);
}
