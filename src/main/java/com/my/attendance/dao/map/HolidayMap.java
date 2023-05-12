package com.my.attendance.dao.map;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.attendance.domain.Holiday;

public interface HolidayMap {
	List<Holiday> selectHolidays(@Param("yearMonth")YearMonth yearMonth,
								@Param("companyId") String companyId);
	List<Holiday> selectUserHoliday(@Param("employeeNo") int employeeNo);
	int insertHoliday(@Param("holDate") LocalDate holDate,
						@Param("holContent") String holContent,
						@Param("employeeNo") int employeeNo);
	int updateHoliday(Holiday holiday);
	int deleteHoliday(int holidayNo);
}
