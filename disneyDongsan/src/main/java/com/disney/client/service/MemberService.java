package com.disney.client.service;

import com.disney.vo.MemberVO;

public interface MemberService {
	public MemberVO login(MemberVO mvo);
	public MemberVO findId(MemberVO mvo);
	public int idCheck(MemberVO mvo);
	public int signup(MemberVO mvo);
	public int withdrawal(MemberVO mvo);
}
