package com.my.attendance.web;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.my.attendance.domain.Plan;
import com.my.attendance.service.PlanService;

@Controller("planController")
@RequestMapping("plan")
public class PlanController {
	@Autowired private PlanService planService;
	
	@GetMapping
	public ModelAndView main(ModelAndView mv) {
		mv.setViewName("main");
		return mv;
	}
	
	@GetMapping("get")
	public List<Plan> getPlans() {
		return planService.getPlans();
	}
	
	@PostMapping("add")
	public void addPlan(String planTitle, LocalDate planDate, String planContent) {
		planService.addPlan(planTitle, planDate, planContent);
	}
	
	@PutMapping("fix")
	public void fixPlan(@RequestBody Plan plan) {
		planService.fixPlan(plan);
	}
	
	@DeleteMapping("del/{planId}")
	public void delPlan(@PathVariable("planId") int planId) {
		planService.delPlan(planId);
	}
}
