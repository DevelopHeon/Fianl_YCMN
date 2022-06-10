package com.uni.spring.schedule.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.schedule.model.dao.ScheduleDao;
import com.uni.spring.schedule.model.dto.Schedule;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {

	private final ScheduleDao scheduleDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public List<Schedule> getschedule() throws Exception{
		return scheduleDao.getschedule(sqlSession);
	}

}
