package com.uni.spring.mail.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.mail.model.dao.MailDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailServiceImpl implements MailService {
	
	private final MailDao mailDao;
	private final SqlSessionTemplate sqlSession;

}
