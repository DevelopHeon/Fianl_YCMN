package com.uni.spring.schedule.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.uni.spring.schedule.model.dao.ScheduleDao;
import com.uni.spring.schedule.model.dto.Schedule;
import com.uni.spring.schedule.model.dto.ScheduleDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {

	private final ScheduleDao scheduleDao;
	private final SqlSessionTemplate sqlSession;

	/*@Override
	public List<Schedule> getScheduleList() {
		// TODO Auto-generated method stub
		return scheduleDao.getScheduleList(sqlSession);
	}*/
	
	@Override
	public List<ScheduleDTO> getScheduleList() {
		// TODO Auto-generated method stub
		return scheduleDao.getScheduleList(sqlSession);
	}

	@Override
	public Integer insertSchedule(Schedule schedule) {
		// TODO Auto-generated method stub
		return scheduleDao.insertSchedule(sqlSession,schedule);
	}

	@Override
	public Integer deleteSchedule(int scheduleNo) {
		// TODO Auto-generated method stub
		return scheduleDao.deleteSchedule(sqlSession,scheduleNo);
	}

}
