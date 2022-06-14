package com.uni.spring.approval.model.serivce;

import java.util.ArrayList;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.approval.model.dto.ApprovalLeave;
import com.uni.spring.approval.model.dto.ApprovalReport;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Employee;

public interface ApprovalService {

	void insertErApproval(Approval approval, ArrayList<ApprovalErs> appers, Attachment attachment);

	ArrayList<Employee> selectApproverList(int empNo);

	void insertLeaveApproval(Approval approval, ApprovalLeave approvalLeave, Attachment attachment);

	void insertReportApproval(Approval approval, ApprovalReport approvalReport, Attachment attachment);

	int selectMyApprovalListCnt(int userNo);

	ArrayList<Approval> selectMyApprovalList(PageInfo pi, int userNo);

	int selectBoxListCnt(Approval approval);

	ArrayList<Approval> selectBoxList(Approval approval, PageInfo pi);

}
