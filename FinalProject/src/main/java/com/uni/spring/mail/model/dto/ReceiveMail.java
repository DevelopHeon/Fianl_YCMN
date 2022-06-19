package com.uni.spring.mail.model.dto;

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
public class ReceiveMail {
	
	private int empNo; //사원번호
	private int mailNo; //메일번호
	private String starMail; //중요메일
	private Date timestamp; //받은날짜
	private int confirmMail; //수신확인

}
