package com.my.attendance.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.attendance.domain.Plan;

public interface PlanMap {
	List<Plan> selectPlans();
	int insertPlan(@Param("planTitle") String planTitle,
					@Param("planContent") String planContent);
	int updatePlan(Plan plan);
	int deletePlan(Plan plan);
}
