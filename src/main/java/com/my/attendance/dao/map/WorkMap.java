package com.my.attendance.dao.map;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import com.my.attendance.domain.Work;
import com.my.attendance.domain.WorkDto;

public interface WorkMap {
	int insertStartTime(int employeeNo);
	WorkDto selectInsertStart(int employeeNo);
	int updateEndTime(int workNo);
	Work selectInsertEnd(int workNo);
	List<Work> selectChoiceDay(LocalDate choiceDay, String companyId);
	List<Work> selectworkHoliday(LocalDate choiceDay, String companyId);
	List<Work> selectWorkHolidays(YearMonth yearMonth, int employeeNo);
}
