package com.my.attendance.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.attendance.dao.PlanDao;
import com.my.attendance.domain.Holiday;
import com.my.attendance.domain.Plan;

@Service
public class PlanServiceImpl implements PlanService {
	@Autowired private PlanDao planDao;
	
	@Override
	public List<Plan> getPlans(String companyId) {
		return planDao.selectPlans(companyId);
	}
	
	@Override
	public List<Holiday> getHolidays(String companyId) {
		return planDao.selectHolidays(companyId);
	}
	
	@Override
	public void addPlan(String planTitle, LocalDate planDate, String planContent, String companyId) {
		planDao.insertPlan(planTitle, planDate, planContent, companyId);
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
