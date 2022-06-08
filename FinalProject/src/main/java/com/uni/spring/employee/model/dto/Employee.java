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
   private String empEmail;
   private String officeTel;
   private String empPhone;
   private String empLoc;
   private String empPfe;
   private int category;
   private String status;
   private String empOnoff;
   private int posNo;
   private int depNo;
   
	@Override
	public String toString() {
		return "Employee [empNo=" + empNo + ", empName=" + empName + ", empId=" + empId + ", empPwd=" + empPwd
				+ ", empEmail=" + empEmail + ", officeTel=" + officeTel + ", empPhone=" + empPhone + ", empLoc=" + empLoc
				+ ", empPfe=" + empPfe + ", category=" + category + ", status=" + status + ", empOnoff=" + empOnoff
				+ ", posNo=" + posNo + ", depNo=" + depNo + "]";
	}
   
}
