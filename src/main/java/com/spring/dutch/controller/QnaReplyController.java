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

import com.spring.dutch.domain.NoticeVO;
import com.spring.dutch.domain.QnaReplyVO;
import com.spring.dutch.dto.QnaReplyPagingCreatorDTO;
import com.spring.dutch.dto.QnaReplyPagingDTO;
import com.spring.dutch.service.QnaReplyService;

@RestController
@RequestMapping(value= {"/qnaReplies", "/qnaReplies"})
public class QnaReplyController {
	
	private QnaReplyService qnareplyService;
	
	public QnaReplyController(QnaReplyService qnareplyService) {
		this.qnareplyService = qnareplyService;
	}
	
	//게시물에 대한 댓글 목록 조회 	GET/replies/pages/{qno}/{pageNum}
	//http://localhost:8080/dutch/replies/24/page/1
	@GetMapping(value="/{qno}/page/{pageNum}/qna",
				produces= {"application/json;charset=utf-8" ,
						   "application/xml;charset=utf-8"})
	public ResponseEntity<QnaReplyPagingCreatorDTO>
				showQnaRepliesList(@PathVariable("qno") long qno,
							   	   @PathVariable("pageNum") Integer pageNum){
		
		QnaReplyPagingCreatorDTO qnareplyPagingCreator = 
				qnareplyService.getReplyList(new QnaReplyPagingDTO(qno, pageNum));
		System.out.println("qnareplyPagingCreator: " + qnareplyPagingCreator);
		
		ResponseEntity<QnaReplyPagingCreatorDTO> responseEntity = 
				new ResponseEntity<QnaReplyPagingCreatorDTO>(qnareplyPagingCreator, HttpStatus.OK);
		
		return responseEntity; 
	}
	
	//게시물에 대한 특정 댓글 조회	/replies/{qno}/{qrno}
	@GetMapping(value = "/{qno}/{qrno}/qna" ,
				produces = "application/json;charset=utf-8")
	public QnaReplyVO showReply(@PathVariable("qno") Long qno,
								@PathVariable("qrno") Long qrno) {
		
		return qnareplyService.getQnaReply(qno, qrno);
	} 
	
	
	//게시물에 대한 댓글 등록(qrno 반환)
	@PostMapping(value = "/{qno}/new/qna" ,
				 consumes = {"application/json;charset=utf-8"} ,
				 produces = {"text/plain; charset=utf-8"})
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerReplyForQna(@PathVariable("qno") long qno,
													  @RequestBody QnaReplyVO qnareply){
		
		Long registeredQrno = qnareplyService.registerReplyForQna(qnareply);
		System.out.println("registeredQrno: " + registeredQrno);
		
		String _registeredQrno = null;
		
		if(registeredQrno != null) {
			_registeredQrno = String.valueOf(registeredQrno);
		}else {
			_registeredQrno = String.valueOf(registeredQrno);
		}
		
		System.out.println("_registeredQrno: " + _registeredQrno);
		
		return registeredQrno != null ? new ResponseEntity<String>(_registeredQrno, HttpStatus.OK)
									  : new ResponseEntity<String>(_registeredQrno, HttpStatus.INTERNAL_SERVER_ERROR) ;
	}
	
	//댓글의 답글 등록(qrno 반환)	POST /replies/{qno}/new
	@PostMapping(value = "/{qno}/{qrcno}/new/qna" ,
				 consumes = {"application/json;charset=utf-8"} ,
				 produces = {"text/plain;charset=utf-8"})
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerReplyForReply(@PathVariable("qno") long qno,
														@PathVariable("qrcno") long qrcno,
														@RequestBody QnaReplyVO qnareply){
		System.out.println("qrcno: " + qrcno);
		System.out.println("qnareply: " + qnareply);
		Long registeredQrno = qnareplyService.registerReplyForReply(qnareply);
		
		
		String _registeredQrno = null;
		
		if(registeredQrno != null) {
			_registeredQrno = String.valueOf(registeredQrno);
		}else {
			_registeredQrno = String.valueOf(registeredQrno);
		}
		
		System.out.println("_registeredQrno: " + _registeredQrno);
		
		return registeredQrno != null ? new ResponseEntity<String>(_registeredQrno, HttpStatus.OK)
									  : new ResponseEntity<String>(_registeredQrno, HttpStatus.INTERNAL_SERVER_ERROR);	
	}
	
	//게시물에 대한 특정 댓글 수정	/replies/{qno}/{qrno}
	@RequestMapping(value = "/{qno}/{qrno}/qna" ,
					method = {RequestMethod.PUT, RequestMethod.PATCH} ,
					consumes = "application/json;charset=utf-8" ,
					produces = "text/plain;charset=utf-8")
	@PreAuthorize("isAuthenticated() && principal.username == #qnareply.nickname")
	public String modifyReply(@PathVariable("qno") Long qno,
							  @PathVariable("qrno") Long qrno,
							  @RequestBody QnaReplyVO qnareply) {
		System.out.println("컨트롤러에 전달된 qnareply: " + qnareply);
		
		if(qnareplyService.modifyQnaReply(qnareply)) {
			return "modifySuccess" ;
		}else {
			return "modifyFail";
		}
		
	}
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(qrdelFalg를 1로 업뎃)	/replies/{qno}/{qrno}
	@DeleteMapping(value = "/{qno}/{qrno}/qna",
				   consumes = "application/json; charset=utf-8" ,
				   produces = "text/plain;charset=utf-8")
	@PreAuthorize("isAuthenticated() && principal.username == #qnareply.nickname")
	public ResponseEntity<String> removeReply(@PathVariable("qno") Long qno,
											  @PathVariable("qrno") Long qrno,
											  @RequestBody QnaReplyVO qnareply){
		
		return qnareplyService.modifyQrdelFlag(qno, qrno)
			   ? new ResponseEntity<String>("removeSuccess", HttpStatus.OK)
			   : new ResponseEntity<String>("removeFail", HttpStatus.INTERNAL_SERVER_ERROR);
	}	
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@DeleteMapping(value = "/{qno}/qna", produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> removeAllReply(@PathVariable("qno") Long qno){
		
		int deleteRows = qnareplyService.removeAllReply(qno);
		
		return new ResponseEntity<String>(String.valueOf(deleteRows), HttpStatus.OK);
	}
}
