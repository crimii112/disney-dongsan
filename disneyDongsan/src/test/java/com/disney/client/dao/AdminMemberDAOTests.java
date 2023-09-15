package com.disney.client.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.disney.admin.dao.AdminMemberDAO;
import com.disney.vo.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class AdminMemberDAOTests {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMemberDAO adminMemberDAO;
	
	@Test
	public void memberListTest() {
		log.info("memberListTest 결과");
		
		MemberVO vo = new MemberVO();
		List<MemberVO> memberList = adminMemberDAO.memberList(vo);
		
		for(MemberVO mvo : memberList) {
			log.info(mvo.toString());
		}
	}
}
