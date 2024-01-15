package com.spring.dutch.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

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
	
	
	@PostMapping(value="/sendmember",
				 consumes = {"application/json;charset=utf-8"},
				 produces = {"text/plain;charset=utf-8"})
	public ResponseEntity<String> sendMember(@RequestBody SendMemberVO sendmember) {
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
		
		return result != null ? new ResponseEntity<String>(result, HttpStatus.OK)
							  : new ResponseEntity<String>(result, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
