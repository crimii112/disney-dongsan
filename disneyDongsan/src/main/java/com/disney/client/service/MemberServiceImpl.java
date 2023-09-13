package com.disney.client.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.MemberDAO;
import com.disney.vo.MemberVO;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberDAO memberDAO;
	
	@Override
	public MemberVO login(MemberVO mvo) {
		MemberVO memberVO = null;
		memberVO = memberDAO.login(mvo);
		return memberVO;
	}

	@Override
	public MemberVO findId(MemberVO mvo) {
		MemberVO memberVO = null;
		memberVO = memberDAO.findId(mvo);
		return memberVO;
	}

	@Override
	public int idCheck(MemberVO mvo) {
		int result = memberDAO.idCheck(mvo);
		return result;
	}

	@Override
	public int signup(MemberVO mvo) {
		int result = memberDAO.signup(mvo);
		return result;
	}

	@Override
	public int withdrawal(MemberVO mvo) {
		int result = memberDAO.withdrawal(mvo);
		return result;
	}

}
