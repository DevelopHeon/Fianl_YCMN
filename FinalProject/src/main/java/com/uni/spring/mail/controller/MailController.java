package com.uni.spring.mail.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MailController {
	
	@RequestMapping("writeMail.do")
	public String writeMail() {
		return "mail/writeMail";
	}

}
