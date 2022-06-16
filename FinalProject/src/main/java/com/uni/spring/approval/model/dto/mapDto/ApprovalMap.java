package com.uni.spring.approval.model.dto.mapDto;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLeave;
import com.uni.spring.approval.model.dto.ApprovalReport;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ApprovalMap {

	private Approval approval; // dto 합쳐서 보내기위해 선언
	private ApprovalLeave approvalLeave; // dto 합쳐서 보내기위해 선언 (app_leave 테이블)
	private ApprovalReport approvalReport; // dto 합치기 위해
	private ApperAccount apperAccount; // dto 합치기 위해
	private Employee employee; // dto 합쳐서 보내기 위해 선언 (employee 테이블)
	private Attachment attachment; // dto 합쳐서 보내기 위해 선언
}
