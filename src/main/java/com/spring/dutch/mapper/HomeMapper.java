package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.domain.CardVO;
import com.spring.dutch.domain.CommunityVO;
import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.NoticeVO;

public interface HomeMapper {
	public List<NoticeVO> selectNoti();
	public List<DutchBoardVO> selectDutch();
	public List<CommunityVO> selectCommu();
	public List<CardVO> selectCard();
}
