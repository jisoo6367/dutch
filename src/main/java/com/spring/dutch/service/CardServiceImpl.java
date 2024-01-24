package com.spring.dutch.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dutch.domain.CardAttachFileVO;
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
		System.out.println(card);
		cardMapper.insertCard(card);
		
		List<CardAttachFileVO> attachFileList = card.getAttachFileList();
		if(attachFileList != null && attachFileList.size() > 0) {
			
			attachFileList.forEach(cardAttachFile -> {
				cardAttachFile.setUuid(UUID.randomUUID().toString());
				cardAttachFile.setKno(card.getKno());
				cardMapper.insertAttachFile(cardAttachFile);
			});
			
		}
		
		
		return card.getKno();
	}
	
	@Override //특정카드조회
	public CardVO getCard(String kno) {
		
		CardVO card = cardMapper.selectCard(kno);
		card.setAttachFileList(cardMapper.selectAttachFiles(kno));
		
		System.out.println("card====: " + card);
		
		return card;
	}
	
	@Override //수정페이지
	public CardVO getCard2(String kno) {
		CardVO card = cardMapper.selectCard2(kno);
		
		return card;
	}
	
	@Override //수정
	@Transactional
	public boolean modifyCard(CardVO card) {

		String kno = card.getKno();
		
		boolean cardModifyResult = (cardMapper.updateCard(card) == 1);
		
		cardMapper.deleteAttachFiles(kno);
		
		List<CardAttachFileVO> attachFileList = card.getAttachFileList();
		
		if (cardModifyResult && attachFileList != null) {
			for(CardAttachFileVO attachFile : attachFileList) {
				attachFile.setKno(kno);
				cardMapper.insertAttachFile(attachFile); 	
			}
			
		}
		
		return cardModifyResult;
	}
	
	@Override //실 삭제
	@Transactional
	public boolean removeCard(String kno) {

		List<CardAttachFileVO> attachFileList = getAttachFileList(kno);
		
		int attachFileDeleteRows = cardMapper.deleteAttachFiles(kno);
		
		removeAttachFiles(attachFileList);
		
		int rows = cardMapper.deleteCard(kno);
		
		return (rows == 1);
	}
	
	@Override
	public List<CardAttachFileVO> getAttachFileList(String kno) {
		
		return cardMapper.selectAttachFiles(kno);
	}
	
	private void removeAttachFiles(List<CardAttachFileVO> attachFileList) {
		
		if(attachFileList == null || attachFileList.size() == 0) {
			return ;
		}
		
		System.out.println("삭제파일====" + attachFileList.toString());
		
		for(CardAttachFileVO attachFile : attachFileList) {
			Path filePath = Paths.get(attachFile.getRepoPath() ,
									  attachFile.getUploadPath() ,
									  attachFile.getUuid() + "_" + attachFile.getFileName() );
			
			boolean deleteFileResult = false ; 
			
			try {
				deleteFileResult = Files.deleteIfExists(filePath);
				
				Path thumnail = Paths.get(attachFile.getRepoPath() ,
										  attachFile.getUploadPath() ,
										  "s_" + attachFile.getUuid() + "_" + attachFile.getFileName() );

				deleteFileResult = Files.deleteIfExists(thumnail);	
				
			} catch (IOException e) {
				
				e.printStackTrace();
			}
		}
	}
}
