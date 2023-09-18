package com.disney.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.admin.service.AdminLoginService;
import com.disney.vo.AdminVO;

import lombok.Setter;

@Controller
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminLoginService adminLoginService;
	
	@GetMapping("/admin")
	public String adminLoginForm() {
		return "admin/login/adminLogin";
	}
	
	@PostMapping("/admin/adminLogin")
	public String adminLogin(AdminVO avo, RedirectAttributes ras) {
		String url = "";
		
		AdminVO admin = adminLoginService.adminLogin(avo);
		
		if(admin != null) {
			url = "admin/adminPage";
		} else {
			ras.addFlashAttribute("errorMsg", "관리자 로그인 실패");
			url = "admin";
		}
		
		return "redirect:/" + url;
	}
	
	@GetMapping("/admin/adminPage")
	public String adminPage() {
		return "admin/adminPage";
	}
}
