package com.my.attendance.domain;

import java.time.LocalDate;

import lombok.Data;

@Data
public class Ask {
	private int askNo;
	private String askTitle;
	private String askName;
	private String askContent;
	private String answerContent;
	private LocalDate askDate;
	private LocalDate answerDate;
}
