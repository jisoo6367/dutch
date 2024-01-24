package com.spring.dutch.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.dutch.domain.DutchReplyVO;
import com.spring.dutch.dto.DutchReplyPagingCreatorDTO;
import com.spring.dutch.dto.DutchReplyPagingDTO;
import com.spring.dutch.service.DutchReplyService;


@RestController   //@Controller와는 다르게 @RestController 클래스의 메서드는 JSP 파일을 호출하지 않습니다.
@RequestMapping(value={"/replies", "/dutchReplies"})
public class DutchReplyController {
	
	private DutchReplyService dutchReplyService ;

	public DutchReplyController(DutchReplyService dutchReplyService) {
		this.dutchReplyService = dutchReplyService;
	}
	
	//게시물에 대한 댓글 목록 조회	GET	/replies/pages/{pno}/{pageNum}
	//브라우저 ajax 코드에서 url을 아래처럼 작성
	//http://localhost:8080/mypro00/replies/229402/page/1
	
	@GetMapping( value="/{pno}/page/{pageNum}" ,
			     produces = {"application/json;charset=utf-8" , 
			    			 "application/xml;charset=utf-8"  }
				) //produces: 브라우저로 보내는 데이터 형식을 설정합니다.
	public ResponseEntity<DutchReplyPagingCreatorDTO> 
				showReplyList(	@PathVariable("pno") long pno,
								@PathVariable("pageNum") Integer pageNum ){
							  //이 메서드가 호출된 URL로부터 pno 이름의 변수로 전달되는 값을 pno 매개변수에 저장
		
		DutchReplyPagingCreatorDTO dutchReplyPagingCreator = 
				dutchReplyService.getReplyList(new DutchReplyPagingDTO(pno, pageNum)) ;

		
		ResponseEntity<DutchReplyPagingCreatorDTO> myResponseEntity =
				new ResponseEntity<DutchReplyPagingCreatorDTO>(dutchReplyPagingCreator, HttpStatus.OK) ;
		
		return myResponseEntity ;
	}
	
	
//게시물에 대한 댓글 등록(rno 반환) POST 		/replies/{pno}/new
	@PostMapping(value = "/{pno}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerReplyForBoard(@PathVariable("pno") long pno ,
														@RequestBody DutchReplyVO dutchReply) {
		Long registeredRno = dutchReplyService.registerReplyForBoard(dutchReply);
		String _registeredRno = null ;
		
		if (registeredRno != null) {
			_registeredRno = String.valueOf(registeredRno) ;
			
		} else {
			_registeredRno = String.valueOf(registeredRno) ;
		}
		
		System.out.println("_registeredRno: " + _registeredRno);
		
		return registeredRno != null ? new ResponseEntity<String>(_registeredRno, HttpStatus.OK) 
									 : new ResponseEntity<String>(_registeredRno, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
//댓글의 답글 등록(rno 반환) POST 	/replies/{pno}/new
	@PostMapping(value = "/{pno}/{rcno}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerReplyForReply(@PathVariable("pno") long pno ,
														@PathVariable("rcno") long rcno,
													    @RequestBody DutchReplyVO dutchReply) {
	Long registeredRno = dutchReplyService.registerReplyForReply(dutchReply);
	String _registeredRno = null ;
	if (registeredRno != null) {
		_registeredRno = String.valueOf(registeredRno) ;
	} else {
		_registeredRno = String.valueOf(registeredRno) ;
	}
	
	System.out.println("_registeredRno: " + _registeredRno);
	
	return registeredRno != null ? new ResponseEntity<String>(_registeredRno, HttpStatus.OK) 
								 : new ResponseEntity<String>(_registeredRno, HttpStatus.INTERNAL_SERVER_ERROR);
}
	
//게시물에 대한 특정 댓글 조회 GET 				/replies/{pno}/{rno}
//	@GetMapping(value="/{pno}/{rno}" , 
//				produces = "application/json;charset=utf-8")
//	public ResponseEntity<MyReplyVO> showReply(@PathVariable("pno") Long pno,
//											   @PathVariable("rno") Long rno){
//
//		return new ResponseEntity<MyReplyVO>(dutchReplyService.getMyReply(pno, rno), HttpStatus.OK) ;
//	}
	
	@GetMapping(value="/{pno}/{rno}" , 
				produces = "application/json;charset=utf-8")
	public DutchReplyVO showReply(@PathVariable("pno") Long pno,
							   @PathVariable("rno") Long rno){

		return dutchReplyService.getDutchReply(pno, rno) ;
	}
	

//게시물에 대한 특정 댓글 수정 PUT 또는 PATCH 		/replies/{pno}/{rno}
	//Ajax에서의 요청 URI: /mypro00/replies/229402/102, PUT:PATCH
	@RequestMapping(value="/{pno}/{rno}" , 
					method = {RequestMethod.PUT, RequestMethod.PATCH} ,
					consumes = "application/json;charset=utf-8" ,
					produces = "text/plain;charset=utf-8") 
	@PreAuthorize("isAuthenticated() && principal.username == #dutchReply.nickname")
	public String modifyReply(@PathVariable("pno") Long pno ,
							  @PathVariable("rno") Long rno ,
							  @RequestBody DutchReplyVO dutchReply){
		System.out.println("컨트롤러에 전달된 myreply: " + dutchReply);
		
		if(dutchReplyService.modifyDutchReply(dutchReply)) {
			return "modifySuccess" ;
		} else {
			return "modifyFail" ;	
		}
	}
	
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)	/replies/{pno}/{rno}
	@DeleteMapping(value = "/{pno}/{rno}" ,
				   consumes = "application/json; charset=utf-8",
				   produces = "text/plain;charset=utf-8")
	@PreAuthorize("isAuthenticated() && principal.username == #yourReply.nickname")
	public ResponseEntity<String> removeReply(@PathVariable("pno") Long pno, 
											  @PathVariable("rno") Long rno, 
											  @RequestBody DutchReplyVO yourReply) {
//											  @RequestBody DutchReplyVO dutchReply) {
				System.out.println("============================여기 온거는 맞나?");							  	
		return dutchReplyService.modifyRdelFlag(pno, rno)  
			   ? new ResponseEntity<String>("removeSuccess", HttpStatus.OK)
			   : new ResponseEntity<String>("removeFail", HttpStatus.INTERNAL_SERVER_ERROR) ;
	}
	


//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@DeleteMapping(value = "/{pno}" , produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> removeAllReply(@PathVariable("pno") Long pno){
		
		int deleteRows = dutchReplyService.removeAllReply(pno) ;
		
		return new ResponseEntity<String>(String.valueOf(deleteRows), HttpStatus.OK) ;
	}

}
