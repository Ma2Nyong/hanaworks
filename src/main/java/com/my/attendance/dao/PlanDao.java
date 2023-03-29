package com.my.attendance.dao;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.attendance.domain.Plan;

public interface PlanDao {
	List<Plan> selectPlans();
	void insertPlan(@Param("planTitle") String planTitle,
					@Param("planDate") LocalDate planDate,
					@Param("planContent") String planContent);
	void updatePlan(Plan plan);
	void deletePlan(int planId);
}
