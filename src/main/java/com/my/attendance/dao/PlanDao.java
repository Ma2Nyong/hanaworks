package com.my.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.attendance.domain.Plan;

public interface PlanDao {
	List<Plan> selectPlans();
	void insertPlan(@Param("planTitle") String planTitle,
					@Param("planContent") String planContent);
	void updatePlan(Plan plan);
	void deletePlan(Plan plan);
}
