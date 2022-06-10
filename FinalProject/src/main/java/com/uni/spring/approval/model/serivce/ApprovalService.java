package com.uni.spring.approval.model.serivce;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalEr;

public interface ApprovalService {

	void insertErApproval(Approval approval, ApprovalEr approvalErs, ApperAccount apperAccount);

}
