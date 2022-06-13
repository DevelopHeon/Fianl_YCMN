package com.uni.spring.mail.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MailController {
	
	@RequestMapping("writeMail.do")
	public String writeMail() {
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
