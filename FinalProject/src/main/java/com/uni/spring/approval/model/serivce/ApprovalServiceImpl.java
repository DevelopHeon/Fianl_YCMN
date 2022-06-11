package com.uni.spring.approval.model.serivce;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.approval.model.dao.ApprovalDao;
import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ApprovalServiceImpl implements ApprovalService {

	private final ApprovalDao approvalDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public void insertErApproval(Approval approval, ApperAccount apperAccount, ArrayList<ApprovalErs> appers,  Attachment attachment) {
		
		int result1 = approvalDao.insertApproval(sqlSession, approval);
		int result2 = approvalDao.insertApperAccount(sqlSession, apperAccount);
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
	public ArrayList<Employee> selectApproverList() {
		
		return approvalDao.selectApproverList(sqlSession);
	}
}
