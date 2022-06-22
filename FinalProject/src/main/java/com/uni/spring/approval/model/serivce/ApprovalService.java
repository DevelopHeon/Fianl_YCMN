package com.uni.spring.approval.model.serivce;

import java.util.ArrayList;

import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.approval.model.dto.ApprovalLeave;
import com.uni.spring.approval.model.dto.ApprovalReport;
import com.uni.spring.approval.model.dto.mapDto.ApprovalMap;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;

public interface ApprovalService {

	void insertErApproval(Approval approval, ArrayList<ApprovalErs> appers, Attachment attachment);

	ArrayList<Employee> selectApproverList(Employee employee);

	void insertLeaveApproval(Approval approval, ApprovalLeave approvalLeave, Attachment attachment);

	void insertReportApproval(Approval approval, ApprovalReport approvalReport, Attachment attachment);

	int selectMyApprovalListCnt(int userNo);

	ArrayList<Approval> selectMyApprovalList(PageInfo pi, int userNo);

	int selectBoxListCnt(Approval approval);

	ArrayList<Approval> selectBoxList(Approval approval, PageInfo pi);

	ApprovalMap selectApproval(int appNo, String appKinds);

	Attachment selectAppAttachment(int appNo);

	ArrayList<ApprovalErs> selectAppErs(int appNo);

	int selectApprovalInboxListCnt(int userNo);

	ArrayList<Approval> selectApprovalInboxList(PageInfo pi, int userNo);

	void updateFirstApprove(int appNo);

	void updateLastApprove(int appNo);

	void insertRejecter(Approval approval);

	void updateApprovalRp(Approval approval, Attachment attachment);

	void updateApprovalLv(Approval approval, Attachment attachment);

	void updateApprovalEr(Approval approval, ArrayList<ApprovalErs> appers, Attachment attachment);

	int selectApprovalReturnListCnt(int userNo);

	ArrayList<Approval> selectApprovalReturnList(PageInfo pi, int userNo);

	ArrayList<Department> selectDeptList();

}
