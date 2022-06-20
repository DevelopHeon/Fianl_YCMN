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
public class Mail {
	
	private int mailNo; //메일번호
	private int empNo; //사원번호
	private String mailTitle; //메일제목
	private int mailTo; //수신인
	private int mailRef; //참조인
	private int mailSec; //비밀참조인
	private String fileName; //파일명
	private Date timestamp; //작성날짜
	private String mailContent; //메일내용
	private String status; //메일상태(Y,N:삭제)
	private String category; //분류번호

}
