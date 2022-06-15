package com.uni.spring.schedule.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uni.spring.schedule.model.dto.Schedule;
import com.uni.spring.schedule.model.dto.ScheduleDTO;
import com.uni.spring.schedule.model.service.ScheduleService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ScheduleController {
	
	@Autowired
	private ScheduleService service;
	
	
	@RequestMapping("schedule.do")
	public String schedule() {
		return "schedule/calendar";
	}

	/*@RequestMapping("GetScheduleList.do")
	@ResponseBody
	public List<Schedule> getScheduleList() {
		List<Schedule> list = service.getScheduleList();
		return list;
	}*/
	
	@RequestMapping("GetScheduleList.do")
	@ResponseBody
	public List<ScheduleDTO> getScheduleList() {
		List<ScheduleDTO> list = service.getScheduleList();
		System.out.println("controller//////////////////"+list+"///////////");
		return list;
	}

	@RequestMapping("InsertSchedule.do")
	@ResponseBody
	public HashMap<String, Integer> insertSchedule(@RequestBody Schedule schedule) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", service.insertSchedule(schedule));
		return map;
	}

	@RequestMapping("DeleteSchedule.do")
	@ResponseBody
	public HashMap<String, Integer> deleteSchedule(@RequestBody Schedule schedule) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", service.deleteSchedule(schedule.getScheduleNo()));
		return map;
	}

}
