package com.uni.spring.mail.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.dto.Attachment;

@Repository
public class MailDao {

	public int insertMail(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.insert("mailMapper.insertMail", attachment);

	}

}
