package com.uni.spring.communication.controller;

import java.util.ArrayList;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.GsonBuilder;
import com.uni.spring.communication.model.dto.Communication;
import com.uni.spring.communication.model.service.CommunicationService;

import ch.qos.logback.classic.Logger;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class CommunicationController {

	private final CommunicationService communicationService;
	private static final Logger log=(Logger) LoggerFactory.getLogger(CommunicationController.class);
	
	@ResponseBody
	@RequestMapping(value="commList.do", produces="application/json; charset=utf-8")
	public String selectCommList(int depNo) {
		
		ArrayList<Communication> list = communicationService.selectCommList(depNo);
		
		return new GsonBuilder().setDateFormat("yyyy-MM-dd").create().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping("comminsert.do")
	public String insertComm(Communication comm) {
		
		String text = comm.getCommContent();
		text = text.replace("\n", "<br>");
		log.info(text);
		
		comm.setCommContent(text);
		int result = communicationService.insertComm(comm);
		
		return String.valueOf(result);
	}
	
	@ResponseBody
	@RequestMapping("commDelete.do")
	public String deleteComm(int commNo) {
		
		int result = communicationService.deleteComm(commNo);
		
		return String.valueOf(result);
	}
}
