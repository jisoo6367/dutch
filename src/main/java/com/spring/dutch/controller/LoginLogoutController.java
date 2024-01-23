package com.spring.dutch.controller;


import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.service.MemberRegisterService;

@Controller
public class LoginLogoutController {
	/*@Inject
	private SnsValue naverSns;
	
	@Inject
	private GoogleConnectionFactory connectionFactory;
	
	@Inject
	private OAuth2Parameters googleOAuth2Parameters;*/
	
	private MemberRegisterService memberRegisterService;
	
	public LoginLogoutController(MemberRegisterService memberRegisterService) {
		this.memberRegisterService = memberRegisterService;
	}
	
	/*@RequestMapping(value = "/auth/naver/callback",
					method= {RequestMethod.GET, RequestMethod.POST})
	public String snsLoginCallback(Model m, @RequestParam String code) throws Exception {
		
		SNSLogin snsLogin = new SNSLogin(naverSns);
		String profile = snsLogin.getUserProfile(code);
		System.out.println("Profile>>>>" + profile);
		
		m.addAttribute("result", profile);
		
		return "pages/loginResult";
	}
	
	@RequestMapping(value = "/naverLogin", method = RequestMethod.GET)
	public void naverLoginSns(Model m) throws Exception {
		
		SNSLogin snsLogin = new SNSLogin(naverSns);
		m.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
		OAuth2Operations authOperations = connectionFactory.getOAuthOperations();
		String url = authOperations.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		
		m.addAttribute("google_url", url);
	}*/
	
	
	@GetMapping(value="/loginPage")
	public String showLoginPage(String result, Model model, String error, String logout) {
		
		if (error != null) {
			System.out.println("=========:error.length(): " + error.length());
			System.out.println("=========:error.hashCode(): " + error.hashCode());
			model.addAttribute("error", "로그인 오류! 닉네임 또는 암호를 확인하세요") ;
		
		} else if(logout != null) {
			System.out.println("=========:logout.length(): " + logout.length());
			System.out.println("=========:logout.hashCode(): " + logout.hashCode());
			model.addAttribute("logout", "정상적으로 로그아웃 되었습니다") ;
		} else if(result != null) {
			model.addAttribute("result", result);
		} else {
			model.addAttribute("normal", "로그인 페이지를 직접 호출 하였습니다.") ;
		}
		
		model.addAttribute("result", result);
		System.out.println(result);
		
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
	
	@GetMapping("/naverCallback")
	public String naverLogin() {
			System.out.println("네이버콜백제이에스피로 가는 컨트롤러입니다.");
		return "pages/naverCallback";
	}
	
	
	
}
