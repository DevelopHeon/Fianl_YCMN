package com.uni.spring.schedule.model.service;

import java.util.List;

import com.uni.spring.schedule.model.dto.Schedule;
import com.uni.spring.schedule.model.dto.ScheduleDTO;

public interface ScheduleService {

	//List<Schedule> getScheduleList();
	List<ScheduleDTO> getScheduleList();

	Integer insertSchedule(Schedule schedule);

	Integer deleteSchedule(int scheduleNo);

}
