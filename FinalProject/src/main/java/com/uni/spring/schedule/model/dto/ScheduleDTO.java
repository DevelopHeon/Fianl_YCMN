package com.uni.spring.schedule.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ScheduleDTO {
	
	private int sc_id; // 일정코드
	private String sc_title; // 일정내용
	private String sc_start; // 일정시작일
	private String sc_end; // 일정종료일
	private int emp_id; // 직원코드
}
