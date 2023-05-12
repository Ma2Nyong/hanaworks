package com.my.attendance.dao;

import com.my.attendance.domain.Admin;

public interface AdminDao {
	Admin selectAdmin(String companyId, String companyPw);
}
