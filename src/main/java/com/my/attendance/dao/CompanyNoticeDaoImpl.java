package com.my.attendance.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.attendance.dao.map.CompanyNoticeMap;
import com.my.attendance.domain.CompanyNotice;

@Repository
public class CompanyNoticeDaoImpl implements CompanyNoticeDao {
	@Autowired private CompanyNoticeMap companyNoticeMap;
	
	@Override
	public List<CompanyNotice> selectCompanyNoticeList(String companyId){
		return companyNoticeMap.selectCompanyNoticeList(companyId);
	}
	
	@Override
	public List<CompanyNotice> selectCompanyNotice(int companyNoticeNo){
		return companyNoticeMap.selectCompanyNotice(companyNoticeNo);
	}
	
	@Override
	public void insertCompanyNotice(String companyNoticeTitle, String companyNoticeContent, String companyId) {
		companyNoticeMap.insertCompanyNotice(companyNoticeTitle, companyNoticeContent, companyId);
	}
	
	@Override
	public void updateCompanyNotice(CompanyNotice companyNotice) {
		companyNoticeMap.updateCompanyNotice(companyNotice);
	}
	
	@Override
	public void deleteCompanyNotice(int companyNoticeNo) {
		companyNoticeMap.deleteCompanyNotice(companyNoticeNo);
	}
}
