package com.uni.spring.notice.model.service;

import java.util.ArrayList;

import com.uni.spring.notice.model.dto.Notice;

public interface NoticeService {

	ArrayList<Notice> selectNoticeList();

}
