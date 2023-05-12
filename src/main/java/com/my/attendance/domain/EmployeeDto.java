package com.my.attendance.domain;

import java.time.LocalDate;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EmployeeDto {
	private String empId;
	private String empPw;
	private String empName;
	private String empAddr;
	private String empDetailAddr;
	private int empPostcode;
	private String empPh;
	private String empEmail;
	private LocalDate hireDate;
	private String empPosition;
	private String empPino;
	private MultipartFile profile;
}
