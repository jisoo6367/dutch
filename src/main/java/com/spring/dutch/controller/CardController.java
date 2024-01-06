package com.spring.dutch.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.spring.dutch.domain.CardVO;
import com.spring.dutch.dto.CardPagingCreatorDTO;
import com.spring.dutch.dto.CardPagingDTO;
import com.spring.dutch.service.CardService;

import lombok.Getter;

@Controller
public class CardController {
	
	private CardService cardService;
	
	public CardController(CardService cardService) {
		this.cardService = cardService;
	}
	
	@GetMapping(value="/card")
	public String showCardList(Model model, CardPagingDTO cardPaging) {
		
		model.addAttribute("listData", cardService.showCardList(cardPaging)) ;
		
		return "/pages/cardlist";
	}
	
	@GetMapping(value = "/cardregister")
	public String showCardRegister() {
		return "/pages/cardregisterpage";
	}
	
	@PostMapping(value = "/sendcard")
	public String sendCard(CardVO card) {
		
		cardService.registerCard(card);
		
		
		return "redirect:/card";
	}
	
}
