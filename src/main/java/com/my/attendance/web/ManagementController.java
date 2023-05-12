package com.my.attendance.web;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class ManagementController {
	@Value("${attachPath}") private String attachPath;
	
	@GetMapping
	@RequestMapping("admin/management/logo")
	@AdminCheck
	public ModelAndView logoAdmin(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/management/logo");
		return mv;
	}
	   
	@PostMapping("admin/management/logo")
	public String handleFileUpload(@RequestParam("file") MultipartFile file) {
		try {
			file.transferTo(new File(attachPath + "logo.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "admin/management/logo";
	}

	@PostMapping("admin/management/logo_m")
	public String handleFileUpload2(@RequestParam("file") MultipartFile file) {
		try {
			file.transferTo(new File(attachPath + "logo_m.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "admin/management/logo";
	}

	@PostMapping("admin/management/intro")
	public String handleFileUpload3(@RequestParam("file") MultipartFile file) {
		try {
			file.transferTo(new File(attachPath + "intro_img.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "admin/management/logo";
	}

	@PostMapping("admin/management/intro_m")
	public String handleFileUpload4(@RequestParam("file") MultipartFile file) {
		try {
			file.transferTo(new File(attachPath + "intro_img_m.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "admin/management/logo";
	}

	@PostMapping("admin/management/emp_img")
	public String handleFileUpload5(@RequestParam("file") MultipartFile file) {
		try {
			file.transferTo(new File(attachPath + "emp_img.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "admin/management/logo";
	}
}
