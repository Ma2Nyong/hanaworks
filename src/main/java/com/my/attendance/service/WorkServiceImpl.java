package com.my.attendance.service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.attendance.dao.WorkDao;
import com.my.attendance.domain.Work;
import com.my.attendance.domain.WorkDto;

@Service
public class WorkServiceImpl implements WorkService {
	@Autowired WorkDao workDao;
	
	@Override
	public void addStartTime(int employeeNo) {
		workDao.inseartStartTime(employeeNo);
	}
	
	@Override
	public WorkDto getAddStart(int employeeNo) {
		return workDao.selectInsertStart(employeeNo);
	}
	
	@Override
	public void fixEndTime(int workNo) {
		workDao.updateEndTime(workNo);
	}
	
	@Override
	public Work getAddEnd(int workNo) {
		return workDao.selectInsertEnd(workNo);
	}

	@Override
	public List<Work> getChoiceDay(LocalDate choiceDay, String companyId) {
		return workDao.selectChoiceDay(choiceDay, companyId);
	}
	
	@Override
	public List<Work> getworkHoliday(LocalDate choiceDay, String companyId) {
		return workDao.selectworkHoliday(choiceDay, companyId);
	}

	@Override
	public List<Work> getWorkHolidays(YearMonth yearMonth, int employeeNo) {
		return workDao.selectWorkHolidays(yearMonth, employeeNo);
	}
}
