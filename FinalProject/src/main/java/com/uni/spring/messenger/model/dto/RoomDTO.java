package com.uni.spring.messenger.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter @Setter
@ToString
public class RoomDTO {
	private int roomNumber;
	private String roomName;
}
