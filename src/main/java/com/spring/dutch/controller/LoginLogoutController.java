package com.spring.dutch.controller;


import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.service.MemberRegisterService;

@Controller
public class LoginLogoutController {
	/*@Inject
	private SnsValue naverSns;
	
	@Inject
	private SnsValue googleSns;
	
	@Inject
	private GoogleConnectionFactory googleConnectionFactory;
	
	@Inject
	private OAuth2Parameters googleOAuth2Parameters;*/
	
	private MemberRegisterService memberRegisterService;
	
	public LoginLogoutController(MemberRegisterService memberRegisterService) {
		this.memberRegisterService = memberRegisterService;
	}
	
	
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
	
	/*@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login(Model model) throws Exception{
		
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
		OAuth2Operations authOperations = googleConnectionFactory.getOAuthOperations();
		String url = authOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		
		model.addAttribute("google_url", url);
		
		
	}*/
	
}
