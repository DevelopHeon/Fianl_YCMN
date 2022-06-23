package com.uni.spring.employee.model.dto;

import org.springframework.web.multipart.MultipartFile;

import com.uni.spring.hr.model.dto.Hr;

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
   private String empOnOff;
   private int posNo;
   private int depNo;
   private String posName;
   private String depName;
   
   private Hr hr;
   private Department department;
   private JobPosition jobPosition;
   
	@Override
	public String toString() {
		return "Employee [empNo=" + empNo + ", empName=" + empName + ", empId=" + empId + ", empPwd=" + empPwd
				+ ", empEmail=" + empEmail + ", officeTel=" + officeTel + ", empPhone=" + empPhone + ", empLoc=" + empLoc
				+ ", empPfe=" + empPfe + ", category=" + category + ", status=" + status + ", empOnoff=" + empOnOff
				+ ", posNo=" + posNo + ", depNo=" + depNo + ", posName=" + posName + ", depName=" + depName + "]";
	}
}
