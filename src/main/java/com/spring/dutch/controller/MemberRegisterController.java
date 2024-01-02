package com.spring.dutch.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.service.MemberRegisterService;

import lombok.Setter;

@Controller
public class MemberRegisterController {
	
	@Setter(onMethod_ = @Autowired)
    private PasswordEncoder pwencoder;
	
	private MemberRegisterService memberRegisterService;
	
	public MemberRegisterController(MemberRegisterService memberRegisterService) {
		this.memberRegisterService = memberRegisterService;
	}
	
	@GetMapping(value="/memberregister")
	public String showRegister() {
		return "/pages/memberregister";
	}
	
	
	@PostMapping(value="/sendmember")
	public String sendMember(MemberVO member, RedirectAttributes redirectAttr) {
		member.setPassword(pwencoder.encode(member.getPassword()));
		
		String email = memberRegisterService.registerMember(member);
		
		redirectAttr.addAttribute("email", email);
		
		return "redirect:/pages/frame";
	}
	
}
