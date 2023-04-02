package com.my.attendance.domain;

import java.time.LocalDate;

import lombok.Data;

@Data
public class Holiday {
	private String employeeName;
	private int holNo;
	private LocalDate holDate;
	private String holContent;
}
