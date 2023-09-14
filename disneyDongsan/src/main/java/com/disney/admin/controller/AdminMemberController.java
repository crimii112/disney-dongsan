package com.disney.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.disney.admin.service.AdminMemberService;
import com.disney.vo.MemberVO;

import lombok.Setter;

@Controller
@RequestMapping("/admin/member/*")
public class AdminMemberController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMemberService adminMemberService;
	
	@GetMapping("memberList")
	public String memberList(Model model) {
		List<MemberVO> memberList = adminMemberService.memberList();
	
		model.addAttribute("memberList", memberList);
		
		return "admin/member/memberList";
	}
}
