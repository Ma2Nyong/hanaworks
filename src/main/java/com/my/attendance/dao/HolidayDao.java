package com.my.attendance.dao;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.attendance.domain.Holiday;

public interface HolidayDao {
	List<Holiday> selectHolidays();
	void insertHoliday(@Param("holDate") LocalDate holDate,
						@Param("holContent") String holContent);
	void updateHoliday(Holiday holiday);
	void deleteHoliday(int holNo);
}
