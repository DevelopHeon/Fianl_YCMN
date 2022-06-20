package com.uni.spring.mail.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.mail.model.dao.MailDao;
import com.uni.spring.mail.model.dto.Mail;
import com.uni.spring.mail.model.dto.ReceiveMail;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailServiceImpl implements MailService {
	
	private final MailDao mailDao;
	private final SqlSessionTemplate sqlSession;
	//메일작성
	@Override
	public void insertMail(Mail mail, Attachment attachment) {
		
		int resultA = 1; //일단 1 첨부파일이 있다면 25행 로직 탐
		int resultM = mailDao.insertMail(sqlSession, mail);
		if(attachment != null) {
			resultA = mailDao.insertAttachment(sqlSession, attachment);
		}
		if(resultM * resultA < 0) {
			throw new CommException("메일 작성 실패");
		}else {
			System.out.println("메일 작성 성공");
		}
		
	}
	//보낸메일함List 페이지 수
	@Override
	public int selectSendListCount() {
		return mailDao.selectSendListCount(sqlSession);
	}
	//보낸메일함List
	@Override
	public ArrayList<ReceiveMail> selectSendList(int empNo, PageInfo pi) {
		
		return mailDao.selectSendList(sqlSession, empNo, pi);
	}

}
