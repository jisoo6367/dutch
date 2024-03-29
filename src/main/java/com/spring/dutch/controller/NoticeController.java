package com.spring.dutch.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.domain.NoticeVO;
import com.spring.dutch.dto.NoticePagingCreatorDTO;
import com.spring.dutch.dto.NoticePagingDTO;
import com.spring.dutch.service.NoticeService;

import lombok.Setter;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	private NoticeService noticeService;
	
	public NoticeController(NoticeService noticeService) {
		this.noticeService = noticeService;
	}
	

	
	@GetMapping("/list")
	public String showNoticeList(NoticePagingDTO noticePaging ,Model model) {
		
		System.out.println("noticePaging: " + noticePaging);
		NoticePagingCreatorDTO noticeCreator = noticeService.getNoticeList(noticePaging);
		System.out.println("컨트롤러에 전달된 noticeCreator: \n" + noticeCreator);
		
		model.addAttribute("noticeCreator", noticeCreator);
		
		return "pages/noticelist";
	}
	
	//등록페이지 호출
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String showNoticeRegisterPage(Principal principal,Model model) {
		model.addAttribute("nickname", principal.getName());
		return "pages/noticeregister";
	}
	
	//게시물 등록 처리
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String registerNotice(NoticeVO notice, 
								 RedirectAttributes redirectAttr) {
		
		Long cno = noticeService.registerNotice(notice);
		
		redirectAttr.addFlashAttribute("result", cno);
		
		return "redirect:/notice/list";
	}

	
	//특정 게시물 조회, 수정 후 조회
	@GetMapping(value = "/detail")
	public String showNoticeDetail(Long cno, Model model, String result,
								   @ModelAttribute("noticePaging") 
								   NoticePagingDTO noticePaging
								   ) {
//		NoticeVO notice = noticeService.getNotice(cno, result);
		NoticeVO notice = null;
//		System.out.println("result: " + result);
//		
//		if (result == null) {//목록페이지에서 조회요청
//			notice = noticeService.getNotice(cno) ;	
//		
//		} else if (result != null) {//수정 후 조회 요청
//			notice = noticeService.getNotice2(cno) ;	
//		}
		
		notice = noticeService.getNotice(cno);
		
		model.addAttribute("notice", notice);
		model.addAttribute("result", result);
		
//		System.out.println("model: " + model);
		
		return "/pages/noticedetail";
	}
	
	//특정 게시물 수정삭제 페이지 호출
	@GetMapping(value ="/modify")
	@PreAuthorize("isAuthenticated()")
	public String showNoticeModify(Long cno, String nickname, Model model, 
								   NoticePagingDTO noticePaging) {
		
		NoticeVO notice = noticeService.getNotice2(cno);
		
		model.addAttribute("notice", notice);
		
		return "/pages/noticemodify";
	}
	
	//특정 게시물 수정
	@PostMapping("/modify")
	@PreAuthorize("isAuthenticated()")
	public String modifyNotice(NoticeVO notice,
							   RedirectAttributes redirectAttr,
							   NoticePagingDTO noticePaging) {
		
		boolean noticeResult = noticeService.modifyNotice(notice);
		
		if(noticeResult) {
			redirectAttr.addAttribute("result", "successModify");
		
		}else {
			redirectAttr.addAttribute("result", "failModify");
			
		}
				
		redirectAttr.addAttribute("cno", notice.getCno());
		redirectAttr.addAttribute("pageNum", noticePaging.getPageNum());
		redirectAttr.addAttribute("rowAmountPerPage", noticePaging.getRowAmountPerPage());
		//redirectAttr.addAttribute("scope", noticePaging.getScope());
		redirectAttr.addAttribute("keyword", noticePaging.getKeyword());
		
		return "redirect:/notice/detail";
	}		
	
	//특정 게시물 삭제
	@PostMapping("/remove")
	@PreAuthorize("isAuthenticated()")
	public String removeNotice(NoticeVO notice, Long cno,
							   RedirectAttributes redirectAttr,
							   NoticePagingDTO noticePaging) {
		noticeService.removeNotice(cno);
		
		
		redirectAttr.addAttribute("pageNum", noticePaging.getPageNum()) ;
		redirectAttr.addAttribute("rowAmountPerPage", noticePaging.getRowAmountPerPage()) ;
		redirectAttr.addAttribute("keyword", noticePaging.getKeyword()) ;
		
		return "redirect:/notice/list";
	}
	
	
}