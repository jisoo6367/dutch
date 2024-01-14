package com.spring.dutch.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.domain.SendMemberVO;
import com.spring.dutch.service.MemberRegisterService;

@Controller
public class MemberRegisterController {
	
	
	
	private MemberRegisterService memberRegisterService;
	
	public MemberRegisterController(MemberRegisterService memberRegisterService) {
		this.memberRegisterService = memberRegisterService;
	}
	
	@GetMapping(value="/memberregister")
	public String showRegister() {
		return "/pages/memberregister";
	}
	
	
	@PostMapping(value="/sendmember")
	public String sendMember(SendMemberVO sendmember) {
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
		
		memberRegisterService.registerMember(member);
		
		return "/pages/frame";
	}
	
}
