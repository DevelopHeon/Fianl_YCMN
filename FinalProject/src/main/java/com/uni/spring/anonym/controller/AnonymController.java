package com.uni.spring.anonym.controller;

import java.util.ArrayList;

import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;
import com.uni.spring.anonym.model.dto.AnonymBoard;
import com.uni.spring.anonym.model.dto.AnonymReply;
import com.uni.spring.anonym.model.service.AnonymService;
import com.uni.spring.common.Pagination;
import com.uni.spring.common.dto.PageInfo;

import ch.qos.logback.classic.Logger;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AnonymController {

	private final AnonymService anonymService;
	private final BCryptPasswordEncoder bCryptWriterEncoder;
	private static final Logger log=(Logger) LoggerFactory.getLogger(AnonymController.class);
	
	@RequestMapping("anoBoardList.do")
	public String selectList(@RequestParam(value="currentPage", required = false, defaultValue = "1")
	int currentPage, Model model) {
		
		int listCount = anonymService.selectListCount();
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<AnonymBoard> list = anonymService.selectList(pi);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "companyBoard/AnonymBoardListView";
	}
	
	@RequestMapping("enrollFormAnonymBoard.do")
	public String insertAnonymBoardForm() {
		return "companyBoard/AnonymBoardEnrollForm";
	}
	
	@RequestMapping("insertAnonymBoard.do")
	public String insertAnonymBoard(AnonymBoard anonym) {
		// 익명성을 위해 작성자 암호화, 스프링 시큐리티 사용
		String writer = bCryptWriterEncoder.encode(anonym.getAnoWriter());
		log.info("작성자" + writer);
		anonym.setAnoWriter(writer);
		anonymService.insertAnonymBoard(anonym);
		
		return "redirect:anoBoardList.do";
	}
	
	@RequestMapping("detailAnonymBoard.do")
	public ModelAndView selectAnonymBoard(int anoNo, String confirmUser, ModelAndView mv) {
		
		AnonymBoard anonymBoard = anonymService.selectAnonymBoard(anoNo, confirmUser, bCryptWriterEncoder);
		
		log.info("작성자: "+anonymBoard.getAnoWriter());
		mv.addObject("anoBoard", anonymBoard).setViewName("companyBoard/AnonymBoardDetailView");
		
		return mv;
	}
	
	@RequestMapping("updateFormAnoBoard.do")
	public ModelAndView updateFormAnoBoard(int anoNo, ModelAndView mv) {
		
		AnonymBoard anoBoard = anonymService.selectAnonymBoard(anoNo, "작성자", bCryptWriterEncoder);
		
		mv.addObject("anoBoard", anoBoard).setViewName("companyBoard/AnonymBoardUpdateForm");
		return mv;
	}
	
	@RequestMapping("updateAnoBoard.do")
	public ModelAndView updateAnoBoard(AnonymBoard anoBoard, String userId, ModelAndView mv) {
		
		log.info("내용 : " +anoBoard.toString());
		anonymService.updateAnoBoard(anoBoard);
		
		mv.addObject("anoNo", anoBoard.getAnoNo()).addObject("confirmUser", userId)
		.setViewName("redirect:detailAnonymBoard.do");
		
		return mv;
	}
	
	@RequestMapping("deleteAnoBoard.do")
	public String deleteAnoBoard(int anoNo) {
		
		anonymService.deleteAnoBoard(anoNo);
		
		return "redirect:anoBoardList.do";
	}
	
	@ResponseBody
	@RequestMapping(value="rlistAnoBoard.do", produces="application/json; charset=utf-8")
	public String selectReplyList(int anoNo, String confirmUser) {
		
		ArrayList<AnonymReply> list = anonymService.selectReplyList(anoNo, confirmUser, bCryptWriterEncoder);
		
		return new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping(value="rinsertAnoBoard.do")
	public String insertAnoReply(AnonymReply aReply) {
		
		String writer = bCryptWriterEncoder.encode(aReply.getReplyWriter());
		aReply.setReplyWriter(writer);
		log.info("댓글작성자" + writer);
		
		int result = anonymService.insertAnoReply(aReply);
		
		return String.valueOf(result);
	}
	
	@ResponseBody
	@RequestMapping(value="rdeleteAnoBoard.do")
	public String deleteAnoReply(int replyNo) {
		
		int result = anonymService.deleteAnoReply(replyNo);
		
		return String.valueOf(result);
	}
	
	@RequestMapping("searchAnoBoard.do")
	public ModelAndView searchAnoBoard(String search, @RequestParam(value="currentPage", required = false, defaultValue = "1")
	int currentPage, ModelAndView mv) {
		
		int listCount = anonymService.selectSearchListCount(search);
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<AnonymBoard> list = anonymService.selectSearchList(search, pi);
		
		mv.addObject("list", list).addObject("pi", pi)
		.setViewName("companyBoard/AnonymBoardListView");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="mainAnoList.do", produces="application/json; charset=utf-8")
	public String SelectMainAnoList() {
		
		ArrayList<AnonymBoard> list = anonymService.SelectMainAnoList();
		
		return new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(list);
	}
}
