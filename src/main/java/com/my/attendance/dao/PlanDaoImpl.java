package com.my.attendance.dao;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.attendance.dao.map.PlanMap;
import com.my.attendance.domain.Holiday;
import com.my.attendance.domain.Plan;

@Repository("planDao")
public class PlanDaoImpl implements PlanDao {
	@Autowired private PlanMap planMap;
	
	@Override
	public List<Plan> selectPlans(String companyId) {
		return planMap.selectPlans(companyId);
	}
	
	@Override
	public List<Holiday> selectHolidays(String companyId) {
		return planMap.selectHolidays(companyId);
	}
	
	@Override
	public void insertPlan(String planTitle, LocalDate planDate, String planContent, String companyId) {
		planMap.insertPlan(planTitle, planDate, planContent, companyId);
	}
	
	@Override
	public void updatePlan(Plan plan) {
		planMap.updatePlan(plan);
	}
	
	@Override
	public void deletePlan(int planNo) {
		planMap.deletePlan(planNo);
	}
}
