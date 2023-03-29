package com.my.attendance.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.attendance.dao.PlanDao;
import com.my.attendance.domain.Plan;

@Service
public class PlanServiceImpl implements PlanService {
	@Autowired private PlanDao planDao;
	
	@Override
	public List<Plan> getPlans() {
		return planDao.selectPlans();
	}
	
	@Override
	public void addPlan(String planTitle, String planContent) {
		planDao.insertPlan(planTitle, planContent);
	}
	
	@Override
	public void fixPlan(Plan plan) {
		planDao.updatePlan(plan);
	}
	
	@Override
	public void delPlan(Plan plan) {
		planDao.deletePlan(plan);
	}
}
