<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/login.css">

<script type="text/javascript">
	$(function(){
		let errorMsg = "${errorMsg}";
		if(errorMsg != ""){
			alert(errorMsg);
			errorMsg = "";
		};
		
		$("#loginBtn").click(function(){
			if(!chkData("#memberId", "아이디를")) return;
			else if(!chkData("#memberPasswd", "비밀번호를")) return;
			else {
				$("#loginForm").attr({
					"method" : "post",
					"action" : "/member/login"
				});
				$("#loginForm").submit();
			}
		});
		
		$("#findIdBtn").click(function(){
			location.href = "/member/findIdForm";
		});

		$("#findPwdBtn").click(function(){
			location.href = "/member/findPwdForm";
		});
		
		$("#signUpFormBtn").click(function(){
			location.href = "/member/signupTos";
		});
	});
</script>
</head>
<body>
	<div id="container">
		<h3 class="text-center">Have an account?</h3>
		<form id="loginForm" class="loginForm">
			<div class="form-group text-center">
				<input type="text" id="memberId" name="memberId" placeholder="ID" class="form-control" />
			</div>
			<div class="form-group text-center">
				<input type="password" id="memberPasswd" name="memberPasswd" placeholder="PASSWORD" class="form-control" />
			</div>
			<div class="form-group text-center">
				<input type="button" class="form-control button btn-secondary" id="loginBtn" value="로그인" />
			</div>
			<div class="text-center">
				<button type="button" class="btn" id="findIdBtn">아이디 찾기</button>|
				<button type="button" class="btn" id="findPwdBtn">비밀번호 찾기</button>|
				<button type="button" class="btn" id="signUpFormBtn">회원가입</button>
			</div>
		</form>
	</div>
</body>
</html>