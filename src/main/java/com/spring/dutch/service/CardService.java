package com.spring.dutch.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.dutch.domain.CardVO;
import com.spring.dutch.dto.CardPagingCreatorDTO;
import com.spring.dutch.dto.CardPagingDTO;


public interface CardService {
	public CardPagingCreatorDTO showCardList(CardPagingDTO cardpaging);
}
