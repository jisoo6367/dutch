package com.spring.dutch.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginLogoutController {
	
	@GetMapping(value="/loginPage")
	public String showLoginPage() {
		return "pages/login";
	}
	
}
