package com.uni.spring.employee.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class TimeOffContent {
	private int timeOffContentNo;
	private int appNo;
	private int empNo;
	private Date today;
	private String timeoffType;
	private String timeoffContent;
	private double totalNum;
	private double useNum;
	private double remainNum;
	private String appStatus;
}
