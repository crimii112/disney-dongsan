<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css"
	href="/resources/include/css/login.css">
<script>
	$(function(){
		$("#loginFormBtn").click(function(){
			location.href = "/member/loginForm";
		});
	});
</script>
</head>
<body>
	<div id="container">
		<h2 class="text-center">회원가입 완료</h2>
		<h3 class="text-center">디즈니 동산에 오신 것을 환영합니다</h3>
		<br>
		<button type="button" id="loginFormBtn" class="form-control button">로그인</button>
	</div>
</body>
</html>