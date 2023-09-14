<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/login.css">
<script>
	let phoneVeriStatus = false;
	
	$(function(){
		$("#findIdBtn").click(function(){
			if(phoneVeriStatus == false) {
				alert("전화번호 인증을 해주세요.");
				return;
			} else {
				$("#findIdForm").attr({
					"method":"post",
					"action":"/member/findId"
				});
				$("#findIdForm").submit();
			}
		});
		
		/* 전화번호 인증번호 보내기 버튼 클릭 시 이벤트 */
		$("#sendMsgBtn").click(function(){
			phoneVeriStatus = false;
			$("#veriNum").val('');
			$("#veriNum").focus();
			
			if(!chkData("#memberName", "이름을")) return;
			else if(!chkData("#memberPhone", "전화번호를"))	return;
			else if(!phoneValidation("#memberPhone"))	return;
			else {
				$.ajax({
					url:"/member/findIdMemberExists",
					type:"post",
					data:$("#findIdForm").serialize(),
					dataType:"text",
					success: function(data){
						console.log(data);
						if(data == "success"){
							sendSms();
							return;
						} else {
							alert("입력하신 정보가 회원정보와 일치하지 않습니다.");
							$("#memberName").val('');
							$("#memberPhone").val('');
							$("#memberName").focus();
						}
					},
					error: (xhr, textStatus, errorThrown) => {
			        	alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
			        }
				});
			};
			
		});
	});
	
	function sendSms(){
		let phone = $("#memberPhone").val();
		$("#to").val(phone);
		
		$.ajax({
			url:"/sms/send",
			type:"post",
			data:$("#sendSmsForm").serialize(),
			success: function(data){
				console.log(data.statusName);
				if(data.statusName == "success"){
					console.log(data.createSmsKey);
					alert("인증번호를 발송했습니다.");
					$("#phoneCheckBtn").unbind("click").bind("click", function(){
						let veriNum = $("#veriNum").val();
						if(data.createSmsKey == veriNum){
							phoneVeriStatus = true;
							alert("전화번호 인증 성공");
							veriNum = '';
							return;
						} else {
							alert("인증번호를 틀렸습니다. 인증번호 보내기 버튼을 다시 눌러주세요.");
						}
					});
				} else {
					alert("잠시 오류가 발생하였습니다. 관리자에게 문의하세요.");
				}
			},
			error: (xhr, textStatus, errorThrown) => {
		        alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
		    }
		});
	};
	
	/* function phoneCheckBtn(createSmsKey){
		 $("#phoneCheckBtn").click(function(){
				let veriNum = $("#veriNum").val();
				console.log(createSmsKey);
				console.log("보낸 인증번호 : " + createSmsKey);
				console.log("작성한 인증번호 : " + veriNum);
				if(createSmsKey == veriNum){
					phoneVeriStatus = true;
					alert("전화번호 인증 성공");
					veriNum = '';
					return;
				} else {
					alert("인증번호를 틀렸습니다. 인증번호 보내기 버튼을 다시 눌러주세요.");
					return;
				}
			});
	} */
</script>
</head>
<body>
	<div id="container">
		<form id="sendSmsForm">
			<input type="hidden" id="to" name="to" value="">
		</form>
		<h3 class="text-center">FIND ID</h3>
		<form id="findIdForm">
			<div class="form-group">
				<input type="text" id="memberName" name="memberName"
					placeholder="NAME" class="form-control" />
			</div>
			<div class="form-group">
				<input type="text" id="memberPhone" name="memberPhone" placeholder="PHONE" class="form-control" />
				<button type="button" class="form-control button" id="sendMsgBtn">인증번호 보내기</button>
				<input type="text" class="form-control" id="veriNum" placeholder="인증번호 입력">
				<button type="button" class="form-control button" id="phoneCheckBtn">전화번호 인증</button>
			</div>
			<div class="form-group">
				<input type="button" class="form-control button" id="findIdBtn" value="찾기" />
			</div>

		</form>
		
	</div>
</body>
</html>