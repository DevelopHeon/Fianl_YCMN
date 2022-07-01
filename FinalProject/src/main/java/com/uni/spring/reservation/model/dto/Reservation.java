package com.uni.spring.reservation.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Reservation {
	
	int rezNo; // 예약 번호
	int rezWriter; // 사원 번호
	String rezTitle; // 예약 명/예약 정보
	String startTime; // 예약 시작 시간
	String endTime; // 예약 완료 시간
	String status; // 예약 상태
	int rscNo; // 자원 번호
	String rscName; // 자원 명
	
	Resources resources;
	String empName; // 사원 이름

	@Override
	public String toString() {
		return "Reservation [rezNo=" + rezNo + ", rezWriter=" + rezWriter + ", rezTitle=" + rezTitle + ", startTime="
				+ startTime + ", endTime=" + endTime + ", status=" + status + ", rscNo=" + rscNo + ", rscName="
				+ rscName + ", resources=" + resources + "]";
	}
	
	
}
