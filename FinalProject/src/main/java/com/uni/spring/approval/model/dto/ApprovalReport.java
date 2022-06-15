package com.uni.spring.approval.model.dto;

import javax.validation.constraints.NotBlank;

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
public class ApprovalReport {
	
	private int appNo; // 전자 결재 번호
	@NotBlank(message = "업무 내용은 필수 입력 값입니다.")
	private String reportContent; // 업무 내용
	private String reportIssue; // 특이사항
	private int category; // 첨부파일 분류번호 4
}
