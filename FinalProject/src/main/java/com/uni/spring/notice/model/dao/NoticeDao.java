package com.uni.spring.notice.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.notice.model.dto.Notice;

@Repository
public class NoticeDao {

	public ArrayList<Notice> selectNoticeList(SqlSessionTemplate sqlSession, int rownum) {
		return (ArrayList)sqlSession.selectList("noticeMapper.selectNoticeList", rownum);
	}

	public int insertNotice(SqlSessionTemplate sqlSession, Notice notice) {
		return sqlSession.insert("noticeMapper.insertNotice", notice);
	}

	public int insertAttachment(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.insert("noticeMapper.insertAttachment", attachment);
	}
	
	public int increaseCount(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.increaseCount", noticeNo);
	}

	public Notice selectNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("noticeMapper.selectNotice", noticeNo);
	}

	public int updateNotice(SqlSessionTemplate sqlSession, Notice notice) {
		return sqlSession.update("noticeMapper.updateNotice", notice);
	}

	public int updateAttachment(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.update("noticeMapper.updateAttachment", attachment);
	}

	public int deleteNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.delete("noticeMapper.deleteNotice", noticeNo);
	}

	public int deleteAttachment(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.delete("noticeMapper.deleteAttachment", noticeNo);
	}

}
