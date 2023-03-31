package com.my.attendance.domain;

import java.time.LocalDate;

import lombok.Data;

@Data
public class Holiday {
	private int holNo;
	private LocalDate holDate;
	private String holContent;
}
