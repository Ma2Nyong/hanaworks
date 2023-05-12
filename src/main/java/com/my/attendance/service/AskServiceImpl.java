package com.my.attendance.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.attendance.dao.AskDao;
import com.my.attendance.domain.Ask;

@Service
public class AskServiceImpl implements AskService {
	@Autowired private AskDao askDao;
	
	@Override
	public List<Ask> getAsks() {
		return askDao.selectAsks();
	}

	@Override
	public List<Ask> getAsk(int askNo) {
		return askDao.selectAsk(askNo);
	}
	
	@Override
	public void addAsk(String askTitle, String askName, String askContent) {
		askDao.insertAsk(askTitle, askName, askContent);
	}
	
	@Override
	public void addAnswer(Ask ask) {
		askDao.insertAnswer(ask);
	}
	
	@Override
	public void delAsk(int askNo) {
		askDao.deleteAsk(askNo);
	}
}
