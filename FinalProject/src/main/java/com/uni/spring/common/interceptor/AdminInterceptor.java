package com.uni.spring.common.interceptor;

import java.net.InetAddress;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.uni.spring.employee.model.dto.Employee;

import ch.qos.logback.classic.Logger;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = (Logger) LoggerFactory.getLogger(AdminInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		
		if(loginUser != null && loginUser.getEmpId().equals("admin")) { // loginUser가 null이 아니고, admin일 경우
			logger.info("============ AdminInterceptor 동작 - 접근 성공 ===========");
			InetAddress local = InetAddress.getLocalHost();
			logger.info(loginUser.getEmpId() + " (" + local.getHostAddress()+")님이 접근했습니다.");
			return true;
		}else {
			logger.info("============ AdminInterceptor 동작 - 접근 실패 ===========");
			logger.info(loginUser.getEmpId() + " 회원이 ["+ request.getRequestURI() + "]의 접근을 시도했습니다!!");
			response.sendError(404);
			return false;
		}
	}

}
