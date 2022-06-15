package com.uni.spring.schedule.model.service;

import java.util.ArrayList;
import java.util.List;

import com.uni.spring.schedule.model.dto.Schedule;

public interface ScheduleService {

	List<Schedule> getScheduleList();

	Integer insertSchedule(Schedule schedule);

	Integer deleteSchedule(int scheduleNo);

}
