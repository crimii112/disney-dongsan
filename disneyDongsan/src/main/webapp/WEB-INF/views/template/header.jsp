<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page trimDirectiveWhitespaces="true"%>
<div>
	<div class="right">
		<div class="login_div">
			<c:if test="${empty Member}">
				<a href="/member/loginForm" class="login_div_a" id="login">로그인</a>
				<a href="/member/signupTos" class="login_div_a" id="signup">회원가입</a> 
			</c:if>
			<c:if test="${not empty Member}">
				<a href="/member/logout" class="login_div_a" id="logout">로그아웃</a> 
			</c:if>
			
			<a href="/member/updateMemberInfoForm" class="login_div_a" id="mypage">마이페이지</a>
			<a href="#" class="login_div_a" id="basket">장바구니</a>
		</div>
	</div>
	<div class="logo_background">
		<div class="logo">
			<a href="/" title="홈으로"><img id="logoImg"
				src="/resources/include/img/disney_dongsan.png" /></a>
		</div>
	</div>
	<div class="dropdown-bar">
		<div class="dropdowun_body">

			<div class="dropdowun_main">
				<ul class="list">
					<li class="item"><a href="#" class="link">예매</a>
						<div class="dropdown_div">
							<ul class="dropdown-content">
								<li><a href="/ticket/allDayTicketView">예매하기</a></li>
								<li><a href="#">제휴카드</a></li>
							</ul>
						</div></li>
					<li class="item"><a href="#" class="link">즐길거리</a>
						<div class="dropdown_div">
							<ul class="dropdown-content">
								<li><a href="#">추천동선</a></li>
								<li><a href="#">시설안내</a></li>
							</ul>
						</div></li>
					<li class="item"><a href="#" class="link">굿즈몰</a>
						<div class="dropdown_div">
							<ul class="dropdown-content">
								<li><a href="/goods/goodsList/">굿즈판매</a></li>
							</ul>
						</div></li>
					<li class="item"><a href="#" class="link">이벤트</a>
						<div class="dropdown_div">
							<ul class="dropdown-content">
								<li><a href="#">이벤트</a></li>
							</ul>
						</div></li>
					<li class="item"><a href="#" class="link">이용정보</a>
						<div class="dropdown_div">
							<ul class="dropdown-content">
								<li><a href="#">오시는 길</a></li>
								<li><a href="#">이용시간</a></li>
							</ul>
						</div></li>
					<li class="item"><a href="#" class="link">고객센터</a>
						<div class="dropdown_div">
							<ul class="dropdown-content">
								<li><a href="#">1:1문의</a></li>
								<li><a href="#">FAQ</a></li>
							</ul>
						</div></li>
				</ul>
			</div>

		</div>
	</div>
</div>