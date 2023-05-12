package com.my.attendance.dao.map;

import java.util.List;

import com.my.attendance.domain.PublicNotice;

public interface PublicNoticeMap {
	List<PublicNotice> selectPublicNoticeLists();
	List<PublicNotice> selectPublicNotice(int publicNoticeNo);
	int insertPublicNotice(String publicNoticeTitle, String publicNoticeContent);
	int updatePublicNotice(PublicNotice publicNotice);
	int deletePublicNotice(int publicNoticeNo);
}
