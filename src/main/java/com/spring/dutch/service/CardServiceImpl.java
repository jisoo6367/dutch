package com.spring.dutch.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.dutch.domain.CardVO;
import com.spring.dutch.dto.CardPagingCreatorDTO;
import com.spring.dutch.dto.CardPagingDTO;
import com.spring.dutch.mapper.CardMapper;

@Service
public class CardServiceImpl implements CardService{
	
	private CardMapper cardMapper;
	
	public CardServiceImpl(CardMapper cardMapper) {
		this.cardMapper = cardMapper;
	}

	@Override
	public CardPagingCreatorDTO showCardList(CardPagingDTO cardPaging) {
		
		return new CardPagingCreatorDTO(cardMapper.selectRows(cardPaging), 
									cardPaging, cardMapper.selectList(cardPaging));
	}
	
}
