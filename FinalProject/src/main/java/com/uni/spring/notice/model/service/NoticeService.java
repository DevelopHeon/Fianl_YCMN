package com.uni.spring.notice.model.service;

import java.util.ArrayList;

import com.uni.spring.common.dto.Attachment;
import com.uni.spring.notice.model.dto.Notice;

public interface NoticeService {

	ArrayList<Notice> selectNoticeList(int rownum);

	void insertNotice(Notice notice, Attachment attachment);

	Notice selectNotice(int noticeNo);

	void updateNotice(Notice notice, Attachment attachment);

	void deleteNotice(int noticeNo);

	void deleteAttachment(int noticeNo);

}
