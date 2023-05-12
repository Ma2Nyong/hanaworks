package com.my.attendance.dao;

import java.util.List;

import com.my.attendance.domain.Company;

public interface CompanyDao {
	Company selectCompany(String companyId, String companyPw);
	String selectCompanyId(String companyName, int companyRegno);
	String selectCompanyPw(String companyId, String companyEmail);
	int insertCompany(Company company);
	int checkCompany(String companyId);
	void updateCompany(Company company);
	void deleteCompany(String companyId);
	List<Company> choiceCompany(String companyId);
	List<Company> selectCompanys();
}
