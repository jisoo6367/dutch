package com.spring.dutch.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.domain.AttachFileVO;
import com.spring.dutch.domain.QnaVO;
import com.spring.dutch.dto.QnaPagingCreatorDTO;
import com.spring.dutch.dto.QnaPagingDTO;
import com.spring.dutch.mapper.AttachFileMapper;
import com.spring.dutch.service.QnaService;

@Controller
@RequestMapping("/qna")
public class QnaController {
	
	private QnaService qnaService;
	
	//단일 생성자를 이용한 주입
	public QnaController(QnaService qnaService) {
		this.qnaService = qnaService;
	}
	
	//목록조회
//	@GetMapping("/qnalist")
//	public String ShowQnaList(Model model) {
//		
//		List<QnaVO> qnaCreator = qnaService.getQnaList();
//		
//		model.addAttribute("qnaCreator", qnaCreator);
//		
//		return "pages/qnalist" ;
//	}
	
	@GetMapping("/qnalist")
	public String showQnaList(QnaPagingDTO qnaPaging, Model model) {
		
		System.out.println("qnaPaging: " + qnaPaging);
		QnaPagingCreatorDTO qnaCreator = qnaService.getQnaList(qnaPaging);
		System.out.println("컨트롤러에 전달된 qnaCreator: \n" + qnaCreator);
		
		model.addAttribute("qnaCreator", qnaCreator);
		
		return "pages/qnalist" ;
	}
	
	//등록페이지 호출
	@GetMapping("/qnaregister")
//	@PreAuthorize("isAuthenticated()")
	public String showQnaRegisterPage() {
		
		return "pages/qnaregister";
	}
	
	//게시물등록 처리
	@PostMapping("/qnaregister")
//	@PreAuthorize("isAuthenticated()")
	public String registerQna(QnaVO qna, 
							  RedirectAttributes redirectAttr) {
		
		List<AttachFileVO> attachFileList = qna.getAttachFileList();
		
		if(attachFileList != null) {
			attachFileList.forEach(attachFile-> System.out.println(attachFile.toString()));
		
		}else {
			System.out.println("첨부파일 없음");
		}
		
		long qno = qnaService.registerQna(qna);
		
		redirectAttr.addFlashAttribute("result", qno);
		
		return "redirect:/pages/qnalist";
		
	}
	
	//특정 게시물 조회 + 수정 후 조회
	@GetMapping("/qnadetail")
	public String showQnaDetail(Long qno, Model model, String result,
								@ModelAttribute("qnaPaging") QnaPagingDTO qnaPaging) {
		
		QnaVO qna = null;
		
		qna = qnaService.getQna(qno);
		
		model.addAttribute("qna", qna);
		model.addAttribute("result", result);
		
		return "pages/qnadetail";
	}
	
	//특정 게시물 수정삭제 페이지 호출
	@GetMapping("/qnamodify")
//	@PreAuthorize("isAuthenticated() && principal.username == #nickname")
	public String showQnaModify(Long qno, String nickname, Model model,
								QnaPagingDTO qnaPaging) {
		
		QnaVO qna = qnaService.getQna2(qno);
		
		model.addAttribute("qna", qna);
		
		return "pages/qnamodify";
	}
	
	//특정 게시물 수정
	@PostMapping("/qnamodify")
	public String modifyQna(QnaVO qna,
							RedirectAttributes redirectAttr,
							QnaPagingDTO qnaPaging) {
		
		boolean qnaResult = qnaService.modifyQna(qna);
		
		if(qnaResult) {
			redirectAttr.addAttribute("result", "successModify");
		
		}else {
			redirectAttr.addAttribute("result", "failModify");
		}
		
		redirectAttr.addAttribute("qno", qna.getQno());
		redirectAttr.addAttribute("pageNum", qnaPaging.getPageNum());
		redirectAttr.addAttribute("rowAmountPerPage", qnaPaging.getRowAmountPerPage());
		
		return "redirect:/pages/qnadetail";
	}
	
	//특정 게시물 삭제 
	@PostMapping("/qnaremove")
	//@PreAuthorize("isAuthenticated() && principal.username == #qna.nickname")
	public String removeQna(QnaVO qna, Long qno,
							RedirectAttributes redirectAttr,
							QnaPagingDTO qnaPaging) {
		
		if(qnaService.modifyQdelFlagAdmin(qna.getQno())) {
//		if(qnaService.removeQna(qno)) {
			
			redirectAttr.addFlashAttribute("result", "successRemove");
		}else {
			
			redirectAttr.addFlashAttribute("result", "failRemove");
		}
		
		redirectAttr.addAttribute("pageNum", qnaPaging.getPageNum()) ;
		redirectAttr.addAttribute("rowAmountPerPage", qnaPaging.getRowAmountPerPage()) ;
		
		return "redirect:/pages/qnalist";
		
	}		
	
	//특정 게시물의 첨부파일 정보를 JSON으로 전달(특정 게시물의 수정페이지에서 사용)
	@GetMapping(value = "/getFiles" , produces = {"application/json; charset=utf-8"})
	public @ResponseBody ResponseEntity<List<AttachFileVO>> showAttachFiles(
																			Long qno 
//																			String nickname
																			) {
		System.out.println("qno: " + qno);
		return new ResponseEntity<List<AttachFileVO>>(qnaService.getQnaAttachFileList(qno), HttpStatus.OK);
	}
	
}