package com.uni.spring.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import ch.qos.logback.classic.Logger;

@Aspect
@Component
public class TimeTraceApp { // 메소드 수행시간 체크하는 AOP
	private static final Logger logger=(Logger) LoggerFactory.getLogger(TimeTraceApp.class);
	
	@Around("execution(* com.uni.spring..*(..))")
	public Object timeLogAdvice(ProceedingJoinPoint join) throws Throwable {
		long start = System.currentTimeMillis();
		
		logger.debug("[Start] : " + join.toString());
		try {
			return join.proceed();
		} finally {
			long finish = System.currentTimeMillis();
			long timeMs = finish - start;
			logger.debug("[End] : " + join.toString() + " " + timeMs + "ms");
		}
	}
}
