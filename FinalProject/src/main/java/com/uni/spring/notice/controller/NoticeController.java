package com.uni.spring.notice.controller;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.uni.spring.notice.model.service.NoticeService;

import ch.qos.logback.classic.Logger;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class NoticeController {
	
	private final NoticeService noticeService;
	private static final Logger log=(Logger) LoggerFactory.getLogger(NoticeController.class);
	
	@RequestMapping("listNotice.do")
	public String selectNoticeList(Model model) {
		
		return "companyBoard/noticeListView";
	}

}
