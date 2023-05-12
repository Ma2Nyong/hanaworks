package com.my.attendance.web;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Component
@Aspect
public class Checkes {
	@After("@annotation(com.my.attendance.web.EmployeeCheck) && args(mv, session, ..)")
	public ModelAndView EmployeeLoginCheck(JoinPoint jp, ModelAndView mv, HttpSession session) {
		if(session.getAttribute("empNo") == null) {
			mv.setViewName("redirect:/");
		}
		return mv;
	}
	
	@After("@annotation(com.my.attendance.web.CompanyCheck) && args(mv, session, ..)")
	public ModelAndView CompanyLoginCheck(JoinPoint jp, ModelAndView mv, HttpSession session) {
		if(session.getAttribute("comId") == null) {
			mv.setViewName("redirect:/company");
		}
		return mv;
	}
	
	@After("@annotation(com.my.attendance.web.AdminCheck) && args(mv, session, ..)")
	public ModelAndView AdminLoginCheck(JoinPoint jp, ModelAndView mv, HttpSession session) {
		if(session.getAttribute("adminId") == null) {
			mv.setViewName("redirect:/admin");
		}
		return mv;
	}
}
