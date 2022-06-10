package com.uni.spring.approval.model.dto;

import java.sql.Date;

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
	
	private int appNo; // 전자결재DB 고유번호
	private String appWriterNo; // 기안자 성명 (or 사번)
	private String appTitle; // 기안서 제목
	private Date appCreateDate; // 기안일
	private String rejecter; // 반려자
	private String rejectReason; // 반려사유
	private String firstApprover; // 최초승인자
	private String lastApprover; // 최종승인자
	private Date firstApprovalDate; // 최초승인일
	private Date lastApprovalDate; // 최종승인일
	private String appKinds; //결재양식 (2:지출결의서, 3:휴가신청서, 4:업무보고서)
	private String appStatus; //결재 현황 (W:결재대기, I:결재중, C:결재완료, R:반려)
	private String status; // 상태 (Y: 기본값, N: 삭제후 값)
	
}
