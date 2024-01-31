package com.spring.dutch.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.dutch.dto.AdminDTO;
import com.spring.dutch.service.AdminService;

import lombok.ToString;
import lombok.extern.log4j.Log4j;

@ToString
@Controller
@RequestMapping("/admin")
public class AdminController {

	private AdminService adminService;
	
	public AdminController(AdminService adminService) {
		this.adminService = adminService;
	}
	
	@GetMapping("/page")
	public String admin(Model model) {
		
		//성별 가입자 수
		long male = adminService.getGenderCnt("남성");
		long female = adminService.getGenderCnt("여성");
	
		model.addAttribute("male", male );
		model.addAttribute("female", female );
		
		//연령대별 가입자 수
		long teenager = adminService.getAgeCnt("10");
		long twenties = adminService.getAgeCnt("20");
		long thirties = adminService.getAgeCnt("30");
		long forties = adminService.getAgeCnt("40");
		long fifties = adminService.getAgeCnt("50");
		long sixties = adminService.getAgeCnt("60");
		long seventies = adminService.getAgeCnt("70");
		long eighties = adminService.getAgeCnt("80");
		model.addAttribute("teenager", teenager );
		model.addAttribute("twenties", twenties );
		model.addAttribute("thirties", thirties );
		model.addAttribute("forties", forties );
		model.addAttribute("fifties", fifties );
		model.addAttribute("sixties", sixties );
		model.addAttribute("seventies", seventies );
		model.addAttribute("eighties", eighties );
		
		//월별 가입자 수
		List<AdminDTO> registerList = adminService.getMonthlyRegisterCnt();
		model.addAttribute("registerList", registerList );
		System.out.println("=============registerList : " + registerList);
		
		//더치페이방 신고수, 커뮤니티 신고수 카운트
		AdminDTO reportDTO = adminService.getReportCnt() ;
		model.addAttribute("reportDTO", reportDTO);
		System.out.println("========컨트롤러 reportDTO : " + reportDTO);
		
		
		return "pages/adminPage";
	}

}
