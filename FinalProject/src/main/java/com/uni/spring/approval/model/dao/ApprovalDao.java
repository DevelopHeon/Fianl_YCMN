package com.uni.spring.approval.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.approval.model.dto.ApprovalLeave;
import com.uni.spring.approval.model.dto.ApprovalReport;
import com.uni.spring.approval.model.dto.Opinion;
import com.uni.spring.approval.model.dto.mapDto.ApprovalMap;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Department;
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

	public ArrayList<Employee> selectApproverList(Employee employee, SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApproverList", employee);
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

	public ApprovalMap selectApprovalLv(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.selectOne("approvalMapper.selectApprovalLv", appNo);
	}

	public Attachment selectAppAttachment(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.selectOne("approvalMapper.selectAppAttachment", appNo);
	}

	public ApprovalMap selectApprovalRp(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.selectOne("approvalMapper.selectApprovalRp", appNo);
	}

	public ApprovalMap selectApprovalEr(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.selectOne("approvalMapper.selectApprovalEr", appNo);
	}

	public ArrayList<ApprovalErs> selectAppErs(SqlSessionTemplate sqlSession, int appNo) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectAppErs", appNo);
	}

	public int selectApprovalInboxListCnt(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("approvalMapper.selectApprovalInboxListCnt", userNo);
	}

	public ArrayList<Approval> selectApprovalInboxList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApprovalInboxList", userNo, rowBounds);
	}

	public int updateFirstApprove(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.update("approvalMapper.updateFirstApprove", appNo);
		
	}

	public int updateLastApprove(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.update("approvalMapper.updateLastApprove", appNo);
		
	}

	public int insertRejecter(SqlSessionTemplate sqlSession, Approval approval) {
		return sqlSession.update("approvalMapper.insertRejecter", approval);
	}

	public int updateApproval(SqlSessionTemplate sqlSession, Approval approval) {
		return sqlSession.update("approvalMapper.updateApproval", approval);
	}

	public int updateAttachment(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.update("approvalMapper.updateAttachment", attachment);
	}

	public int updateApprovalRp(SqlSessionTemplate sqlSession, ApprovalReport approvalReport) {
		return sqlSession.update("approvalMapper.updateApprovalRp", approvalReport);
	}

	public int updateApprovalLv(SqlSessionTemplate sqlSession, ApprovalLeave approvalLeave) {
		return sqlSession.update("approvalMapper.updateApprovalLv", approvalLeave);
	}

	public int updateApperAcc(SqlSessionTemplate sqlSession, ApperAccount apperAccount) {
		return sqlSession.update("approvalMapper.updateApperAcc", apperAccount);
	}

	public int deleteApprovalErs(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.delete("approvalMapper.deleteApprovalErs", appNo);
	}

	public int selectApprovalReturnListCnt(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("approvalMapper.selectApprovalReturnListCnt", userNo);
	}

	public ArrayList<Approval> selectApprovalReturnList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApprovalReturnList", userNo, rowBounds);
	}

	public ArrayList<Department> selectDeptList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectDeptList");
	}

	public Map<String, Object> appStatusCnt(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("approvalMapper.appStatusCnt", userNo);
	}

	public ArrayList<Opinion> selectOpinionList(SqlSessionTemplate sqlSession, int refNo) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectOpinionList", refNo);
	}

	public int insertOpinion(SqlSessionTemplate sqlSession, Opinion o) {
		return sqlSession.insert("approvalMapper.insertOpinion", o);
	}

	public int deleteOpinion(SqlSessionTemplate sqlSession, int opinionNo) {
		return sqlSession.update("approvalMapper.deleteOpinion", opinionNo);
	}

	public int deleteAttachment(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.delete("approvalMapper.deleteAttachment", appNo);
	}

	public int deleteApproval(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.update("approvalMapper.deleteApproval", appNo);
	}

	public int selectInBoxListCnt(SqlSessionTemplate sqlSession, Approval approval) {
		return sqlSession.selectOne("approvalMapper.selectInBoxListCnt", approval);
	}

	public ArrayList<Approval> selectInBoxList(SqlSessionTemplate sqlSession, Approval approval, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectInBoxList", approval, rowBounds);
	}

}
