package com.uni.spring.approval.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;

@Repository
public class ApprovalDao {

	public int insertApproval(SqlSessionTemplate sqlSession, Approval approval) {
		return sqlSession.insert("approvalMapper.insertApproval", approval);
	}

	public int insertapperAccount(SqlSessionTemplate sqlSession, ApperAccount apperAccount) {
		return sqlSession.insert("approvalMapper.insertapperAccount", apperAccount);
	}

}
