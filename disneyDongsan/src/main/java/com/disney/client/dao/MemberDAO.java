package com.disney.client.dao;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.MemberVO;

@Mapper
public interface MemberDAO {
	/* 로그인 */
	public MemberVO login(MemberVO mvo);
	
	/* 아이디 찾기 */
	public MemberVO findId(MemberVO mvo);
	
	/* 아이디 중복확인 */
	public int idCheck(MemberVO mvo);
	
	/* 회원가입 */
	public int signup(MemberVO mvo);
	
	/* 탈퇴 */
	public int withdrawal(MemberVO mvo);
}
