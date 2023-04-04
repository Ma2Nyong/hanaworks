package com.my.attendance.dao.map;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.attendance.domain.Holiday;

public interface HolidayMap {
	List<Holiday> selectHolidays(@Param("yearMonth")YearMonth yearMonth);
	int insertHoliday(@Param("holDate") LocalDate holidayDate,
						@Param("holContent") String holidayContent);
	int updateHoliday(Holiday holiday);
	int deleteHoliday(int holidayNo);
}
