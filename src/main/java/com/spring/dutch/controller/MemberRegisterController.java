package com.spring.dutch.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.domain.CheckNickVO;
import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.domain.NaverVO;
import com.spring.dutch.domain.SendMemberVO;
import com.spring.dutch.service.MemberRegisterService;

@Controller
@RequestMapping("/member")
public class MemberRegisterController {
	
	private MemberRegisterService memberRegisterService;
	
	public MemberRegisterController(MemberRegisterService memberRegisterService) {
		this.memberRegisterService = memberRegisterService;
	}
	
	@GetMapping(value="/register")
	public String choiseRegister() {
		return "/pages/choiseRegiPage";
	}
	
	@GetMapping(value="/normalRegister")
	public String showRegister() {
		return "/pages/memberRegister";
	}

	
	@PostMapping(value="/sendmember")
	public String sendMember(SendMemberVO sendmember, RedirectAttributes redirectAttr) {
	MemberVO member = new MemberVO();
	
	member.setNickname(sendmember.getNickname());
	member.setBank(sendmember.getBank());
	member.setBankAccount(sendmember.getBankAccount());
	member.setUsername(sendmember.getUsername());
	member.setEmail(sendmember.getEmail());
	member.setPassword(sendmember.getPassword());
	
	String cellphone = sendmember.getCellphone1() 
					   + sendmember.getCellphone2()
					   + sendmember.getCellphone3();
	
	member.setCellphone(Integer.parseInt(cellphone));
	member.setGender(sendmember.getGender());
	member.setAge(sendmember.getAge());
	member.setAuthorityList(sendmember.getAuthorityList());
	member.setAccountNonExpired(sendmember.isAccountNonExpired());
	System.out.println(member);
	
	String result = memberRegisterService.registerMember(member);
	System.out.println("회원가입 결과: " + result);
	redirectAttr.addAttribute("result", result);
	
	return "redirect:/loginPage";
	}
	
	@PostMapping(value = "/checkNickname/{nickname}",
				consumes = "application/json;charset=utf-8",
				produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> checkNick(@PathVariable("nickname") String nickname){
		System.out.println("send nickname: " + nickname);
		
	//	nickname = nickname.replaceAll("nickname=", "");
	//	System.out.println("replaced nickname: " + nickname);
		
		String result = (memberRegisterService.checkNicknameService(nickname));
		
		System.out.println("컨트롤러 result: "+result);
		
		return new ResponseEntity<String>(result, HttpStatus.OK) ;
	}
	
}
