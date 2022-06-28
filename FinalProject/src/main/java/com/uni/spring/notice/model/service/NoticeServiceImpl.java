package com.uni.spring.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.notice.model.dao.NoticeDao;
import com.uni.spring.notice.model.dto.Notice;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class NoticeServiceImpl implements NoticeService {

	private final NoticeDao noticeDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Notice> selectNoticeList(int rownum) {
		return noticeDao.selectNoticeList(sqlSession, rownum);
	}

	@Override
	public void insertNotice(Notice notice, Attachment attachment) {
		
		int result1 = noticeDao.insertNotice(sqlSession, notice);
		int result2 = 1; 
		
		if(attachment != null) {
			noticeDao.insertAttachment(sqlSession, attachment);
		}
	
		if(result1 * result2 < 0) {
			throw new CommException("공지사항 등록 실패");
		}
	}

	@Override
	public Notice selectNotice(int noticeNo) {
		
		Notice notice = null;
		int result = noticeDao.increaseCount(sqlSession, noticeNo);
		
		if(result < 0) {
			throw new CommException("조회수 증가 실패");
		}else {
			notice = noticeDao.selectNotice(sqlSession, noticeNo);
			
		}
		
		return notice;
	}

	@Override
	public void updateNotice(Notice notice, Attachment attachment) {
		int result1 = noticeDao.updateNotice(sqlSession, notice);
		int result2 = 1;
		
		if(attachment != null) {
			result2 = noticeDao.updateAttachment(sqlSession, attachment);
		}
		
		if(result1 * result2 < 0) {
			throw new CommException("공지사항 수정 실패");
		}
	}

	@Override
	public void deleteNotice(int noticeNo) {
		
		int result = noticeDao.deleteNotice(sqlSession, noticeNo);
		
		if(result < 0) {
			throw new CommException("공지사항 삭제 실패");
		}
	}

	@Override
	public void deleteAttachment(int noticeNo) {
		
		int result = noticeDao.deleteAttachment(sqlSession, noticeNo);
		
		if(result < 0) {
			throw new CommException("공지사항 첨부파일 삭제 실패");
		}
	}

}
