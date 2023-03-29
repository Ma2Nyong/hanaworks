package com.my.attendance.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
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
	public void addPlan(String planTitle, String planContent) {
		planService.addPlan(planTitle, planContent);
	}
	
	@PutMapping("fix")
	public void fixPlan(@RequestBody Plan plan) {
		planService.fixPlan(plan);
	}
	
	@DeleteMapping("del")
	public void delPlan(@RequestBody Plan plan) {
		planService.delPlan(plan);
	}
}
