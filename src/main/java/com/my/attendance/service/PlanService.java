package com.my.attendance.service;

import java.time.LocalDate;
import java.util.List;

import com.my.attendance.domain.Plan;

public interface PlanService {
	List<Plan> getPlans();
	void addPlan(String planTitle, LocalDate planDate, String planContent);
	void fixPlan(Plan plan);
	void delPlan(int planNo);
}
