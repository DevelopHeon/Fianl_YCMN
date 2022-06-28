package com.uni.spring.hr.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.hr.model.dao.HrDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HrServiceImpl implements HrService {
	
	private final HrDao hrDao;
	private final SqlSessionTemplate sqlSession;

}
