package com.my.attendance.domain;

import java.time.LocalDate;

import lombok.Data;

@Data
public class Plan {
	private int planNo;
	private String planTitle;
	private LocalDate planDate;
	private String planContent;
}
