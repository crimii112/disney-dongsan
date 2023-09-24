<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<tiles:insertDefinition name="mypageMain"/>


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>Insert title here</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
<link rel="stylesheet"  href="/resources/include/css/mypage.css" />
</head>
<body>

	<div class="main_div">
		<!-- header -->
		<div class="login_div">
			<a href="client/test2" class="login_div_a" id="logout">로그아웃</a> <a
				href="#" class="login_div_a" id="mypage">마이페이지</a> <a href="#"
				class="login_div_a" id="basket">장바구니</a>
		</div>
		<div class="logo_background">
			<div class="logo">
				<a href="#" title="홈으로"><img id="logoImg"
					src="/resources/img/disney_dongsan.png" /></a>
			</div>
		</div>
		<!-- header 끝 -->
		<!-- 사이드바 -->
		
			<div class="body_div">
				<ul>
					<li><a class="active">마이페이지</a></li>
					<li><a class="item" href="/mypage/pwdChkForm">개인정보 수정</a></li>
					<li><a class="item" href="/mypage/changPasswordForm">비밀번호 변경</a></li>
					<li><a class="item" href="/mypage/userTicketList">티켓예매 확인</a></li>
					<li><a class="item" href="/mypage/userGoodsList">굿즈주문 확인</a></li>
					<li><a class="item" href="/mypage/userReviewList">굿즈리뷰</a></li>
					<li><a class="item" href="/mypage/userReviewList">1:1 문의</a></li>
				</ul>
			
		
		<!-- 사이드바 끝 -->
		<!-- body -->
				<div class="content_box">
					<div class="pwd_div">
						<h1>개인정보를 수정하기 전에 비밀번호를 입력해주세요.</h1>
						<br/>
						<form>
							<input type="password">
							<button type="button">입력</button>
						</form>
						
					</div>
				</div>
			</div>
		<!-- body끝 -->
		</div>
		<!-- footer -->

		
		<footer>
			<div class="inner">
				<div class="footer-company">
					<label >© Disney. All rights reserved.</label>
				</div>
			</div>
			
			<div>
				<div class="footer-location">
					<a href="#"><label >디즈니 동산 위치</label></a>
				</div >
				
				<div class="footer-primary">
					<a href="#"><label >개인정보방침</label></a>
				</div>
			
				<div class="flatform-item">
					<a href="#"><img
							src="/resources/img/facebookLogo.png" style="width: 30px"/></a>
					<a href="#"><img
							src="/resources/img/instaLogo.png" /></a>
				</div>
			</div>
		</footer>
	
</body>
</html> --%>