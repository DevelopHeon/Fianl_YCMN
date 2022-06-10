package com.uni.spring.approval.model.dto;

import java.sql.Date;
import java.util.List;

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
public class ApprovalErs {
	
	private int apperNo; // 지출결의서 고유번호 (PK)
	private int erAppNo; // 전자결재번호(FK)
	private String erClass; // 계정과목
	private Date erDate; //지출일자
	private String erDetail; // 지출세부내용
	private String erUse; // 사용처
	private String erPayment; // 결재수단 (M:현금, PC:개인카드, BC:법인카드)
	private int category; // 분류번호
	private List<ApprovalErs> approvalErs;
}
