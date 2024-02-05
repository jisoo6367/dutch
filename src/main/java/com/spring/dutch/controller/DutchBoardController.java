package com.spring.dutch.controller;

import java.security.Principal;
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

import com.spring.dutch.domain.DutchAttachFileVO;
import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.domain.ParticipantsVO;
import com.spring.dutch.dto.DutchAndPartiListDTO;
import com.spring.dutch.dto.DutchBoardPagingCreatorDTO;
import com.spring.dutch.dto.DutchBoardPagingDTO;
import com.spring.dutch.dto.DutchModifyDTO;
import com.spring.dutch.dto.DutchRegisterDTO;
import com.spring.dutch.service.DutchBoardService;
import com.spring.dutch.service.MypageService;

@Controller
@RequestMapping("/pay")
public class DutchBoardController {

	  private DutchBoardService dutchBoardService ;
		/* private MypageService mypageService; */

	  public DutchBoardController(DutchBoardService dutchBoardService) {
		  this.dutchBoardService = dutchBoardService ;
			/* this.mypageService = mypageService ; */
	  }


	//더치페이 목록 조회
	@GetMapping("/list") 
	@PreAuthorize("isAuthenticated()")
	public String showBoardList(DutchBoardPagingDTO dutchboardPaging, Model model, String result) {
		
	    System.out.println("dutchboardPagingDTO" + dutchboardPaging); 

	    DutchBoardPagingCreatorDTO pagingCreator = dutchBoardService.getDutchList(dutchboardPaging);
	    //System.out.println("컨트롤러에 저장된 DutchboardPagingCreator \n" + pagingCreator);  

	    model.addAttribute("pagingCreator", pagingCreator);
	    
		model.addAttribute("result", result);

	  return "pages/dutchList"; 
	}

	//더치페이 게시물 페이지 호출
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String showBoardRegisterPage() {
		System.out.println("등록페이지 호출..........");

		return "/pages/dutchRegister";
	}

	//더치페이 등록 처리
	@PostMapping(value="/register")
	@PreAuthorize("isAuthenticated()")
	public String registerNewBoard(DutchRegisterDTO dutchRegister,
									Principal principal,
									RedirectAttributes redirectAttr) {
		dutchRegister.setNickname(principal.getName());
		System.out.println("principal.getName(): " + principal.getName());
		System.out.println("dutchRegister.getParticipants(): " + dutchRegister.getParticipants());
		
		ParticipantsVO participants = new ParticipantsVO();
		participants.setNickname(principal.getName());
		
		List<ParticipantsVO> partiList = dutchRegister.getParticipants();
		partiList.add(participants);
		dutchRegister.setParticipants(partiList);
		
		System.out.println("participants: " + dutchRegister);
		long pno = dutchBoardService.registerDutchBoard(dutchRegister);

		redirectAttr.addFlashAttribute("result", pno);
		System.out.println("result: " + redirectAttr.getFlashAttributes());

		return "redirect:/pay/list" ;
	}
	

	//특정 더치페이 게시물 조회 페이지 or 수정 후 조회 페이지
	@GetMapping("/detail")
	@PreAuthorize("isAuthenticated()")
	public String showDutchBoardDetail(Long pno, Model model, String modifyResult, String updateResult, Principal principal,
			                           @ModelAttribute("dutchboardPaging") 
	                                   DutchBoardPagingDTO dutchboardPaging) {
		DutchAndPartiListDTO dto = null ;

		dto = dutchBoardService.getDutchBoard(pno);
		/*
		 * System.out.println("데이터가져오기전=[=====================");
		 * 
		 * MemberVO memberVO =
		 * mypageService.getMemberData(dto.getDutchboard().getNickname());
		 * 
		 * System.out.println("컨트롤러 memberVO: " + memberVO);
		 */

		System.out.println("===========================어휴,,modifyResult: "+modifyResult);
		System.out.println("===========================어휴,,updateResult: "+updateResult);
		
		model.addAttribute("dto", dto);
		model.addAttribute("modifyResult", modifyResult);
		model.addAttribute("updateResult", updateResult);
		/*
		 * model.addAttribute("bank", memberVO.getBank());
		 * model.addAttribute("bankAccount", memberVO.getBankAccount());
		 */

		
		List<DutchAttachFileVO> attachFileList =  dutchBoardService.getAttachFileList(pno);
		model.addAttribute("attachFileList", attachFileList);
		
		
		return "/pages/dutchDetail";
	}

