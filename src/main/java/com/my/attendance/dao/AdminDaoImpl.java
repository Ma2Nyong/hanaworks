package com.my.attendance.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.attendance.dao.map.AdminMap;
import com.my.attendance.domain.Admin;

@Repository
public class AdminDaoImpl implements AdminDao {
	@Autowired private AdminMap adminMap;
	
	@Override
	public Admin selectAdmin(String adminId, String adminPw) {
		return adminMap.selectAdmin(adminId, adminPw);
	}
}
