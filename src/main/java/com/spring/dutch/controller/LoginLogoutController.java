package com.spring.dutch.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.service.MemberRegisterService;

@Controller
public class LoginLogoutController {
	private MemberRegisterService memberRegisterService;
	
	public LoginLogoutController(MemberRegisterService memberRegisterService) {
		this.memberRegisterService = memberRegisterService;
	}
	
	
	@GetMapping(value="/loginPage")
	public String showLoginPage() {
		return "pages/login";
	}
	
	@GetMapping(value = "/logoutPage")
	public String showLogoutPage() {
		return "pages/logout";
	}
	
	@GetMapping(value = "/finder")
	public String showFindUserPage() {
		return "/pages/forgotIdPassword";
	}
	
	@PostMapping(value = "/findEmail")
	public String findEmailController(MemberVO member, Model model) {
		
		String nickname = memberRegisterService.findNicknameService(member);
		System.out.println(nickname);
		model.addAttribute("nickname", nickname);
		
		return "/pages/finder";
	}
	
	@GetMapping("/test")
	public String test() {
		return "pages/test";
	}
	
}
