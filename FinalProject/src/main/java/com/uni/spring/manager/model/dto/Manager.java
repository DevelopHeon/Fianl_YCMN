package com.uni.spring.manager.model.dto;

import com.uni.spring.employee.model.dto.*;
import com.uni.spring.hr.model.dto.Hr;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Manager {
	
	private JobPosition JobPosition;
	private Department Department;
	private Hr hr;
	private Employee employee;
	
}
