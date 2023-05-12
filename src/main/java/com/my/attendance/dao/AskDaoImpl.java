package com.my.attendance.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.attendance.dao.map.AskMap;
import com.my.attendance.domain.Ask;

@Repository
public class AskDaoImpl implements AskDao {
	@Autowired private AskMap askMap;
	
	@Override
	public List<Ask> selectAsks() {
		return askMap.selectAsks();
	}
	@Override
	public List<Ask> selectAsk(int askNo) {
		return askMap.selectAsk(askNo);
	}
	
	@Override
	public void insertAsk(String askTitle, String askName, String askContent) {
		askMap.insertAsk(askTitle, askName, askContent);
	}
	
	@Override
	public void insertAnswer(Ask ask) {
		askMap.insertAnswer(ask);
	}
	
	@Override
	public void deleteAsk(int askNo) {
		askMap.deleteAsk(askNo);
	}
}
