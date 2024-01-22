package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.domain.CardAttachFileVO;
import com.spring.dutch.domain.CardVO;
import com.spring.dutch.dto.CardPagingCreatorDTO;
import com.spring.dutch.dto.CardPagingDTO;


public interface CardService {
	public CardPagingCreatorDTO showCardList(CardPagingDTO cardpaging);
	
	public String registerCard(CardVO card);
	
	public CardVO getCard(String kno);//특정게시물 호출
	
	public CardVO getCard2(String kno);//수정페이지 호출
	
	public boolean modifyCard(CardVO card);//카드 수정
	
	public boolean removeCard(String kno);//카드 삭제
	
	public List<CardAttachFileVO> getAttachFileList(String kno);
}
