package com.uni.spring.communication.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.communication.model.dto.Communication;

@Repository
public class CommunicationDao {

	public ArrayList<Communication> selectCommList(SqlSessionTemplate sqlSession, int depNo) {
		return (ArrayList)sqlSession.selectList("communicationMapper.selectCommList", depNo);
	}

	public int insertComm(SqlSessionTemplate sqlSession, Communication comm) {
		return sqlSession.insert("communicationMapper.insertComm", comm);
	}

}
