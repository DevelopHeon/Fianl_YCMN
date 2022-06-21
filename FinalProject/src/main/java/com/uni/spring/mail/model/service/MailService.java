package com.uni.spring.mail.model.service;

import java.util.ArrayList;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.mail.model.dto.Mail;
import com.uni.spring.mail.model.dto.ReceiveMail;

public interface MailService {

	void insertMail(Mail mail, Attachment attachment);

	int selectSendListCount(int empNo);

	ArrayList<ReceiveMail> selectSendList(int empNo, PageInfo pi);

	void updateTrashMail(int receiveNo);

	ArrayList<ReceiveMail> selectDeleteList(int empNo);

	int selectReceiveListCount(int empNo);

	ArrayList<ReceiveMail> selectReceiveList(int empNo, PageInfo pi);

	ReceiveMail selectReceiveMail(int receiveNo);

	void updateTrashRMail(int receiveNo);

	ReceiveMail selectSendMail(int mailNo);

	void updateTrashSMail(int mailNo);

}
