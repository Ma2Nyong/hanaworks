package com.my.attendance.web;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.my.attendance.domain.Work;
import com.my.attendance.domain.WorkDto;
import com.my.attendance.service.WorkService;

import jakarta.servlet.http.HttpSession;

@Controller
public class WorkController {
	@Autowired WorkService workService;
	
	@GetMapping
	@RequestMapping("work/record")
	@EmployeeCheck
	public ModelAndView recordTime(ModelAndView mv, HttpSession session) {
		mv.setViewName("work/record");
		return mv;
	}

	@GetMapping
	@RequestMapping("admin/work/getlist")
	@CompanyCheck
	public ModelAndView getlist(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/work/getlist");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("work/getlist")
	@EmployeeCheck
	public ModelAndView getholiday(ModelAndView mv, HttpSession session) {
		mv.setViewName("work/getlist");
		return mv;
	}
	
	@ResponseBody
	@GetMapping("work/start")
	public String recordStartTime(int employeeNo,
			HttpSession session) {
		String result = "";
		
		workService.addStartTime(employeeNo); 
		WorkDto work = workService.getAddStart(employeeNo);
		
		if(work != null) {
			session.setAttribute("workNo", work.getWorkNo());
			result = work.getStartTime().format(DateTimeFormatter.ofPattern("HH:mm"));
		}
		
		return result;
	}
	
	@ResponseBody
	@GetMapping("work/end")
	public String recordEndTime(int workNo,
			HttpSession session) {
		String result = "";
		
		workService.fixEndTime(workNo);
		Work work = workService.getAddEnd(workNo);
		LocalDateTime time = work.getEndTime();
		
		if(time != null) {
			result = time.format(DateTimeFormatter.ofPattern("HH:mm"));
		}
		
		session.setAttribute("workNo", null);
		
		return result;
	}
	
	@GetMapping("admin/work/getlist/get")
	@ResponseBody
	public List<Work> getChoiceDay(@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate choiceDay, String companyId) {
	    return workService.getChoiceDay(choiceDay, companyId);
	}
	
	@GetMapping("admin/work/getlist/getworkHoliday")
	@ResponseBody
	public List<Work> getworkHoliday(@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate choiceDay, String companyId) {
		return workService.getworkHoliday(choiceDay, companyId);
	}
	
	@GetMapping("work/getlist/get")
	@ResponseBody
	public List<Work> getWorkHolidays(@DateTimeFormat(pattern = "yyyy-MM") YearMonth yearMonth, int employeeNo) {
	    return workService.getWorkHolidays(yearMonth, employeeNo);
	}
}
