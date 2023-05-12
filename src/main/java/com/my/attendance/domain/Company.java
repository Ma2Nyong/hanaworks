package com.my.attendance.domain;

import lombok.Data;

@Data
public class Company {
	private String companyId;
	private String comPw;
	private String comName;
	private long comRegno;
	private String comAddr;
	private String comDetailAddr;
	private int comPostcode;
	private String comPh;
	private String comEmail;
	private String president;	
}
