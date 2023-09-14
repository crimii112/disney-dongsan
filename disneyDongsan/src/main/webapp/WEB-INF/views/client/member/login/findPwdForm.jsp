<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/login.css">
<script>
	$(function(){
		let errorMsg = "${errorMsg}";
		if(errorMsg != ''){
			alert(errorMsg);
			errorMsg = '';
		};
		
		/* 이메일 인증번호 보내기 버튼 클릭 시 이벤트*/		
		$("#findPwdBtn").click(function(){
			if(!chkData("#memberId", "아이디를")) return;
			else if(!chkData("#memberEmail", "이메일을")) return;
			else {
				$.ajax({
					url: "/member/findPwdMemberExists",
					type: "post",
					data: $("#findPwdForm").serialize(),
					dataType: "text",
					success: function(data){
						if(data == "success"){
							console.log("회원 존재 : success");
							sendTempPwd();
						} else {
							alert("입력하신 회원 정보가 없습니다. 다시 확인해 주세요.");
							$("#memberId").select();
						}
					}, 
					error: function(){
						alert("시스템 오류입니다. 관리자에게 문의하세요");
					}
				});
			}
 	        
 	    });
	});
	
	function sendTempPwd(){
		$.ajax({
			url: "/member/sendTempPwd",
			type: "post",
			data: $("#findPwdForm").serialize(),
			dataType: "text",
			success: function(data){
				let state = data.substring(0,7);
				let tempPwd = data.substring(7);
				
				if(state == "success"){
					$("#memberPasswd").val(tempPwd);
					$("#findPwdForm").attr({
						"method":"post",
						"action":"/member/updatePwd"
					});
					$("#findPwdForm").submit();
				} else {
					alert("인증번호 전송 실패. 다시 시도해주세요.");
				}
			},
			error: function(){
				alert("시스템 오류입니다. 관리자에게 문의하세요.");
			}
		});
	}
</script>
</head>
<body>
	<div id="container">
		<h3 class="text-center findPwd-title">FIND PASSWORD</h3>
		<h5 class="text-center">입력된 이메일로 임시 비밀번호가 전송됩니다.</h5>
		<hr>
		<form id="findPwdForm">
			<input type="hidden" id="memberPasswd" name="memberPasswd" />
			<div class="form-group">
				<input type="text" id="memberId" name="memberId" placeholder="ID" class="form-control" />
			</div>
			<div class="form-group">
				<input type="text" id="memberEmail" name="memberEmail" placeholder="EMAIL" class="form-control" />
			</div>
			<div class="form-group">
				<input type="button" class="form-control button" id="findPwdBtn" value="임시비밀번호 전송" />
			</div>
		</form>
		
	</div>
</body>
</html>