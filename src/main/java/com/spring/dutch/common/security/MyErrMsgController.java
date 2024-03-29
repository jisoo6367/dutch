package com.spring.dutch.common.security;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyErrMsgController {
	
	@GetMapping(value = "/accessForbiddenError")
	public String sendAccessForbiddenPage(Authentication authentication, Model model, 
										  HttpServletRequest request) {
		System.out.println("authentication: " + authentication);
		System.out.println("myName:" + request.getAttribute("myName"));
		model.addAttribute("msg", "접근이 금지되었습니다") ;

		return "pages/myAccessForbiddenMsg" ;
	}
	

}
