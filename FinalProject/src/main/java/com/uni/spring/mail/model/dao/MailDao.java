package com.uni.spring.mail.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.mail.model.dto.Mail;
import com.uni.spring.mail.model.dto.ReceiveMail;

@Repository
public class MailDao {
	//메일 insert
	public int insertMail(SqlSessionTemplate sqlSession, Mail mail) {
		return sqlSession.insert("mailMapper.insertMail", mail);
	}
	//메일 첨부파일 insert
	public int insertAttachment(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.insert("mailMapper.insertAttachment", attachment);
	}
	//보낸메일List 페이지 수
	public int selectSendListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("mailMapper.selectSendListCount");
	}
	//보낸메일List
	public ArrayList<ReceiveMail> selectSendList(SqlSessionTemplate sqlSession, int empNo, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectSendList", empNo, rowBounds);
	}

}
