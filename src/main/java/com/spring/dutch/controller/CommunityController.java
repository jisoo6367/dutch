package com.spring.dutch.controller;

import java.security.Principal;
import java.util.List;
import java.util.logging.Logger;

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

import com.spring.dutch.domain.CommunityAttachFileVO;
import com.spring.dutch.domain.CommunityVO;
import com.spring.dutch.dto.CommunityPagingCreatorDTO;
import com.spring.dutch.dto.CommunityPagingDTO;
import com.spring.dutch.service.CommunityService;

@Controller
@RequestMapping(value="/community")
public class CommunityController {

	//기본생성자 , service의 빈이 주입되도록 지정
	private CommunityService communityService;

	public CommunityController(CommunityService CommunityService) {
		this.communityService = CommunityService;
		
	}
	
	    //목록 조회
		@GetMapping(value="/list")
		public String showCommunityList(Model model, CommunityPagingDTO communityPaging ){					
			CommunityPagingCreatorDTO pagingCreator =  communityService.showCommunityList(communityPaging);
			
			model.addAttribute("pagingCreator", pagingCreator) ;
			
			return "/pages/communitylist" ;
		}
	
		//등록 페이지 호출
		@GetMapping("/register")
		@PreAuthorize("isAuthenticated()")
		public String showCommunityRegisterPage() {
			
			return "pages/communityregister" ;
		}	
		
//		//등록 처리	

		@PreAuthorize("isAuthenticated()")
		@PostMapping("/register")
		public String registerNewBoard(CommunityVO community,Principal principal,
				                       RedirectAttributes redirectAttr) {
			
			community.setNickname(principal.getName());
			
			List<CommunityAttachFileVO> myAttachFileList = community.getAttachFileList() ;
			
			if(myAttachFileList != null) {
				myAttachFileList
					   .forEach(attachFile -> System.out.println(attachFile.toString())) ;
			} else {
				System.out.println("<<<<<<<<<<<<<<<<<<< 첨부파일 없음 >>>>>>>>>>>>>>>>>>>>>");
			}
			System.out.println();
			
			
			long tno = communityService.registerCommunity(community) ;
								
			redirectAttr.addFlashAttribute("result", tno) ;
			
			return "redirect:/community/list";
			
		}
//		
//		//특정 게시물 조회-수정 페이지 호출
		@GetMapping("/detail")
		@PreAuthorize("isAuthenticated()")
		public String ShowCommunityDetail(Long tno, Model model, String result,
										  @ModelAttribute("communityPaging") CommunityPagingDTO communityPaging) {
						
			CommunityVO community =null;
			
			community = communityService.getCommunity1(tno, result);
			
			System.out.println("communityVO     ===" + community);
			
			model.addAttribute("community", community);
			model.addAttribute("result", result);
			
			
			
			return "pages/communitydetail";
		}
		
		//특정 게시물 수정삭제 페이지 호출
		@GetMapping("/modify")
		@PreAuthorize("isAuthenticated()")
		public String showCommunityModify(Long tno, Model model, 
										  CommunityPagingDTO communityPaging ) {
		
			
			CommunityVO community = communityService.getCommunity2(tno);
		
			model.addAttribute("community", community) ;
				
			return "pages/communitymodify" ;
		}
		
//		특정 게시물 수정
		@PostMapping("/modify")
		@PreAuthorize("isAuthenticated()")
		public String modifyCommunity(CommunityVO community,
							      RedirectAttributes redirectAttr,
							      CommunityPagingDTO communityPaging) {
			
			boolean modifyResult = communityService.modifyCommunity(community) ;
			
			if(modifyResult) {
				redirectAttr.addAttribute("result", "successModify") ;
				
			} else {
				redirectAttr.addAttribute("result", "failModify") ;
			}
			
			redirectAttr.addAttribute("tno", community.getTno()) ;
			redirectAttr.addAttribute("pageNum", communityPaging.getPageNum());
			redirectAttr.addAttribute("rowAmountPerPage", communityPaging.getRowAmountPerPage()) ;
			redirectAttr.addAttribute("scope", communityPaging.getScope()) ;
			redirectAttr.addAttribute("keyword", communityPaging.getKeyword()) ;
			redirectAttr.addAttribute("beginDate", communityPaging.getBeginDate()) ;
			redirectAttr.addAttribute("endDate", communityPaging.getEndDate()) ;
			
			return "redirect:/community/detail" ;
		}
		
//		특정 게시물 삭제 POST 
		@PostMapping("/remove")
		@PreAuthorize("isAuthenticated()")
		public String removeBoard(CommunityVO community,  
								  RedirectAttributes redirectAttr,
								  CommunityPagingDTO communityPaging) {
			
			if (communityService.modifyTdelFlag(community.getTno())) { 
				redirectAttr.addFlashAttribute("result","successRemove") ;
				
			} else {
				redirectAttr.addFlashAttribute("result","failRemove") ;
			}
			
			redirectAttr.addAttribute("pageNum", communityPaging.getPageNum()) ;
			redirectAttr.addAttribute("rowAmountPerPage", communityPaging.getRowAmountPerPage()) ;
			redirectAttr.addAttribute("scope", communityPaging.getScope()) ;
			redirectAttr.addAttribute("keyword", communityPaging.getKeyword()) ;
			redirectAttr.addAttribute("beginDate", communityPaging.getBeginDate()) ;
			redirectAttr.addAttribute("endDate", communityPaging.getEndDate()) ;
			
			return "redirect:/community/list" ;
		}
		
		//특정 게시물의 첨부파일 정보를 JSON으로 전달(특정 게시물의 수정페이지에서 사용) 
		@GetMapping(value = "/getFiles" , produces = {"application/json; charset=utf-8"})
		public @ResponseBody ResponseEntity<List<CommunityAttachFileVO>> showAttachFiles(Long tno) {
			return new ResponseEntity<List<CommunityAttachFileVO>>(communityService.getAttachFileList(tno), HttpStatus.OK);
		}
	
		
		
		
	    //신고 받은 리스트만 조회
		@GetMapping(value="/reportedList")
		public String showCommunityReportList(Model model, CommunityPagingDTO communityPaging ){		

			CommunityPagingCreatorDTO pagingCreator =  communityService.showCommunityList(communityPaging);
			
			model.addAttribute("pagingCreator", pagingCreator) ;
			
			return "/pages/communityReportList" ;
		}
		
		
		
		
		
		
		
		
}
