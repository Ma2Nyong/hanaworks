package com.my.attendance.domain;

import java.time.LocalDate;
import java.time.YearMonth;

import lombok.Data;

@Data
public class Holiday {
	private String empName;
	private int employeeNo;
	private String companyId;
	private int holidayNo;
	private LocalDate holDate;
	private String holContent;
	private YearMonth yearMonth;
}
