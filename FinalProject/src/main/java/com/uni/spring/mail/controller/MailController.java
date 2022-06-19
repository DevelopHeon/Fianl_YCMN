package com.uni.spring.mail.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.mail.model.service.MailService;

import lombok.RequiredArgsConstructor;

@SessionAttributes("loginUser")
@RequiredArgsConstructor
@Controller
public class MailController {
	
	private final MailService mailService;
	
	@RequestMapping("writeMail.do")
	public String writeMail(HttpSession session) {
		Employee emp = (Employee)session.getAttribute("loginUser");
		int empNo = emp.getEmpNo();
		
		
		return "mail/writeMail";
	}
	//받은메일함
	@RequestMapping("receiveMail.do")
	public String receiveMail() {
		return "mail/receiveMail";
	}
	//보낸메일함
	@RequestMapping("sendMail.do")
	public String sendMail() {
		return "mail/sendMail";
	}
	//휴지통
	@RequestMapping("deleteMail.do")
	public String deleteMail() {
		return "mail/deleteMail";
	}

}
