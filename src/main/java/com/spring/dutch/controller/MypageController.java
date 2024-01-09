package com.spring.dutch.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.service.MypageService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mypage")
public class MypageController {

	private MypageService mypageService;

	public MypageController(MypageService mypageService) {
		this.mypageService = mypageService;
	}

	// 마이페이지 호출
	@GetMapping("/test")
	public String showMemberData() {

		System.out.println("그냥 페이지호출..");

		return "pages/mypage";
	}

	// 인풋창에 mno 넣었을 때 DB가져오기
	@GetMapping(value = "/home")
	// @PreAuthorize("isAthenticated() && principal.username == #email")
	public String showMemberData(long mno, Model model, int modifyResult) {

		System.out.println("고객님의 회원번호는 " + mno + " 입니다.=================");
		
		MemberVO memberData = mypageService.getMemberData(mno);
		model.addAttribute("memberData", memberData);

		System.out.println("memberData : " + memberData);
		
		
		
		if (modifyResult == 1 ) {
			model.addAttribute("result", "successModify");

		} else if (modifyResult == 0){
			model.addAttribute("result", "failModify");
			
		} else {
			model.addAttribute("result", "");
		}


		return "/pages/mypage";
	}

	// 더치페이 내역 > 정산 중인 방 호출
	@GetMapping(value = "/ongoing")
	public String showDutchOngoingList() {

		System.out.println("더치페이 내역 > 정산 중인 방");

		return "/pages/mypageDutchOngoing";
	}

	// 더치페이 내역 > 정산 완료 방 호출
	@GetMapping(value = "/history")
	public String showDutchHistoryList() {

		System.out.println("더치페이 내역 > 정산 완료 방");

		return "/pages/mypageDutchHistory";
	}

	// 수정 페이지 이동
	@GetMapping(value = "/modify")
	public String showModify(long mno, Model model) {

		System.out.println("마이페이지 > 수정");
		System.out.println("mno 잘 넘어왔나? : " + mno);

		MemberVO memberData = mypageService.getMemberData(mno);
		model.addAttribute("memberData", memberData);
		//System.out.println("memberData : " + memberData);


		return "/pages/mypageModify";
	}

	// 수정된 정보 받아서 DB작업
	@PostMapping(value = "/modify")
	public String memberModify(MemberVO member, RedirectAttributes redirectAttr) {
//	public String memberModify (MemberVO member, Model model) {

		System.out.println("화면에서 수정된 member 잘 넘어왔나? : " + member);

		int modifyResult = mypageService.modifyMember(member);

//		if (modifyResult) {
//			redirectAttr.addAttribute("result", "successModify");
//
//		} else {
//			redirectAttr.addAttribute("result", "failModify");
//		}

		redirectAttr.addAttribute("mno", member.getMno());
		redirectAttr.addAttribute("modifyResult", modifyResult);
		 

		return "redirect:/mypage/home";
		// return "/pages/mypage";
	}

	//회원 탈퇴 버튼 눌렀을 때
	@GetMapping(value = "/withdraw")
	public String memberWithdraw (long mno, RedirectAttributes redirectAttr) {
		System.out.println("삭제컨트롤러 도착");
		
		boolean deleteResult = mypageService.withdrawMember(mno);

		if (deleteResult) {
			redirectAttr.addAttribute("result", "successWithdraw");
			

		} else {
			redirectAttr.addAttribute("result", "failWithdraw");
		}
		
		
		return "redirect:/mypage/test";
	}
}
