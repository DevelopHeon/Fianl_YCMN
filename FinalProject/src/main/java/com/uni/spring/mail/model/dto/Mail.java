package com.uni.spring.mail.model.dto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

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
public class Mail {
	
	private int mailNo; //메일번호
	private int empNo; //사원번호
	
	@Size(max=100, message="*제목은 최대 100이내로 작성 가능*")
	private String mailTitle; //메일제목
	
	private String mailTo; //수신인
	private String mailRef; //참조인
	private String mailSec; //비밀참조인
	private String fileName; //파일명
	private String timestamp; //작성날짜
	
	@Size(max=1000, message="*내용은 최대 1000자 이내로 작성 가능*")
	private String mailContent; //메일내용
	
	private String status; //메일상태(Y,N:삭제)
	private String category; //분류번호
	private Employee Employee;
}
