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
public class ApperAccount {
	
	private int appNo; // 전자결재 번호
	private String erAccountHolder; // 예금주
	private String bankName; // 은행명
	private String accountNumber; // 계좌번호
	private String erAmount; // 총지출금액
}
