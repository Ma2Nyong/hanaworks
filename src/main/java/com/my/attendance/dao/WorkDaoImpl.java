package com.my.attendance.dao;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.attendance.dao.map.WorkMap;
import com.my.attendance.domain.Work;
import com.my.attendance.domain.WorkDto;

@Repository
public class WorkDaoImpl implements WorkDao {
	@Autowired WorkMap workMap;
	
	@Override
	public void inseartStartTime(int employeeNo) {
		workMap.insertStartTime(employeeNo);
	}
	
	@Override
	public WorkDto selectInsertStart(int employeeNo) {
		return workMap.selectInsertStart(employeeNo);
	}
	
	@Override
	public void updateEndTime(int workNo) {
		workMap.updateEndTime(workNo);
	}
	
	@Override
	public Work selectInsertEnd(int workNo) {
		return workMap.selectInsertEnd(workNo);
	}

	@Override
	public List<Work> selectChoiceDay(LocalDate choiceDay, String companyId) {
		return workMap.selectChoiceDay(choiceDay, companyId);
	}
	
	@Override
	public List<Work> selectworkHoliday(LocalDate choiceDay, String companyId) {
		return workMap.selectworkHoliday(choiceDay, companyId);
	}
	
	@Override
	public List<Work> selectWorkHolidays(YearMonth yearMonth, int employeeNo) {
		return workMap.selectWorkHolidays(yearMonth, employeeNo);
	}
}
