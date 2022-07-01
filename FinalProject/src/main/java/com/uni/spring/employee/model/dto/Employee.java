package com.uni.spring.employee.model.dto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

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
   
   @Size(max=10, message="이름은 최대 열 글자까지만 가능합니다.")
   @NotBlank(message="이름은 필수 입력값입니다.")
   @Pattern(regexp="^[가-힣a-zA-Z]*$", message="이름은 한글과 영문만 입력해주세요.")
   private String empName;
   
   @NotBlank(message="아이디는 필수 입력 값입니다.")
   @Size(max=50, message="아이디는 50자 이내만 가능합니다.")
   @Pattern(regexp="^[a-zA-z0-9]{4,12}$", message="아이디는 영문과 숫자만 가능합니다.")
   private String empId;
   
   @NotBlank(message="비밀번호는 필수 입력값입니다.")
   private String empPwd;
   
   @NotBlank(message="이메일은 필수 입력 값입니다.")
   @Pattern(regexp="^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$", message="올바르지 않은 이메일 양식입니다.")
   private String empEmail;
   
   private String officeTel;
   
   @NotBlank(message="전화번호는 필수 입력 값입니다.")
   @Size(max=30, message="전화번호는 30자 이내만 가능합니다.")
   @Pattern(regexp="^[0-9]*$", message="전화번호는 숫자만 입력이 가능합니다.")
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
