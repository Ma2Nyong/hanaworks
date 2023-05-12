package com.my.attendance.service;

import java.util.List;

import com.my.attendance.domain.Ask;

public interface AskService {
	List<Ask> getAsks();
	List<Ask> getAsk(int askNo);
	void addAsk(String askTitle, String askName, String askContent);
	void addAnswer(Ask ask);
	void delAsk(int askNo);
}
