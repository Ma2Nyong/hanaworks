package com.my.attendance.dao.map;

import java.util.List;

import com.my.attendance.domain.Employee;

public interface EmployeeMap {
	Employee selectEmployee(String employeeId, String employeePw);
	String selectEmployeeId(String employeeName, String employeePh);
	String selectEmployeePw(String employeeId, String employeePino);
	int checkEmployeePw(int employeeNo, String employeePw);
	void updateEmployeePw(int employeeNo, String employeePw);
	int insertEmployee(Employee employee);
	int checkEmployee(String empId);
	void updateEmployee(Employee employee);
	List<Employee> choiceEmployee(int employeeNo);
	List<Employee> selectEmployees(String companyId);
	List<Employee> selectEmployeeInfo(int employeeNo);
	int deleteEmployee(int employeeNo);
}
