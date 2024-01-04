package com.spring.dutch.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.dto.DutchBoardPagingCreatorDTO;
import com.spring.dutch.dto.DutchBoardPagingDTO;
import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.service.DutchBoardService;

@Controller
@RequestMapping("/pages")
public class DutchBoardController {

	  private DutchBoardService dutchBoardService ;

	  public DutchBoardController(DutchBoardService dutchBoardService) {
	  this.dutchBoardService = dutchBoardService ;
	  System.out.println("DutchBoardController의 모든 필드 초기화 생성자 입니다."); 

	  }


	//더치페이 목록 조회
	@GetMapping("/dutchlist") 
	public String showBoardList(DutchBoardPagingDTO dutchboardPaging, Model model) { 
	    System.out.println("dutchboardPagingDTO" + dutchboardPaging); 

	    DutchBoardPagingCreatorDTO pagingCreator = dutchBoardService.getDutchList(dutchboardPaging);
	    //System.out.println("컨트롤러에 저장된 DutchboardPagingCreator \n" + pagingCreator);  

	  model.addAttribute("pagingCreator", pagingCreator);

	  return "pages/dutchlist"; 
	}

	//더치페이 게시물 페이지 호출
	@GetMapping("/dutchregister")
	public String showBoardRegisterPage() {
		System.out.println("등록페이지 호출..........");

		return "/pages/dutchregister";
	}

	//더치페이 등록 처리
	@PostMapping("/dutchregister")
	public String registerNewBoard(DutchBoardVO dutchBoard, RedirectAttributes redirectAttr) {

		long pno = dutchBoardService.DutchregisterBoard(dutchBoard);

		redirectAttr.addFlashAttribute("result", pno);
		System.out.println("result: " + redirectAttr.getFlashAttributes());

		return "redirect:/pages/dutchlist" ;

	}

	//특정 더치페이 게시물 조회 페이지 or 수정 후 조회 페이지
	@GetMapping("/dutchdetail")
	public String showDutchBoardDetail(Long pno, Model model,
			                           @ModelAttribute("dutchboardPaging") 
	                                   DutchBoardPagingDTO dutchboardPaging) {

		DutchBoardVO dutchboard = null ;

		dutchboard = dutchBoardService.getDutchBoard(pno);

		model.addAttribute("dutchboard", dutchboard);

		System.out.println("model: " + model);

		return "/pages/dutchdetail";
	}





}
