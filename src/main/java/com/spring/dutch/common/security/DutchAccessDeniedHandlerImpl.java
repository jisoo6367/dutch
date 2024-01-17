package com.spring.dutch.common.security;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;

public class DutchAccessDeniedHandlerImpl extends AccessDeniedHandlerImpl{
	
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		System.out.println("accessDeniedException오류 메시지: " + accessDeniedException.getMessage());
		
		Authentication myAuth = SecurityContextHolder.getContext().getAuthentication() ;
		Set<String> authNameList = AuthorityUtils.authorityListToSet(myAuth.getAuthorities()) ;
		
		if(authNameList.contains("ROLE_USER")) {
			response.sendRedirect("/dutch/");
			
		} else {
			response.sendRedirect("/dutch/loginPage");
		}
		
	}

}
