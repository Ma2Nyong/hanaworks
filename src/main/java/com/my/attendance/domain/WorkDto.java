package com.my.attendance.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class WorkDto {
	private int workNo;
	private LocalDateTime startTime;
	private int employeeNo;
}
