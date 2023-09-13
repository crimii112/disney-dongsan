<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/login.css">
<script>
	$(function(){
		$("#loginFormBtn").click(function(){
			location.href = "/member/loginForm";
		});
		
		$("#findPwdFormBtn").click(function(){
			location.href = "/member/findPwdForm";
		});
	});
</script>
</head>
<body>
	<div id="container">
		<div id="findIdSuccess">
			<h4 class="text-center">입력하신 정보와 일치하는 아이디입니다.</h4>
			<br>
			<table class="table">
				<tr>
					<td class="text-center">아이디</td>
					<td>${member.memberId}</td>
				</tr>
				<tr>
					<td class="text-center">가입일</td>
					<td>${member.memberRegdate}</td>
				</tr>
				<tr>
					<td>
						<button type="button" id="loginFormBtn" class="form-control button">로그인</button>
					</td>
					<td>
						<button type="button" id="findPwdFormBtn" class="form-control button">비밀번호찾기</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>