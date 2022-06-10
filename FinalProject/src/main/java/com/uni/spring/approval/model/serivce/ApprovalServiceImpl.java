package com.uni.spring.approval.model.serivce;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.approval.model.dao.ApprovalDao;
import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalEr;
import com.uni.spring.common.CommException;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ApprovalServiceImpl implements ApprovalService {

	private final ApprovalDao approvalDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public void insertErApproval(Approval approval, ApprovalEr approvalErs, ApperAccount apperAccount) {
		
		int result1 = approvalDao.insertApproval(sqlSession, approval);
		int result2 = 0;
		int result3 = 0;
		
		//전자 결재테이블에 추가가 되지 않으면
		if(result1 < 0) {
			throw new CommException("insertApproval 실패");
		}
		else {
			result2 = approvalDao.insertapperAccount(sqlSession, apperAccount);
		}
		if(result1 * result2 > 0) {
			
			
		}
		System.out.println("전자결재 추가 성공");
		System.out.println("계좌정보 추가 성공");
	}

}
