package com.uni.spring.approval.model.dto;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

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
	
	@NotBlank(message="예금주는 필수 입력값입니다.")
	@Pattern(regexp="^[a-zA-Zㄱ-ㅎ가-힣]*$", message="예금주 양식이 일치하지 않습니다.")
	private String erAccountHolder; // 예금주
	
	@NotBlank(message="은행명은 필수 입력값입니다.")
	@Pattern(regexp="^[0-9a-zA-Zㄱ-ㅎ가-힣 ]*$", message="은행명 양식이 일치하지 않습니다.")
	private String bankName; // 은행명
	
	@NotBlank(message="계좌번호는 필수 입력값입니다.")
	@Pattern(regexp="^[0-9]*$", message="계좌번호는 숫자만 입력이 가능합니다.")
	private String accountNumber; // 계좌번호
	
	@NotBlank(message="총지출금액은 필수 입력값입니다.")
	@Pattern(regexp="^[0-9]*$", message="지출금액은 숫자만 입력이 가능합니다.")
	private String erAmount; // 총지출금액
}
