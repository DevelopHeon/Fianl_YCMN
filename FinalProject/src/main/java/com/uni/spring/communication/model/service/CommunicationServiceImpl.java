package com.uni.spring.communication.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.common.CommException;
import com.uni.spring.communication.model.dao.CommunicationDao;
import com.uni.spring.communication.model.dto.Communication;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CommunicationServiceImpl implements CommunicationService {
	
	private final CommunicationDao communicationDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Communication> selectCommList(int depNo) {
		return communicationDao.selectCommList(sqlSession, depNo);
	}

	@Override
	public int insertComm(Communication comm) {
		
		int result = communicationDao.insertComm(sqlSession, comm);
		
		if(result < 0) {
			throw new CommException("소통 게시글 등록 실패");
		}
		
		return result;
	}

}
