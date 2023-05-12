package com.my.attendance.service;

import java.util.List;

import com.my.attendance.domain.Admin;
import com.my.attendance.domain.Company;
import com.my.attendance.domain.Employee;

public interface UserService {
	// admin
	Admin admLoginCheck(String adminId, String adminPw);
	
	// company
	Company comLoginCheck(String companyId, String companyPw);
	String comFindId(String companyName, int companyRegno);
	String comFindPw(String companyId, String companyEmail);
	void addCompany(Company company);
	int checkCompany(String companyId);
	void fixCompany(Company company);
	void delCompany(String companyId);
	List<Company> getCompany(String companyId);
	List<Company> getCompanys();
	
	// employee
	Employee loginCheck(String employeeId, String employeePw);
	String findId(String employeeName, String employeePh);
	String findPw(String employeeId, String employeePino);
	int checkEmployeePw(int employeeNo, String employeePw);
	void fixEmployeePw(int employeeNo, String employeePw);
	void addEmployee(Employee employee);
	int checkEmployee(String empId);
	void fixEmployee(Employee employee);
	List<Employee> getEmployee(int employeeNo);
	List<Employee> getEmployees(String companyId);
	List<Employee> getEmployeeInfo(int employeeNo);
	void delEmployee(int employeeNo);
}
