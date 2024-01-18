package com.spring.dutch.controller;


import java.security.Principal;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.dto.MypageDTO;
import com.spring.dutch.dto.MypagePagingCreatorDTOhistory;
import com.spring.dutch.dto.MypagePagingCreatorDTOongoing;
import com.spring.dutch.dto.MypagePagingDTOhistory;
import com.spring.dutch.dto.MypagePagingDTOongoing;
import com.spring.dutch.dto.MypagePagingNicknameDTOhistory;
import com.spring.dutch.dto.MypagePagingNicknameDTOongoing;
import com.spring.dutch.service.MypageService;


@Controller
@RequestMapping("/mypage")
public class MypageController {

	private MypageService mypageService;

	public MypageController(MypageService mypageService) {
		this.mypageService = mypageService;
	}

	// 마이페이지 첫 화면 호출
	// 더치페이 방 수 도 받아옴
	@GetMapping(value = "/home")
	@PreAuthorize("isAuthenticated()")
	public String showMypage(Principal principal, Model model) {
		
		MemberVO memberData = mypageService.getMemberData(principal.getName());
		model.addAttribute("memberData", memberData);		
		System.out.println("========================마이페이지 첫화면 memberData : "+memberData);


		System.out.println("========================마이페이지 첫화면 nickname : "+ principal.getName());
		MypageDTO dutchCount = mypageService.getDutchCount(principal.getName());
		model.addAttribute("dutchCount", dutchCount);
		System.out.println("========================마이페이지 첫화면 dutchCount : "+ dutchCount);
		
		
		
		return "/pages/mypage";
	}
	
	// 회원정보 변경 페이지 호출
	@GetMapping(value = "/info")
	@PreAuthorize("isAuthenticated()")
	public String getMemberData(Principal principal, Model model, String result) {

		if(result == null) {
			model.addAttribute("result", "");
			
		} else {
			model.addAttribute("result", result);
		}
		
		System.out.println("============결과는?! : " + result);
		System.out.println("고객님의 닉네임은 " + principal.getName() + " 입니다.=================");
		
		MemberVO memberData = mypageService.getMemberData(principal.getName());
		model.addAttribute("memberData", memberData);



		System.out.println("memberData : " + memberData);
		

		return "/pages/mypageInfo";
	}


	// 수정 페이지 이동
	@GetMapping(value = "/modify")
	public String showModify(String nickname, Model model) {

		System.out.println("마이페이지 > 수정");
		System.out.println("nickname 잘 넘어왔나? : " + nickname);

		MemberVO memberData = mypageService.getMemberData(nickname);
		model.addAttribute("memberData", memberData);
		//System.out.println("memberData : " + memberData);


		return "/pages/mypageModify";
	}

	// 수정된 정보 받아서 DB작업
	@PostMapping(value = "/modify")
	public String memberModify(MemberVO member, RedirectAttributes redirectAttr) {
//	public String memberModify (MemberVO member, Model model) {

		System.out.println("화면에서 수정된 member 잘 넘어왔나? : " + member);
		
		boolean modifyResult = mypageService.modifyMember(member) == 1;

		if (modifyResult) {
			redirectAttr.addAttribute("result", "successModify");

		} else {
			redirectAttr.addAttribute("result", "failModify");
		}
		System.out.println("===========DB update 리턴값 info컨트롤러로 넘기기전 : "+ modifyResult);
		redirectAttr.addAttribute("nickname", member.getNickname());
		redirectAttr.addAttribute("modifyResult", modifyResult);
		 

		return "redirect:/mypage/info";
		// return "/pages/mypage";
	}

	//회원 탈퇴 버튼 눌렀을 때
	@GetMapping(value = "/withdraw")
	public String memberWithdraw (String nickname, RedirectAttributes redirectAttr) {
		System.out.println("삭제컨트롤러 도착");
		
		boolean deleteResult = mypageService.withdrawMember(nickname);
		boolean deleteAuthResult = mypageService.withdrawMemberAuth(nickname);

		if (deleteResult && deleteAuthResult) {
			redirectAttr.addAttribute("result", "successWithdraw");

		} else {
			redirectAttr.addAttribute("result", "failWithdraw");
		}
		
		
		return "redirect:/loginPage";
	}

	// 더치페이 내역 > 상세보기
	//닉네임으로 participants테이블에서 튜플 가져오기
	@GetMapping(value = "/history")
	@PreAuthorize("isAuthenticated()")
	public String showDutchHistoryList(Principal principal, Model model,
										MypagePagingDTOhistory pagingHistory, MypagePagingDTOongoing pagingOngoing) {
	    
	    System.out.println("=================페이징 히스토리 pagenum_0 : " + pagingOngoing.getPageNum_0());
	    System.out.println("=================페이징 히스토리 pagenum_1 : " + pagingHistory.getPageNum_1());
		
	    model.addAttribute("nickname", principal.getName());

	    MypagePagingNicknameDTOongoing ongoingDTO = new MypagePagingNicknameDTOongoing();
	    ongoingDTO.setMypagePaging(pagingOngoing);
	    ongoingDTO.setNickname(principal.getName());

	    MypagePagingCreatorDTOongoing pagingCreator_0 = mypageService.getPersonal_0(ongoingDTO);
	    model.addAttribute("pagingCreator_0", pagingCreator_0);
	    
	    
	    
	    MypagePagingNicknameDTOhistory historyDTO = new MypagePagingNicknameDTOhistory();
	    historyDTO.setMypagePaging(pagingHistory);
	    historyDTO.setNickname(principal.getName());
	    
	    MypagePagingCreatorDTOhistory pagingCreator_1 = mypageService.getPersonal_1(historyDTO);
	    model.addAttribute("pagingCreator_1", pagingCreator_1);
	    
		return "/pages/mypageDutchHistory";
	}



	
	
	
	

}
