package com.my.attendance.service;

import java.util.List;

import com.my.attendance.domain.Plan;

public interface PlanService {
	List<Plan> getPlans();
	void addPlan(String planTitle, String planContent);
	void fixPlan(Plan plan);
	void delPlan(Plan plan);
}
