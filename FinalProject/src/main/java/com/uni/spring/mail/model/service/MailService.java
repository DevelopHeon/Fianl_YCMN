package com.uni.spring.mail.model.service;

import java.util.ArrayList;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.mail.model.dto.Mail;
import com.uni.spring.mail.model.dto.ReceiveMail;

public interface MailService {

	void insertMail(Mail mail, Attachment attachment);

	int selectSendListCount();

	ArrayList<ReceiveMail> selectSendList(int empNo, PageInfo pi);

}
