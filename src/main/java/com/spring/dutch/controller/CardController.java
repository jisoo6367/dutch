package com.spring.dutch.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String showCardList(Model model, String result, CardPagingDTO cardPaging) {
		
		model.addAttribute("listData", cardService.showCardList(cardPaging)) ;
		model.addAttribute("result", result);
		
		System.out.println("controller model: "+ model);
		
		return "/pages/cardlist";
	}
	
	@GetMapping(value = "/register")
	@PreAuthorize("isAuthenticated()")
	public String showCardRegister() {
		return "/pages/cardregister";
	}
	
	@PostMapping(value = "/sendcard")
	@PreAuthorize("isAuthenticated()")
	public String sendCard(CardVO card, RedirectAttributes redirectAttr) {
		
		System.out.println("컨트롤러 cardVO: " + card);
		/* CardAttachFileVO attachFile = card.getAttachFile(); */
		List<CardAttachFileVO> cardAttachFileList = card.getAttachFileList();
		
		if(cardAttachFileList != null) {
			cardAttachFileList.forEach(attachFile -> System.out.println(attachFile.toString())) ;
		}else {
			System.out.println("카드 이미지 없음");
		}
		
		String kno = cardService.registerCard(card);
		
		redirectAttr.addFlashAttribute("result", kno);
		
		return "redirect:/card/list";
	}
	
	@GetMapping("/detail") //카드조회, 수정후 조회
	public String showCardDetail(String kno, Model m,
								 @ModelAttribute("cardPaging") CardPagingDTO cardPaging) {
		System.out.println("카드디테일컨트롤러시작" + kno);
		CardVO card = cardService.getCard(kno);
		System.out.println("컨트롤 card: " + card);
		
		m.addAttribute("card", card);
		
		System.out.println("model: " + m);
		
		return "pages/carddetail";
	}
	
	@GetMapping("/modify")//수정페이지 호출
	@PreAuthorize("isAuthenticated()")
	public String showCardModify(String kno, Model model,
								 CardPagingDTO cardPaging) {
		System.out.println("cardModify 컨트롤러 호출 kno: " + kno);
		CardVO card = cardService.getCardForModify(kno);
		
		model.addAttribute("card", card);
		System.out.println("cardModify 컨트롤러 호출 model: " + model);
		return "pages/cardmodify";
	}
	
	@PostMapping("/modify") //수정
	@PreAuthorize("isAuthenticated()")
	public String modifyCard(CardVO card, RedirectAttributes redirectAttr, CardPagingDTO cardPaging) {
		System.out.println("카드 수정 컨트롤러 시작 card: " + card);
		System.out.println("카드 수정 컨트롤러 시작 cardpaging: " + cardPaging);
		
		boolean modifyResult = cardService.modifyCard(card);
		System.out.println("서비스 갔다 온 결과: " + modifyResult);
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
		
		return "redirect:/card/detail";
	}
	
	@PostMapping("/remove") //특정 카드 삭제
	@PreAuthorize("isAuthenticated()")
	public String removeCard(CardVO card, RedirectAttributes redirectAttr, CardPagingDTO cardPaging) {
		
		System.out.println("jsp에서 받은 값:" + card);
		System.out.println("jsp에서 받은 값:" + cardPaging);
		
		if (cardService.removeCard(card.getKno())) {
			redirectAttr.addFlashAttribute("result","successRemove") ;
			
		} else {
			redirectAttr.addFlashAttribute("result","failRemove") ;
		}	
		
		redirectAttr.addAttribute("pageNum", cardPaging.getPageNum());
		redirectAttr.addAttribute("rowAmountPerPage", cardPaging.getRowAmountPerPage()) ;
		redirectAttr.addAttribute("scope", cardPaging.getScope()) ;
		redirectAttr.addAttribute("keyword", cardPaging.getKeyword()) ;
		
		return "redirect:/card/list";
	}
	
	//특정 게시물의 첨부파일 정보를 JSON으로 전달(특정 게시물의 수정페이지에서 사용)
	@GetMapping(value = "/getFiles" , produces = {"application/json; charset=utf-8"})
	public @ResponseBody ResponseEntity<List<CardAttachFileVO>> showAttachFiles(String kno){
		
		System.out.println("kno" + kno);
		return new ResponseEntity<List<CardAttachFileVO>>(cardService.getAttachFileList(kno), HttpStatus.OK);
	}
	
	@PostMapping(value = "/thumbsUp/{kno}",
				consumes = "application/json;charset=utf-8",
				produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> thumbsUp(@PathVariable("kno") String kno){
		System.out.println("send kno: " + kno);
		
		String result = cardService.thumbsUp(kno) + "";
		
		System.out.println("컨트롤러 result: " + result);
		
		return new ResponseEntity<String>(result, HttpStatus.OK) ;
	}
	
	@PostMapping(value = "/thumbsDown/{kno}",
				consumes = "application/json;charset=utf-8",
				produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> thumbsDown(@PathVariable("kno") String kno){
		System.out.println("send kno: " + kno);
		
		String result = cardService.thumbsDown(kno) + "";
		
		System.out.println("컨트롤러 result: " + result);
		
		return new ResponseEntity<String>(result, HttpStatus.OK) ;
	}
	
	
	
}