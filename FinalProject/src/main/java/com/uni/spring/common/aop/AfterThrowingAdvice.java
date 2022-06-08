package com.uni.spring.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import ch.qos.logback.classic.Logger;

// 예외 발생시 로그 찍기위한 AOP
@Aspect
@Component
public class AfterThrowingAdvice {
	private static final Logger logger=(Logger) LoggerFactory.getLogger(AfterThrowingAdvice.class);
	
	@AfterThrowing(value="execution(* com.uni.spring..*(..))", throwing="exceptObj")
	public void exceptionLog(JoinPoint jp, Exception exceptObj) {
		
		String method = jp.getSignature().getName();
		
		logger.warn(method + "() 메소드 수행 중 예외 발생");
		
		if(exceptObj instanceof IllegalArgumentException) {
			logger.warn("부적합한 값 입력");
		}else if (exceptObj instanceof NumberFormatException) {
			logger.warn("숫자 형식의 값이 아닙니다.");
		}else if(exceptObj instanceof NullPointerException) {
			logger.warn("Null값이 입력되었습니다.");
		}else if(exceptObj instanceof Exception) {
			logger.warn("예외가 발생했습니다.");
		}
	}
}
