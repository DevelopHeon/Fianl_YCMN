package com.uni.spring.approval.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.approval.model.dto.ApprovalLeave;
import com.uni.spring.approval.model.dto.ApprovalReport;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
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

	public ArrayList<Employee> selectApproverList(int empNo, SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApproverList", empNo);
	}

	public int insertLeaveApproval(SqlSessionTemplate sqlSession, ApprovalLeave approvalLeave) {
		return sqlSession.insert("approvalMapper.insertLeaveApproval", approvalLeave);
	}

	public int insertReportApproval(SqlSessionTemplate sqlSession, ApprovalReport approvalReport) {
		return sqlSession.insert("approvalMapper.insertReportApproval", approvalReport);
	}

	public int selectMyApprovalListCnt(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("approvalMapper.selectMyApprovalListCnt", userNo);
	}

	public ArrayList<Approval> selectMyApprovalList(SqlSessionTemplate sqlSession, int userNo, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectMyApprovalList", userNo, rowBounds);
	}

	public ArrayList<Approval> selectBoxList(SqlSessionTemplate sqlSession, Approval approval, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectBoxList", approval, rowBounds);
	}

	public int selectBoxListCnt(SqlSessionTemplate sqlSession, Approval approval) {
		return sqlSession.selectOne("approvalMapper.selectBoxListCnt", approval);
	}

}
