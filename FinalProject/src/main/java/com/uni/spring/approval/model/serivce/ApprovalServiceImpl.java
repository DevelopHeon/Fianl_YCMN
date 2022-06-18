package com.uni.spring.approval.model.serivce;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.approval.model.dao.ApprovalDao;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.approval.model.dto.ApprovalLeave;
import com.uni.spring.approval.model.dto.ApprovalReport;
import com.uni.spring.approval.model.dto.mapDto.ApprovalMap;
import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ApprovalServiceImpl implements ApprovalService {

	private final ApprovalDao approvalDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public void insertErApproval(Approval approval, ArrayList<ApprovalErs> appers,  Attachment attachment) {
		
		int result1 = approvalDao.insertApproval(sqlSession, approval);
		int result2 = approvalDao.insertApperAccount(sqlSession, approval.getApperAccount());
		int result3 = approvalDao.insertApprovalErs(sqlSession, appers);
		int result4 = approvalDao.insertAttachment(sqlSession, attachment);
		
		//전자 결재테이블에 추가가 되지 않으면
		if(result1 * result2 * result3 * result4 < 0) {
			throw new CommException("지출결의서 등록 실패");
		}
		else {
			System.out.println("지출 결의서 추가 성공");
		}
	}

	@Override
	public ArrayList<Employee> selectApproverList(int empNo) {
		
		return approvalDao.selectApproverList(empNo, sqlSession);
	}

	@Override
	public void insertLeaveApproval(Approval approval, ApprovalLeave approvalLeave, Attachment attachment) {

		int result1 = 1;
		
		int result2 = approvalDao.insertApproval(sqlSession, approval);
		int result3 = approvalDao.insertLeaveApproval(sqlSession, approvalLeave);
		// 시퀀스의 currval을 사용하기 위해서는 첨부파일 마지막에 수행되도록 위치 설정
		if(attachment != null) {
			result1 = approvalDao.insertAttachment(sqlSession, attachment);
		}
		
		
		if(result1 * result2 * result3 < 0) {
			throw new CommException("휴가신청서 등록 실패");
		}
	}

	@Override
	public void insertReportApproval(Approval approval, ApprovalReport approvalReport, Attachment attachment) {
		
		int result1 = 1;
		
		int result2 = approvalDao.insertApproval(sqlSession, approval);
		int result3 = approvalDao.insertReportApproval(sqlSession, approvalReport);
		
		if(attachment != null) {
			result1 = approvalDao.insertAttachment(sqlSession, attachment);
		}
		
		if(result1 * result2 * result3 < 0) {
			throw new CommException("업무 보고서 등록 실패");
		}
	}

	// 내가 작성한 결재 문서 count 조회
	@Override
	public int selectMyApprovalListCnt(int userNo) {
		return approvalDao.selectMyApprovalListCnt(sqlSession, userNo);
	}

	// 내가 작성한 결재 문서 목록 조회
	@Override
	public ArrayList<Approval> selectMyApprovalList(PageInfo pi, int userNo) {
		return approvalDao.selectMyApprovalList(sqlSession, userNo, pi);
	}

	// select 값에 따른 결재 문서 count 조회
	@Override
	public int selectBoxListCnt(Approval approval) {
		return approvalDao.selectBoxListCnt(sqlSession, approval);
	}

	// select 값에 따른 결재 문서 목록 조회
	@Override
	public ArrayList<Approval> selectBoxList(Approval approval, PageInfo pi) {
		return approvalDao.selectBoxList(sqlSession, approval, pi);
	}

	@Override
	public Attachment selectAppAttachment(int appNo) {
		return approvalDao.selectAppAttachment(sqlSession, appNo);
	}

	@Override
	public ApprovalMap selectApproval(int appNo, String appKinds) {
		
		ApprovalMap appMap = new ApprovalMap();
		// appKinds에 따라 조회쿼리가 다르기때문에 if문으로 구분
		if(appKinds.equals("2")) {
			appMap = approvalDao.selectApprovalEr(sqlSession, appNo);
		}else if(appKinds.equals("3")) {
			appMap = approvalDao.selectApprovalLv(sqlSession, appNo);
		}else if(appKinds.equals("4")) {
			appMap = approvalDao.selectApprovalRp(sqlSession, appNo);
		}
		
		return appMap;
	}

	@Override
	public ArrayList<ApprovalErs> selectAppErs(int appNo) {
		return approvalDao.selectAppErs(sqlSession, appNo);
	}

	// 결재 수신 문서 개수 조회
	@Override
	public int selectApprovalInboxListCnt(int userNo) {
		return approvalDao.selectApprovalInboxListCnt(sqlSession, userNo);
	}

	@Override
	public ArrayList<Approval> selectApprovalInboxList(PageInfo pi, int userNo) {
		return approvalDao.selectApprovalInboxList(sqlSession, pi, userNo);
	}

	@Override
	public void updateFirstApprove(int appNo) {
		int result = approvalDao.updateFirstApprove(sqlSession, appNo);
		
		if(result < 0) {
			throw new CommException("결재 승인에 실패하였습니다.");
		}
		
	}

	@Override
	public void updateLastApprove(int appNo) {
		int result = approvalDao.updateLastApprove(sqlSession, appNo);
		
		if(result < 0) {
			throw new CommException("결재 승인에 실패하였습니다.");
		}
		
	}

	@Override
	public void insertRejecter(Approval approval) {
		
		int result = approvalDao.insertRejecter(sqlSession, approval);
		
		if(result < 0) {
			throw new CommException("반려 처리에 실패하였습니다.");
		}
	}

}
