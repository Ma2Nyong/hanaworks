package com.my.attendance.service;

import java.time.LocalDate;
import java.util.List;

import com.my.attendance.domain.Holiday;
import com.my.attendance.domain.Plan;

public interface PlanService {
	List<Plan> getPlans(String companyId);
	List<Holiday> getHolidays(String companyId);
	void addPlan(String planTitle, LocalDate planDate, String planContent, String companyId);
	void fixPlan(Plan plan);
	void delPlan(int planNo);
}
