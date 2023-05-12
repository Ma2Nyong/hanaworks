package com.my.attendance.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Work {
	private int workNo;
	private LocalDateTime startTime;
	private LocalDateTime endTime;
	private int employeeNo;
	private LocalDate choiceDay;
	private String companyId;
	private String empName;
	private String empPosition;
	private LocalDate holDate;
}
