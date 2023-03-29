package com.my.attendance.dao;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.attendance.dao.map.PlanMap;
import com.my.attendance.domain.Plan;

@Repository("planDao")
public class PlanDaoImpl implements PlanDao {
	@Autowired private PlanMap planMap;
	
	@Override
	public List<Plan> selectPlans() {
		return planMap.selectPlans();
	}
	
	@Override
	public void insertPlan(String planTitle, LocalDate planDate, String planContent) {
		planMap.insertPlan(planTitle, planDate, planContent);
	}
	
	@Override
	public void updatePlan(Plan plan) {
		planMap.updatePlan(plan);
	}
	
	@Override
	public void deletePlan(int planId) {
		planMap.deletePlan(planId);
	}
}
