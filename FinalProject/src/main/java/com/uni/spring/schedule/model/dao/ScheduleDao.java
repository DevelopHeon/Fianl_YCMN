package com.uni.spring.schedule.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.schedule.model.dto.Schedule;

@Repository
public class ScheduleDao {


	public List<Schedule> getScheduleList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("scheduleMapper.getscheduleList");
	}

	public int insertSchedule(SqlSessionTemplate sqlSession, Schedule schedule) {
		// TODO Auto-generated method stub
		return sqlSession.insert("scheduleMapper.insertSchedule", schedule);
	}

	public int deleteSchedule(SqlSessionTemplate sqlSession, int scheduleNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("scheduleMapper.deleteSchedule", scheduleNo);
	}

	
	

}
