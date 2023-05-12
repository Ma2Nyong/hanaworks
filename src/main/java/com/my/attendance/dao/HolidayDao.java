package com.my.attendance.dao;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.attendance.domain.Holiday;

public interface HolidayDao {
	List<Holiday> selectHolidays(@Param("yearMonth")YearMonth yearMonth,
								@Param("companyId") String companyId);
	List<Holiday> selectUserHoliday(@Param("employeeNo") int employeeNo);
	void insertHoliday(@Param("holDate") LocalDate holDate,
						@Param("holContent") String holContent,
						@Param("employeeNo") int employeeNo);
	void updateHoliday(Holiday holiday);
	void deleteHoliday(int holidayNo);
}
