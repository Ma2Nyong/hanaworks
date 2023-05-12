package com.my.attendance.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.attendance.dao.map.CompanyMap;
import com.my.attendance.domain.Company;

@Repository
public class CompanyDaoImpl implements CompanyDao {
	@Autowired private CompanyMap companyMap;
	
	@Override
	public Company selectCompany(String companyId, String companyPw) {
		return companyMap.selectCompany(companyId, companyPw);
	}
	
	@Override
	public String selectCompanyId(String companyName, int companyRegno) {
		return companyMap.selectCompanyId(companyName, companyRegno);
	}
	
	@Override
	public String selectCompanyPw(String companyId, String companyEmail) {
		return companyMap.selectCompanyPw(companyId, companyEmail);
	}
	
	@Override
	public int insertCompany(Company company) {
		return companyMap.insertCompany(company);
	}
	
	@Override
    public int checkCompany(String companyId) {
        return companyMap.checkCompany(companyId);
    }
	
	@Override
	public void updateCompany(Company company) {
		companyMap.updateCompany(company);
	}
	
	@Override
	public void deleteCompany(String companyId) {
		companyMap.deleteCompany(companyId);
	}
	
	@Override
	public List<Company> selectCompanys() {
		return companyMap.selectCompanys();
	}
	
	@Override
	public List<Company> choiceCompany(String companyId) {
		return companyMap.choiceCompany(companyId);
	}
}