	// 수정 페이지 이동
	@GetMapping(value = "/modify")
	@PreAuthorize("isAuthenticated()")
	public String showDutchModify(String nickname, long pno, Model model) {

		System.out.println("nickname 잘 넘어왔나? : " + nickname);

//		DutchBoardVO dutchboard = dutchBoardService.getDutchBoard(pno);
		DutchAndPartiListDTO dutchboard = dutchBoardService.getDutchBoard(pno);
		
		model.addAttribute("dutchboard", dutchboard);
		System.out.println("====================dutchboard : " + dutchboard);
		
		List<DutchAttachFileVO> attachFileList =  dutchBoardService.getAttachFileList(pno);
		model.addAttribute("attachFileList", attachFileList);
		
		//참여자 목록 가져오기위해서
		DutchAndPartiListDTO dto = dutchBoardService.getDutchBoard(pno);
		model.addAttribute("dto", dto);
		
		return "/pages/dutchModify";
	}

	
	// 수정된 정보 받아서 DB작업
	@PostMapping(value = "/modify")
	@PreAuthorize("isAuthenticated()")
	public String dutchBoardModify(DutchModifyDTO participants, DutchBoardVO boardVO, long pno, 
								RedirectAttributes redirectAttr, Principal principal) {

		ParticipantsVO participant = new ParticipantsVO();
		participant.setNickname(principal.getName());
		
		List<ParticipantsVO> partiList = participants.getParticipants();
		System.out.println("===========partiList : "+ partiList);
		partiList.add(participant);
		participants.setParticipants(partiList);
		System.out.println("============boardVO: " + boardVO);
		
		System.out.println("===========participants : "+ participants);
		System.out.println("===========boardVO : "+ boardVO);
		boolean modifyResult = dutchBoardService.modifyDutchBoard(participants, boardVO, pno);
		System.out.println("==========수정 결과는 ?: " + modifyResult);
		
		redirectAttr.addAttribute("pno", pno);
		redirectAttr.addAttribute("modifyResult", modifyResult);
		
		return "redirect:/pay/detail";
		// return "/pages/dutchdetail";
	}
	
	//게시글 삭제
	@GetMapping(value = "/delete")
	@PreAuthorize("isAuthenticated()")
	public String dutchBoardDelete (String nickname, long pno, Model model) {
		System.out.println("삭제컨트롤러 도착");
		
		boolean deleteResult = dutchBoardService.deleteDutchBoard(pno);
		System.out.println("======================게시글 삭제 deleteResult : "+ deleteResult);
		if (deleteResult) {
			model.addAttribute("result", "successDelete");

		} else {
			model.addAttribute("result", "failDelete");
		}
		
		return "redirect:/pay/list";
	}
	
	// 정산 완료 처리
	@GetMapping(value = "/finish")
	@PreAuthorize("isAuthenticated() && principal.username == #nickname")
	public String dutchBoardFinish (String nickname, long pno, Model model) {
		System.out.println("정산완료 컨트롤러 도착");
		
		boolean updateResult = dutchBoardService.updatePcalculated(pno);
		
		if (updateResult) {
			model.addAttribute("updateResult", "successUpdate");

		} else {
			model.addAttribute("updateResult", "failUpdate");
		}
		model.addAttribute("pno", pno);
		
		return "redirect:/pay/detail";
	}

	//게시글 신고
	@GetMapping(value = "/report")
	@PreAuthorize("isAuthenticated()")
	public String dutchBoardDelete (long pno, Model model) {
		System.out.println("신고컨트롤러 도착");
			
		boolean reportResult = dutchBoardService.updatePreport(pno);
		
		if (reportResult) {
			model.addAttribute("result", "successReport");

		} else {
			model.addAttribute("result", "failReport");
		}
		model.addAttribute("pno", pno);

		
		return "redirect:/pay/list";
	}

	
	//신고받은 목록만 조회
	@GetMapping("/reportedList") 
	public String showReportList(DutchBoardPagingDTO dutchboardPaging, Model model, String result) {
		
	    System.out.println("dutchboardPagingDTO" + dutchboardPaging); 

	    DutchBoardPagingCreatorDTO pagingCreator = dutchBoardService.getReportedDutchList(dutchboardPaging);
	    //System.out.println("컨트롤러에 저장된 DutchboardPagingCreator \n" + pagingCreator);  

	    model.addAttribute("pagingCreator", pagingCreator);
	    
		model.addAttribute("result", result);

	  return "pages/dutchReportList"; 
	}
	
	
	

	
	
	
	
	//특정 게시물의 첨부파일 정보를 JSON으로 전달(특정 게시물의 수정페이지에서 사용) ###########################
	@GetMapping(value = "/getFiles" , produces = {"application/json; charset=utf-8"})
	public @ResponseBody ResponseEntity<List<DutchAttachFileVO>> showAttachFiles(Long pno) {
		return new ResponseEntity<List<DutchAttachFileVO>>(dutchBoardService.getAttachFileList(pno), HttpStatus.OK);
	}
}
