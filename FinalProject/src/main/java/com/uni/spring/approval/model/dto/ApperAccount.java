package com.uni.spring.approval.model.dto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

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
	@Size(max=30, message="예금주명은 10자 이내만 입력 가능합니다.")
	private String erAccountHolder; // 예금주
	
	@NotBlank(message="은행명은 필수 입력값입니다.")
	@Size(max=30, message="은행명은 10자 이내만 입력 가능합니다.")
	private String bankName; // 은행명
	
	@NotBlank(message="계좌번호는 필수 입력값입니다.")
	@Size(max=30, message="계좌번호는 30자 이내만 가능")
	private String accountNumber; // 계좌번호
	
	@NotBlank(message="총지출금액은 필수 입력값입니다.")
	private String erAmount; // 총지출금액
}
