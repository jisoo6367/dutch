package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.domain.CardVO;
import com.spring.dutch.dto.CardPagingDTO;

public interface CardMapper {
	public List<CardVO> selectList(CardPagingDTO cardPaging);
	
	public long selectRows(CardPagingDTO cardPaging);
	
	public int insertCard(CardVO card);
}
