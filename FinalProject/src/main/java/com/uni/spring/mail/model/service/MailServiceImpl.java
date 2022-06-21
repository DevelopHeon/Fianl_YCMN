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
		
		int resultA = 1; //일단 1 첨부파일이 있다면 29행 로직 탐
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
	public int selectSendListCount(int empNo) {
		return mailDao.selectSendListCount(sqlSession, empNo);
	}
	
	//보낸메일함List
	@Override
	public ArrayList<ReceiveMail> selectSendList(int empNo, PageInfo pi) {
		return mailDao.selectSendList(sqlSession, empNo, pi);
	}
	
	//보낸메일함List에서 삭제
	@Override
	public void updateTrashSMail(int receiveNo) {
		int result = mailDao.updateTrashSMail(sqlSession, receiveNo);
		if(result < 0) {
			throw new CommException("보낸메일 삭제 실패");
		}	
	}
	
	//휴지통 List
	@Override
	public ArrayList<ReceiveMail> selectDeleteList(int empNo) {
		return mailDao.selectDeleteList(sqlSession, empNo);
	}
	
	//받은 메일함 List 페이지
	@Override
	public int selectReceiveListCount(int empNo) {
		return mailDao.selectReceiveListCount(sqlSession, empNo);
	}
	
	//받은 메일함 List
	@Override
	public ArrayList<ReceiveMail> selectReceiveList(int empNo, PageInfo pi) {
		return mailDao.selectReceiveList(sqlSession, empNo, pi);
	}
	
	//받은 메일 조회
	@Override
	public ReceiveMail selectReceiveMail(int receiveNo) {
		ReceiveMail mail = null;
		
		int result = mailDao.increaseCount(sqlSession, receiveNo);
		if(result < 0) {
			throw new CommException("메일 카운팅 실패");
		}else {
			//카운팅 후 메일확인
			mail = mailDao.selectReceiveMail(sqlSession, receiveNo);
		}
		return mail;
	}
	//받은메일조회에서 삭제
	@Override
	public void updateTrashRMail(int receiveNo) {
		int result = mailDao.updateTrashRMail(sqlSession, receiveNo);
		if(result < 0) {
			throw new CommException(receiveNo + "번 메일 수신자 삭제 실패");
		}	
	}
	//보낸 메일 조회
	@Override
	public ReceiveMail selectSendMail(int mailNo) {
		return mailDao.selectSendMail(sqlSession, mailNo);
	}


}
