package com.uni.spring.approval.model.dto;

import java.sql.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

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
public class ApprovalLeave {
	
	private int appNo; // 전자결재번호
	
	@NotNull(message="휴가 시작일은 필수 입력 값입니다.")
	private Date leaveStart; // 휴가 시작일
	
	@NotNull(message="휴가 종료일은 필수 입력 값입니다.")
	private Date leaveFinish; // 휴가 종료일
	
	private String leaveReason; //휴가 사용 이유
	
	@NotBlank(message="휴가 일수는 필수 입력 값입니다.")
	private double leaveTotalDate; // 휴가 일수
	
	@NotBlank(message="휴가 종류 선택은 필수입니다.")
	private String leaveCategory; // 종류 L: 연차, AH:오전반차, PH:오후반차, FE: 경조사
	private int category; // 첨부파일 분류번호 3
}
