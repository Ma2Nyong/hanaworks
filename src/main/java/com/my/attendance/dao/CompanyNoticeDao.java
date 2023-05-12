package com.my.attendance.dao;

import java.util.List;

import com.my.attendance.domain.CompanyNotice;

public interface CompanyNoticeDao {
	List<CompanyNotice> selectCompanyNoticeList(String companyId);
	List<CompanyNotice> selectCompanyNotice(int companyNoticeNo);
	void insertCompanyNotice(String companyNoticeTitle, String companyNoticeContent, String companyId);
	void updateCompanyNotice(CompanyNotice companyNotice);
	void deleteCompanyNotice(int companyNoticeNo);
}
