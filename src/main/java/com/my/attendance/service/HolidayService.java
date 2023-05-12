package com.my.attendance.service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import com.my.attendance.domain.Holiday;

public interface HolidayService {
	List<Holiday> getHolidays(YearMonth yearMonth, String companyId);
	List<Holiday> getUserHoliday(int employeeNo);
	void addHoliday(LocalDate holDate, String holContent, int employeeNo);
	void fixHoliday(Holiday holiday);
	void delHoliday(int holidayNo);
}
