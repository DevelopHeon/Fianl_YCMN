package com.uni.spring.messenger.controller;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.uni.spring.messenger.model.service.MessengerService;

@Controller
public class WebSocketHandler extends TextWebSocketHandler implements InitializingBean{
	
	@Autowired
	MessengerService mService;
	
	 private final ObjectMapper objectMapper = new ObjectMapper();
	
}
