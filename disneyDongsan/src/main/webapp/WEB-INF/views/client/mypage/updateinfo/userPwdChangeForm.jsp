<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>Insert title here</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		let errorMsg = "${errorMsg}";
		if(errorMsg != ''){
			alert(errorMsg);
			errorMsg = '';
		};
		
		$("#pwdUpdate").prop("disabled", true);
		
		$("#chk_password").keyup(function() {
			let new_password = $("#new_password").val();
			let chk_password = $("#chk_password").val();

			console.log("member_id = " + $("#memberId").val());
			if (!chkData("#memberPasswd", "현재 비밀번호를"))
				return;
			else if (!chkData("#new_password", "변경할 비밀번호를"))
				return;
			else if (!chkData("#chk_password", "확인할 비밀번호를"))
				return;
			else if (new_password !== chk_password) {
					$('#chkmsg').text("작성시 입력한 비밀번호를 입력해 주세요.").css("color","#000099");
					$("#pwdUpdate").prop("disabled", true);
					return;
			} else{ 
						console.log("new_password=" + new_password);
						console.log("chk_password=" + chk_password);
						$('#chkmsg').text("비밀번호가 일치합니다.").css("color","#000099");
						$("#pwdUpdate").prop("disabled", false);
			}	
		});
								
			$("#pwdUpdate").click(function() {
				$.ajax({
						url : "/mypage/pwdChk",
						type : "post",
						data : $("#f_updateForm").serialize(),
						dataType : "text",
						error : function() {
							alert('시스템 오류 입니다. 관리자에 문의하세요');
							},
						success : function(resultData) {
								  if (resultData == "실패") {
										alert("현재 비밀번호가 정확하지 않습니다.");	
							} else if(resultData == "성공") {
										alert("비밀번호가 변경되었습니다.");	
										$("#f_updateForm").attr({
												"method" : "post",
												"action" : "/mypage/userPwChange"
										});
										$("#f_updateForm").submit();
										}	
									}
								});
							});
			
			});
</script>
</head>
	<body>
		<div class="content_box">
        <form id="f_updateForm" name="f_updateForm" method="post">
        
            <input type="hidden" name="memberId" id="memberId" value="${Member.memberId}">
        <div>
        	<label>현재 비밀번호</label>
        	<input type="password" id="memberPasswd" name="memberPasswd"/><br/>
            <label>변경할 비밀번호</label>
            <input type="password" id="new_password" name="new_password"/><br/>
            <label>비밀번호 확인</label>
            <input type="password" id="chk_password" name="chk_password"/><span id="chkmsg"></span>
            <br/>
            <button type="button" id="pwdUpdate">변경하기</button>
        </div>
        </form>
    </div>
	</body>
</html>