package com.uni.spring.mail.model.service;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.mail.model.dto.Mail;

public interface MailService {

	void insertMail(Mail mail, Attachment attachment);

}
