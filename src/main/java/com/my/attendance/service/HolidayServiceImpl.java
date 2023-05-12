package com.my.attendance.service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.attendance.dao.HolidayDao;
import com.my.attendance.domain.Holiday;

@Service
public class HolidayServiceImpl implements HolidayService {
	@Autowired private HolidayDao holidayDao;
	
	@Override
	public List<Holiday> getHolidays(YearMonth yearMonth, String companyId) {
		return holidayDao.selectHolidays(yearMonth, companyId);
	}
	
	@Override
	public List<Holiday> getUserHoliday(int employeeNo) {
		return holidayDao.selectUserHoliday(employeeNo);
	}
	
	@Override
	public void addHoliday(LocalDate holDate, String holContent, int employeeNo) {
		holidayDao.insertHoliday(holDate, holContent, employeeNo);
	}
	
	@Override
	public void fixHoliday(Holiday holiday) {
		holidayDao.updateHoliday(holiday);
	}
	
	@Override
	public void delHoliday(int holidayNo) {
		holidayDao.deleteHoliday(holidayNo);
	}
}
