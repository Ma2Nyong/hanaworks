package com.my.hr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("plan")
public class PlanController {
	@GetMapping
	public ModelAndView main(ModelAndView mv) {
		mv.setViewName("main");
		return mv;
	}
}
