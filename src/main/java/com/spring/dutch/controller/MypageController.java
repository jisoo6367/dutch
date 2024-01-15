package com.spring.dutch.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.dto.MypageDTO;
import com.spring.dutch.domain.ParticipantsVO;
import com.spring.dutch.dto.mypageAttachFileDTO;
import com.spring.dutch.service.MypageService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/mypage")
public class MypageController {

	private MypageService mypageService;

	public MypageController(MypageService mypageService) {
		this.mypageService = mypageService;
	}

	// 마이페이지 첫 화면 호출
	@GetMapping(value = "/home")
	@PreAuthorize("isAuthenticated()")
	public String showMypage(Principal principal, Model model) {
		
		MemberVO memberData = mypageService.getMemberData(principal.getName());
		model.addAttribute("memberData", memberData);		

		
		List<MypageDTO> dutchCount = mypageService.getDutchCount(principal.getName());
		model.addAttribute("dutchCount", dutchCount);
		System.out.println("============================dutchCount : "+ dutchCount);
		
		
		
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

	// 더치페이 내역 > 정산 중인 방 호출
	@GetMapping(value = "/ongoing")
	public String showDutchOngoingList() {

		System.out.println("더치페이 내역 > 정산 중인 방");

		return "/pages/mypageDutchOngoing";
	}

	// 더치페이 내역 > 정산 완료 방 호출
	//닉네임으로 participants테이블에서 튜플 가져오기
	@GetMapping(value = "/history")
	@PreAuthorize("isAuthenticated()")
	public String showDutchHistoryList(Principal principal, Model model) {
		
		System.out.println("더치페이 내역 > 정산 완료 방");
		System.out.println(principal.getName());
		
		model.addAttribute("nickname", principal.getName());
		
		List<ParticipantsVO> personalData = mypageService.getPersonal(principal.getName());
		model.addAttribute("personalData", personalData);
		
		return "/pages/mypageDutchHistory";
	}
	
	
	
	
	
	

}
