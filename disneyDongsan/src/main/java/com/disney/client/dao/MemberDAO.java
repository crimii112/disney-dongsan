package com.disney.client.dao;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.MemberVO;

@Mapper
public interface MemberDAO {
	/* 로그인 */
	public MemberVO login(MemberVO mvo);
	
	/* 아이디 찾기 전 회원 존재 여부 확인 */
	public int findIdMemberExists(MemberVO mvo);
	
	/* 아이디 찾기 */
	public MemberVO findId(MemberVO mvo);
	
	/* 아이디 중복확인 */
	public int idCheck(MemberVO mvo);
	
	/* 비밀번호 찾기 전 회원 존재 여부 확인 */
	public int findPwdMemberExists(MemberVO mvo);
	
	/* 임시 비밀번호로 변경 */
	public int updatePwd(MemberVO mvo);
	
	/* 회원가입 */
	public int signup(MemberVO mvo);
	
	/* 탈퇴 */
	public int withdrawal(MemberVO mvo);
}
