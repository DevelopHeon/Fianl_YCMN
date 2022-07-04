package com.uni.spring.mail.model.dto;

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
public class ReceiveMail {

	private int receiveNo; //받은메일번호
	private int mailNo; //메일번호
	private int empNo; //사원번호
	private int receiver; //수신자	
	private String status; //수신상태(T:수신, R:참조, S:비밀참조)
	private String starMail; //중요메일
	private String timestamp; //받은날짜
	private int confirmMail; //수신확인
	private String receiveStatus; //받은메일상태(Y:정상 N:삭제)
	private Mail Mail;
	private Employee Employee;

}
