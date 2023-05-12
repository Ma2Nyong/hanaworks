package com.my.attendance.service;

import java.util.List;

import com.my.attendance.domain.CompanyNotice;
import com.my.attendance.domain.PublicNotice;

public interface NoticeService {
	List<PublicNotice> getPublicNoticeLists();
	List<PublicNotice> getPublicNotice(int publicNoticeNo);
	void addPublicNotice(String publicNoticeTitle, String publicNoticeContent);
	void fixPublicNotice(PublicNotice publicNotice);
	void delPublicNotice(int publicNoticeNo);
	
	List<CompanyNotice> getCompanyNoticeList(String companyId);
	List<CompanyNotice> getCompanyNotice(int companyNoticeNo);
	void addCompanyNotice(String companyNoticeTitle, String companyNoticeContent, String companyId);
	void fixCompanyNotice(CompanyNotice companyNotice);
	void delCompanyNotice(int companyNoticeNo);
}
