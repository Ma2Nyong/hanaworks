package com.my.attendance.dao.map;

import java.util.List;

import com.my.attendance.domain.Ask;

public interface AskMap {
	List<Ask> selectAsks();
	List<Ask> selectAsk(int askNo);
	int insertAsk(String askTitle, String askName, String askContent);
	int insertAnswer(Ask ask);
	int deleteAsk(int askNo);
}
