package com.my.attendance.dao.map;

import com.my.attendance.domain.Admin;

public interface AdminMap {
	Admin selectAdmin(String adminId, String adminPw);
}
