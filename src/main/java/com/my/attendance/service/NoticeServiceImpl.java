package com.my.attendance.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.attendance.dao.CompanyNoticeDao;
import com.my.attendance.dao.PublicNoticeDao;
import com.my.attendance.domain.CompanyNotice;
import com.my.attendance.domain.PublicNotice;

@Service
public class NoticeServiceImpl implements NoticeService {
	//PublicNotice
	@Autowired private PublicNoticeDao publicNoticeDao;
	
	@Override
	public List<PublicNotice> getPublicNoticeLists(){
		return publicNoticeDao.selectPublicNoticeLists();
	}
	
	@Override
	public List<PublicNotice> getPublicNotice(int publicNoticeNo) {
		return publicNoticeDao.selectPublicNotice(publicNoticeNo);
	}
	
	@Override
	public void addPublicNotice(String publicNoticeTitle, String publicNoticeContent) {
		publicNoticeDao.insertPublicNotice(publicNoticeTitle, publicNoticeContent);
	}
	
	@Override
	public void fixPublicNotice(PublicNotice publicNotice) {
		publicNoticeDao.updatePublicNotice(publicNotice);
	}
	
	@Override
	public void delPublicNotice(int publicNoticeNo) {
		publicNoticeDao.deletePublicNotice(publicNoticeNo);
	}
	
	//CompanyNotice
	@Autowired private CompanyNoticeDao companyNoticeDao;
	
	@Override
	public List<CompanyNotice> getCompanyNoticeList(String companyId){
		return companyNoticeDao.selectCompanyNoticeList(companyId);
	}
	
	@Override
	public List<CompanyNotice> getCompanyNotice(int companyNoticeNo){
		return companyNoticeDao.selectCompanyNotice(companyNoticeNo);
	}
	
	@Override
	public void addCompanyNotice(String companyNoticeTitle, String companyNoticeContent, String companyId) {
		companyNoticeDao.insertCompanyNotice(companyNoticeTitle, companyNoticeContent, companyId);
	}
	
	@Override
	public void fixCompanyNotice(CompanyNotice companyNotice) {
		companyNoticeDao.updateCompanyNotice(companyNotice);
	}
	
	@Override
	public void delCompanyNotice(int companyNoticeNo) {
		companyNoticeDao.deleteCompanyNotice(companyNoticeNo);
	}
}
