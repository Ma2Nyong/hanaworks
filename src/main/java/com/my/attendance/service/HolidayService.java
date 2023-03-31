package com.my.attendance.service;

import java.time.LocalDate;
import java.util.List;

import com.my.attendance.domain.Holiday;

public interface HolidayService {
	List<Holiday> getHolidays();
	void addHoliday(LocalDate holDate, String holContent);
	void fixHoliday(Holiday holiday);
	void delHoliday(int holNo);
}
