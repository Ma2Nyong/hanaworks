package com.my.attendance.dao;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.attendance.dao.map.HolidayMap;
import com.my.attendance.domain.Holiday;

@Repository("holidayDao")
public class HolidayDaoImpl implements HolidayDao {
	@Autowired private HolidayMap holidayMap;
	
	@Override
	public List<Holiday> selectHolidays(YearMonth yearMonth, String companyId) {
		return holidayMap.selectHolidays(yearMonth, companyId);
	}
	
	@Override
	public List<Holiday> selectUserHoliday(int employeeNo) {
		return holidayMap.selectUserHoliday(employeeNo);
	}
	
	@Override
	public void insertHoliday(LocalDate holDate, String holContent, int employeeNo) {
		holidayMap.insertHoliday(holDate, holContent, employeeNo);
	}
	
	@Override
	public void updateHoliday(Holiday holiday) {
		holidayMap.updateHoliday(holiday);
	}
	
	@Override
	public void deleteHoliday(int holidayNo) {
		holidayMap.deleteHoliday(holidayNo);
	}
}
