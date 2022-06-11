package com.uni.spring.approval.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.employee.model.dto.Employee;

@Repository
public class ApprovalDao {

	public int insertApproval(SqlSessionTemplate sqlSession, Approval approval) {
		return sqlSession.insert("approvalMapper.insertApproval", approval);
	}

	public int insertApperAccount(SqlSessionTemplate sqlSession, ApperAccount apperAccount) {
		return sqlSession.insert("approvalMapper.insertApperAccount", apperAccount);
	}

	public int insertApprovalErs(SqlSessionTemplate sqlSession, ArrayList<ApprovalErs> appers) {
		return sqlSession.insert("approvalMapper.insertApprovalErs", appers);
	}

	public int insertAttachment(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.insert("approvalMapper.insertAttachment", attachment);
	}

	public ArrayList<Employee> selectApproverList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApproverList");
	}

}
