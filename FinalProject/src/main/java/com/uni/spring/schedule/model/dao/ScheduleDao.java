package com.uni.spring.schedule.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.schedule.model.dto.Schedule;

@Repository
public class ScheduleDao {

	public List<Schedule> getschedule(SqlSessionTemplate sqlSession) throws Exception{
		List<Schedule> schedule = null;
		schedule = (ArrayList)sqlSession.selectList("scheduleMapper.scheduleList");
		return null;
	}

	
	

}
