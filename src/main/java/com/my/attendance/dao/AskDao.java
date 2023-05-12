package com.my.attendance.dao;

import java.util.List;

import com.my.attendance.domain.Ask;

public interface AskDao {
	List<Ask> selectAsks();
	List<Ask> selectAsk(int askNo);
	void insertAsk(String askTitle, String askName, String askContent);
	void insertAnswer(Ask ask);
	void deleteAsk(int askNo);
}
