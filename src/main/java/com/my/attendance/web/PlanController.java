package com.my.attendance.web;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.my.attendance.domain.Holiday;
import com.my.attendance.domain.Plan;
import com.my.attendance.service.PlanService;

import jakarta.servlet.http.HttpSession;

@Controller("planController")
public class PlanController {
	@Autowired private PlanService planService;
	
	@GetMapping
	@RequestMapping("admin/plan/planlist")
	@CompanyCheck
	public ModelAndView planlist(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/plan/planlist");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("plan/getplan")
	@EmployeeCheck
	public ModelAndView getplan(ModelAndView mv, HttpSession session) {
		mv.setViewName("plan/getplan");
		return mv;
	}
	
	@GetMapping("admin/plan/planlist/getPlan")
	@ResponseBody
	public List<Plan> getPlans(String companyId) {
	    return planService.getPlans(companyId);
	}
	
	@GetMapping("admin/plan/planlist/getHoliday")
	@ResponseBody
	public List<Holiday> getHolidays(String companyId) {
	    return planService.getHolidays(companyId);
	}
	
	@PostMapping("admin/plan/planlist/add")
	public ResponseEntity<String> addPlan(String planTitle,
	    @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate planDate, String planContent,  String companyId) {
	    planService.addPlan(planTitle, planDate, planContent, companyId);
	    return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@PutMapping("admin/plan/planlist/fix")
	public ResponseEntity<String> fixPlan(@RequestBody Plan plan) {
	    planService.fixPlan(plan);
	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@DeleteMapping("admin/plan/planlist/del/{planNo}")
	public ResponseEntity<String> delPlan(@PathVariable int planNo) {
	    planService.delPlan(planNo);
	    return new ResponseEntity<>(HttpStatus.OK);
	}
}
