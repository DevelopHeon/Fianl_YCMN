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
	public int selectSendListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("mailMapper.selectSendListCount", empNo);
	}
	//보낸메일List
	public ArrayList<ReceiveMail> selectSendList(SqlSessionTemplate sqlSession, int empNo, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectSendList", empNo, rowBounds);
	}
	//보낸메일List 삭제
	public int updateTrashSMail(SqlSessionTemplate sqlSession, int receiveNo) {
		return sqlSession.update("mailMapper.updateTrashSMail", receiveNo);

	}
	//휴지통List
	public ArrayList<ReceiveMail> selectDeleteList(SqlSessionTemplate sqlSession, int empNo) {
		return (ArrayList)sqlSession.selectList("mailMapper.selectDeleteList", empNo);
	}
	//받은메일List 페이지 수
	public int selectReceiveListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("mailMapper.selectReceiveListCount", empNo);
	}
	//받은메일List
	public ArrayList<ReceiveMail> selectReceiveList(SqlSessionTemplate sqlSession, int empNo, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectReceiveList", empNo, rowBounds);
	}
	//받은메일 조회 카운팅
	public int increaseCount(SqlSessionTemplate sqlSession, int receiveNo) {
		return sqlSession.update("mailMapper.increaseCount", receiveNo);
	}
	//받은메일 조회
	public ReceiveMail selectReceiveMail(SqlSessionTemplate sqlSession, int receiveNo) {
		return sqlSession.selectOne("mailMapper.selectReceiveMail", receiveNo);
	}
	//받은메일조회에서 삭제
	public int updateTrashRMail(SqlSessionTemplate sqlSession, int receiveNo) {
		return sqlSession.update("mailMapper.updateTrashRMail", receiveNo);
	}
	//보낸메일 조회
	public ReceiveMail selectSendMail(SqlSessionTemplate sqlSession, int mailNo) {
		return sqlSession.selectOne("mailMapper.selectSendMail", mailNo);
	}
	//안읽은메일 개수
	public int selectUnreadMail(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("mailMapper.selectUnreadMail", empNo);

	}
	//전체 메일 개수
	public int selectTotalMail(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("mailMapper.selectTotalMail", empNo);

	}


}
