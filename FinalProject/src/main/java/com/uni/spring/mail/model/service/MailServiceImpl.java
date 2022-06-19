package com.uni.spring.mail.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.mail.model.dao.MailDao;
import com.uni.spring.mail.model.dto.Mail;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailServiceImpl implements MailService {
	
	private final MailDao mailDao;
	private final SqlSessionTemplate sqlSession;
	//메일작성
	@Override
	public void insertMail(Mail mail, Attachment attachment) {
		
		int result = mailDao.insertMail(sqlSession, attachment);
		
		
	}

}
