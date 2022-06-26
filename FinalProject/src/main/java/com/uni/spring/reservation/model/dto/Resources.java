package com.uni.spring.reservation.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Resources {
	
	int rscNo; // 자원 번호
	String rscName; // 자원 명
	String rscEtc; // 자원 정보
	String status; // 자원 상태
	
	int rcNo; // 자원 분류 번호
	String rcName; // 자원 분류명 (회의실/비품)
	
	@Override
	public String toString() {
		return "Resources [rscNo=" + rscNo + ", rscName=" + rscName + ", rscEtc=" + rscEtc + ", status=" + status
				+ ", rcNo=" + rcNo + ", rcName=" + rcName + "]";
	}
}
