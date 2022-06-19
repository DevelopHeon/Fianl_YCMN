package com.uni.spring.mail.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.mail.model.dto.Mail;

@Repository
public class MailDao {
	//메일 insert
	public int insertMail(SqlSessionTemplate sqlSession, Mail mail) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mailMapper.insertMail", mail);
	}
	//메일 첨부파일 insert
	public int insertAttachment(SqlSessionTemplate sqlSession, Attachment attachment) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mailMapper.insertAttachment", attachment);
	}

}
