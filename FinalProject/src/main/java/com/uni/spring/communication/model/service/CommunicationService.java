package com.uni.spring.communication.model.service;

import java.util.ArrayList;

import com.uni.spring.communication.model.dto.Communication;

public interface CommunicationService {

	ArrayList<Communication> selectCommList(int depNo);

	int insertComm(Communication comm);

}
