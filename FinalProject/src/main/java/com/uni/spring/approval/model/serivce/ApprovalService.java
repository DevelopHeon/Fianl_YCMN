package com.uni.spring.approval.model.serivce;

import java.util.ArrayList;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.common.dto.Attachment;

public interface ApprovalService {

	void insertErApproval(Approval approval, ApperAccount apperAccount, ArrayList<ApprovalErs> appers, Attachment attachment);

}
