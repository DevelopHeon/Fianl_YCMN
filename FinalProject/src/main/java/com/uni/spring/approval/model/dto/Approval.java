package com.uni.spring.approval.model.dto;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

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
public class Approval {
	
	private int rownum; // 정렬된 글 번호
	private int appNo; // 전자결재DB 고유번호
	private String appWriterNo; // 기안자 성명 (or 사번)
	
	@NotBlank(message = "제목은 필수 입력 값입니다.")
	private String appTitle; // 기안서 제목
	
	@NotNull(message = "기안일은 필수 입력 값입니다.")
	private Date appCreateDate; // 기안일
	
	private String rejecter; // 반려자
	private String rejectReason; // 반려사유
	
	@NotBlank(message = "최초 승인자는 필수 입력 값입니다.")
	private String firstApprover; // 최초승인자
	
	@NotBlank(message = "최종 승인자는 필수 입력 값입니다.")
	private String lastApprover; // 최종승인자
	
	private String firstApprovalDate; // 최초승인일
	private String lastApprovalDate; // 최종승인일
	private String appKinds; //결재양식 (2:지출결의서, 3:휴가신청서, 4:업무보고서)
	private String appStatus; //결재 현황 (W:결재대기, I:결재중, C:결재완료, R:반려)
	private String status; // 상태 (Y: 기본값, N: 삭제후 값)
	private ApperAccount apperAccount; // dto 합쳐서 보내기위해 선언 (apper_account 테이블)
	private ApprovalLeave approvalLeave; // dto 합쳐서 보내기위해 선언 (app_leave 테이블)
	private ApprovalReport approvalReport; // dto 합쳐서 보내기 위해 선언 (app_report 테이블)
}
