package com.uni.spring.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.uni.spring.notice.model.dto.Notice;
import com.uni.spring.notice.model.service.NoticeService;

import ch.qos.logback.classic.Logger;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class NoticeController {
	
	private final NoticeService noticeService;
	private static final Logger log=(Logger) LoggerFactory.getLogger(NoticeController.class);
	
	// 공지사항 목록 페이지로 전환 메소드
	@RequestMapping("listNotice.do")
	public String selectNoticeList(Model model) {

		ArrayList<Notice> list = noticeService.selectNoticeList();
		model.addAttribute("list", list);
		
		return "companyBoard/noticeListView";
	}
	
	@RequestMapping("enrollFormNotice.do")
	public String enrollFormNotice() {
		return "companyBoard/noticeEnrollForm";
	}
	
	@RequestMapping("insertNotice.do")
	public String insertNotice(Notice notice, HttpServletRequest request,
			@RequestParam(name="uploadFile", required=false) MultipartFile file) {
		
		
		return null;
	}

}
