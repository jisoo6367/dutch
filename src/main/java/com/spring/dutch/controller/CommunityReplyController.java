package com.spring.dutch.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.dutch.domain.CommunityReplyVO;
import com.spring.dutch.dto.CommunityReplyPagingCreatorDTO;
import com.spring.dutch.dto.CommunityReplyPagingDTO;
import com.spring.dutch.service.CommunityReplyService;

@RestController
@RequestMapping(value={"/replies", "/myreplies"})
public class CommunityReplyController {

	private CommunityReplyService communityReplyService;
	
	public CommunityReplyController(CommunityReplyService communityReplyService) {
		this.communityReplyService =communityReplyService;
	}
	
	@GetMapping( value="/{tno}/page/{pageNum}" ,
		     produces = {"application/json;charset=utf-8" , 
		    			 "application/xml;charset=utf-8"  })			 
	public ResponseEntity<CommunityReplyPagingCreatorDTO>
			showReplyList(  @PathVariable("tno") long tno,
							@PathVariable("pageNum") Integer pageNum ){
		
		CommunityReplyPagingCreatorDTO communityReplyPagingCreator =
				communityReplyService.getReplyList(new CommunityReplyPagingDTO(tno, pageNum));
		
		ResponseEntity<CommunityReplyPagingCreatorDTO> myResponseEntity =
				new ResponseEntity<CommunityReplyPagingCreatorDTO>(communityReplyPagingCreator, HttpStatus.OK);
						
		return myResponseEntity;
		
		
	}
	
	
	//게시물에 대한 댓글 등록(rno 반환) POST 		/replies/{bno}/new
		@PostMapping(value = "/{tno}/new" , 
					 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
					 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
		@PreAuthorize("isAuthenticated()")
		public ResponseEntity<String> registerReplyForBoard(@PathVariable("bno") long bno ,
															@RequestBody CommunityReplyVO communityreply) {
			Long registeredTrno = communityReplyService.registerCommunityReplyForCommunity(communityreply);
			String _registeredTrno = null ;
			
			if (registeredTrno != null) {
				_registeredTrno = String.valueOf(registeredTrno) ;
				
			} else {
				_registeredTrno = String.valueOf(registeredTrno) ;
			}
			
			System.out.println("_registeredTrno: " + _registeredTrno);
			
			return registeredTrno != null ? new ResponseEntity<String>(_registeredTrno, HttpStatus.OK) 
										 : new ResponseEntity<String>(_registeredTrno, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	
	
		//댓글의 답글 등록(trno 반환) POST 	/replies/{tno}/new
		@PostMapping(value = "/{tno}/{prno}/new" , 
					 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
					 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
		@PreAuthorize("isAuthenticated()")
		public ResponseEntity<String> registerReplyForReply(@PathVariable("tno") long tno ,
															@PathVariable("trcno") long trcno,
														    @RequestBody CommunityReplyVO communityreply) {
		Long registeredTrno = communityReplyService.registerCommunityReplyForCommunityReply(communityreply);
		String _registeredTrno = null ;
		if (registeredTrno != null) {
			_registeredTrno = String.valueOf(registeredTrno) ;
		} else {
			_registeredTrno = String.valueOf(registeredTrno) ;
		}
		
		System.out.println("_registeredTrno: " + _registeredTrno);
		
		return registeredTrno != null ? new ResponseEntity<String>(_registeredTrno, HttpStatus.OK) 
									 : new ResponseEntity<String>(_registeredTrno, HttpStatus.INTERNAL_SERVER_ERROR);
		}
			
	
	
		//게시물에 대한 특정 댓글 조회 GET 
		@GetMapping(value="/{tno}/{trno}" , 
					produces = "application/json;charset=utf-8")
		public CommunityReplyVO showReply(@PathVariable("tno") Long tno,
								   @PathVariable("trno") Long trno){

			return communityReplyService.getCommunityReply(tno, trno) ;
		}
	
	
		//게시물에 대한 특정 댓글 수정 PUT 또는 PATCH 		/replies/{tno}/{trno}
		//Ajax에서의 요청 URI: /mypro00/replies/229402/102, PUT:PATCH
		@RequestMapping(value="/{tno}/{trno}" , 
						method = {RequestMethod.PUT, RequestMethod.PATCH} ,
						consumes = "application/json;charset=utf-8" ,
						produces = "text/plain;charset=utf-8") 
		@PreAuthorize("isAuthenticated() && principal.username == #myreply.rwriter")
		public String modifyReply(@PathVariable("tno") Long tno ,
								  @PathVariable("trno") Long trno ,
								  @RequestBody CommunityReplyVO communityreply){
			System.out.println("컨트롤러에 전달된 communityreply: " + communityreply);
			
			if(communityReplyService.modifyCommunityReply(communityreply)) {
				return "modifySuccess" ;
			} else {
				return "modifyFail" ;	
			}
		}
	
		//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)	/replies/{tno}/{trno}
		@DeleteMapping(value = "/{tno}/{trno}" ,
					   consumes = "application/json; charset=utf-8",
					   produces = "text/plain;charset=utf-8")
		@PreAuthorize("isAuthenticated() && principal.username == #yourReply.rwriter")
		public ResponseEntity<String> removeReply(@PathVariable("tno") Long tno, 
												  @PathVariable("trno") Long trno,
												  @RequestBody CommunityReplyVO yourReply) {
			
			return communityReplyService.modifyTrdelFlag(tno, trno)
				   ? new ResponseEntity<String>("removeSuccess", HttpStatus.OK)
				   : new ResponseEntity<String>("removeFail", HttpStatus.INTERNAL_SERVER_ERROR) ;
		}
		
		//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
		@DeleteMapping(value = "/{tno}" , produces = "text/plain;charset=utf-8")
		public ResponseEntity<String> removeAllReply(@PathVariable("tno") Long tno){
			
			int deleteRows = communityReplyService.removeAllCommunityReply(tno);
			
			return new ResponseEntity<String>(String.valueOf(deleteRows), HttpStatus.OK) ;
		}
	
	
	
	
	
}
