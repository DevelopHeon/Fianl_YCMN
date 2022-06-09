package com.uni.spring.employee.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Employee {
   private int empNo;
   private String empName;
   private String empId;
   private String empPwd;
   private String email;
   private String officeTel;
   private String phone;
   private String empLoc;
   private String empPfe;
   private int category;
   private String status;
   private String onoff;
   private int positionNo;
   private int departmentNo;
   private String depName;
   private String posName;
   
	@Override
	public String toString() {
		return "Employee [empNo=" + empNo + ", empName=" + empName + ", empId=" + empId + ", empPwd=" + empPwd + ", email="
				+ email + ", officeTel=" + officeTel + ", phone=" + phone + ", empLoc=" + empLoc + ", empPfe=" + empPfe
				+ ", category=" + category + ", status=" + status + ", onoff=" + onoff + ", positionNo=" + positionNo
				+ ", departmentNo=" + departmentNo + "]";
	}
   
}
