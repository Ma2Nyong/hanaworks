package com.my.attendance.service;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;
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
	public void addPlan(String planTitle, LocalDate planDate, String planContent) {
		planDao.insertPlan(planTitle, planDate, planContent);
	}
	
	@Override
	public void fixPlan(Plan plan) {
		planDao.updatePlan(plan);
	}
	
	@Override
	public void delPlan(int planNo) {
		planDao.deletePlan(planNo);
	}
}
