package com.my.attendance.dao.map;

import java.util.List;

import com.my.attendance.domain.Company;

public interface CompanyMap {
	Company selectCompany(String companyId, String companyPw);
	String selectCompanyId(String companyName, int companyRegno);
	String selectCompanyPw(String companyId, String companyEmail);
	int insertCompany(Company company);
	int checkCompany(String companyId);
	int updateCompany(Company company);
	int deleteCompany(String companyId);
	List<Company> choiceCompany(String companyId);
	List<Company> selectCompanys();
}
