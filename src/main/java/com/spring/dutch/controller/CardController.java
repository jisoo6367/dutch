package com.spring.dutch.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.domain.CardAttachFileVO;
import com.spring.dutch.domain.CardVO;
import com.spring.dutch.dto.CardPagingDTO;
import com.spring.dutch.service.CardService;

@Controller
@RequestMapping("/card")
public class CardController {
	
	private CardService cardService;
	
	public CardController(CardService cardService) {
		this.cardService = cardService;
	}
	
	@GetMapping(value="/list")
	public String showCardList(Model model, CardPagingDTO cardPaging) {
		
		model.addAttribute("listData", cardService.showCardList(cardPaging)) ;
		
		return "/pages/cardlist";
	}
	
	@GetMapping(value = "/register")
	public String showCardRegister() {
		return "/pages/cardregister";
	}
	
	@PostMapping(value = "/sendcard")
	public String sendCard(CardVO card, RedirectAttributes redirectAttr) {
		
		System.out.println(card);
		/* CardAttachFileVO attachFile = card.getAttachFile(); */
		List<CardAttachFileVO> cardAttachFileList = card.getAttachFileList();
		
		if(cardAttachFileList != null) {
			cardAttachFileList.forEach(attachFile -> System.out.println(attachFile.toString())) ;
		}else {
			System.out.println("카드 이미지 없음");
		}
		
		String kno = cardService.registerCard(card);
		
		redirectAttr.addFlashAttribute("kno", kno);
		
		return "redirect:/card/list";
	}
	
	@GetMapping("/detail") //카드조회
	public String showCardDetail(String kno, Model m,
								 @ModelAttribute("cardPaging") CardPagingDTO cardPaging) {
		
		CardVO card = cardService.getCard(kno);
		System.out.println("컨트롤 card: " + card);
		
		m.addAttribute("card", card);
		
		System.out.println("model: " + m);
		
		return "pages/carddetail";
	}
	
	@GetMapping("/modify")//수정페이지 호출
	public String showCardModify(String kno, Model model,
								 CardPagingDTO cardPaging) {
		
		CardVO card = cardService.getCard2(kno);
		
		model.addAttribute("card: " + card);
		
		return "/pages/cardmodify";
	}
	
	@PostMapping("/modify") //수정
	public String modifyCard(CardVO card, RedirectAttributes redirectAttr, CardPagingDTO cardPaging) {
		
		boolean modifyResult = cardService.modifyCard(card);
		
		if(modifyResult) {
			redirectAttr.addAttribute("result", "successModify") ;
		}else {
			redirectAttr.addAttribute("result", "failModify") ;
		}
		
		redirectAttr.addAttribute("kno", card.getKno()) ;
		redirectAttr.addAttribute("pageNum", cardPaging.getPageNum());
		redirectAttr.addAttribute("rowAmountPerPage", cardPaging.getRowAmountPerPage()) ;
		redirectAttr.addAttribute("scope", cardPaging.getScope()) ;
		redirectAttr.addAttribute("keyword", cardPaging.getKeyword()) ;
		
		return "redirect:/carddetail";
	}
	
	@PostMapping("/remove") //특정 카드 삭제
	public String removeCard(CardVO card, RedirectAttributes redirectAttr, CardPagingDTO cardPaging) {
		
		if (cardService.removeCard(card.getKno())) {
			redirectAttr.addFlashAttribute("result","successRemove") ;
			
		} else {
			redirectAttr.addFlashAttribute("result","failRemove") ;
		}	
		
		redirectAttr.addAttribute("kno", card.getKno()) ;
		redirectAttr.addAttribute("pageNum", cardPaging.getPageNum());
		redirectAttr.addAttribute("rowAmountPerPage", cardPaging.getRowAmountPerPage()) ;
		redirectAttr.addAttribute("scope", cardPaging.getScope()) ;
		redirectAttr.addAttribute("keyword", cardPaging.getKeyword()) ;
		
		return "redirect:/pages/cardlist";
	}
	
	@GetMapping(value = "/getFiles" , produces = {"application/json; charset=utf-8"})
	public @ResponseBody ResponseEntity<List<CardAttachFileVO>> showAttachFiles(String kno){
		return new ResponseEntity<List<CardAttachFileVO>>(cardService.getAttachFileList(kno), HttpStatus.OK);
	}
	
	
	
	
}
