package com.uni.spring.hr.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Hr {
	private int empNo;
	private Date hireDate;
	private String birthDate;
	private String gender;
	private String hireCategory;
	private String sarary;
	private String marryStatus;
	private String miliStatus;
	private String personnelEval;
	private Date entDate;
	private String entCon;
	
	@Override
	public String toString() {
		return "Hr [empNo=" + empNo + ", hireDate=" + hireDate + ", birthDate=" + birthDate + ", gender=" + gender
				+ ", hireCategory=" + hireCategory + ", sarary=" + sarary + ", marryStatus=" + marryStatus
				+ ", miliStatus=" + miliStatus + ", personnelEval=" + personnelEval + ", entDate=" + entDate
				+ ", entCon=" + entCon + "]";
	}
	
}
