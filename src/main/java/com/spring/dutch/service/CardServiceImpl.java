package com.spring.dutch.service;

import java.util.List;
import java.util.UUID;

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

	@Override
	public String registerCard(CardVO card) {
		
		card.setKno(UUID.randomUUID().toString());
		
		cardMapper.insertCard(card);
		
		
		return card.getKno();
	}
	
	
	
}
