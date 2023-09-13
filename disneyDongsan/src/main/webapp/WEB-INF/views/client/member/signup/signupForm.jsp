<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/login.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 중복확인 여부 확인
	let idCheckStatus = 0;
	// 이메일 인증 여부 확인
	let emailCheckStatus = false;
	// 이메일 인증 번호
	let randomString = ''; 
	// 비밀번호 확인 여부
	let pwdCheckStatus = false;
	
	$(function(){
		let errorMsg = "${errorMsg}";
		if(errorMsg != ''){
			alert(errorMsg);
			errorMsg = '';
		};
		
		/* 아이디 keydown 이벤트 */
		$("#memberId").keydown(function(){
			idCheckStatus = 0;	// 아이디 input에 값 들어가면 0으로(중복확인 안한 상태)
		});
		
		/* 아이디 중복확인 버튼 클릭 시 이벤트 */
		$("#idCheckBtn").click(function(){
			idCheckStatus = 1;	// 중복확인 버튼 누른 상태
			$("#idChkMsg").css("visibility","visible");
			memberIdChk();
		});
		
		/* 비밀번호 입력란 keyup 이벤트 */
		$("#memberPasswd").keyup(function(){
			pwdCheckStatus = false;
			$("#pwdCheckSpan").text('');
		});
		
		/* 비밀번호 확인 입력란 keyup 이벤트 */
		$("#memberPwdCheck").keyup(function(){
			let memberPwd = $("#memberPasswd").val();
			if(memberPwd == $("#memberPwdCheck").val()){
				pwdCheckStatus = true;
				$("#pwdCheckSpan").text("비밀번호 일치").css("color", "green");
			} else {
				pwdCheckStatus = false;
				$("#pwdCheckSpan").text("비밀번호 불일치").css("color", "red");
			}
		});
		
		/* 회원가입 버튼 클릭 시 이벤트 */
		$("#signupBtn").click(function(){
			if (!chkData("#memberId","아이디를"))	return;
			else if (!idValidation("#memberId")) return;
			else if (!chkData("#memberPasswd","비밀번호를"))	return;
			else if (!pwdValidation("#memberPasswd"))		return;
			else if (!chkData("#memberName","이름을"))			return;
			else if (!chkData("#memberBirth","생년월일을"))		return;
			else if (!chkData("#memberPhone","전화번호를"))		return;
			else if (!phoneValidation("#memberPhone"))		return;
			else if (!chkData("#memberEmail","이메일을"))		return;
			else if (!emailValidation("#memberEmail"))		return;
			else if (!chkData("#memberAddr1","주소를")){findAddr();	return;}
			else if (!chkData("#memberAddr3","상세 주소를"))	return;
			else if(idCheckStatus == 0) {alert("아이디 중복확인을 해주세요."); return;}
			else if(idCheckStatus == 2) {alert("이미 존재하는 아이디입니다."); return;}
			else if(pwdCheckStatus == false) {alert("비밀번호 확인을 진행해주세요"); $("#memberPwdCheck").focus(); return;}
			else if(emailCheckStatus == false){alert("이메일 인증을 해주세요"); return;}
			else {
				$("#signupForm").attr({
					"method":"post",
					"action":"/member/signup"
				});
				$("#signupForm").submit();
			}
		});
		
		/* 이메일 인증번호 보내기 버튼 클릭 시 이벤트*/		
		$("#emailtestBtn").click(function(){
			if(!chkData("#memberEmail", "이메일을")) return;
 	        const memberEmail = $("#memberEmail").val(); // 사용자가 입력한 이메일을 가져옴
 	        $.post("/mail/process", { memberEmail: memberEmail }, function(response){
 	        	//서버로부터 받은 응답을 처리
 	        	randomString = response;
 	        	console.log(response);
 	        	alert("인증번호가 발송되었습니다.");  
 	        	emailCheckStatus = false;
 	        	
 	        	/* 이메일 인증번호 확인 버튼 클릭 시 이벤트 */
 	        	$("#emailtestBtn2").click(function() {
 	    	    	if(!chkData("#emailtest", "인증번호를")) return;
 	    	         
 	    	    	//인증번호 일치하는지 확인
 	    	    	if($("#emailtest").val()==randomString){
 	    	        	$('#emailConfirm').html('인증되었습니다').css('color', 'red'); 
 	    	    		emailCheckStatus = true;
 	    	    	} else {
 	    	        	$('#emailConfirm').html('인증번호가 일치하지 않습니다').css('color', 'red'); 
 	    	    	}
 	    	    	console.log("randomString:"+randomString);
 	    	    	console.log("사용자 입력값:"+$("#emailtest").val());
 	    	   	});
 	        });
 	    });
		
		/* 주소 찾기 버튼 클릭 시 이벤트 */
		$("#findAddrBtn").click(function(){
			findAddr();
		});
	});
	
	/* 아이디 중복 확인 함수 */
	function memberIdChk() {
		if(!chkData("#memberId", "아이디를")) return;
		else {
			$.ajax({
				url: "/member/idCheck",
				type: "post",
				data: $("#signupForm").serialize(),
				dataType: "text",
				success: function(data){
					if(data === "1"){
						$("#idChkMsg").text("이미 존재하는 아이디입니다.").css("color","red");
						$("#memberId").select();
						idCheckStatus = 2;	// 존재하는 아이디인 상태 : submit하면 안됨
					} else if(data === "0"){
						$("#idChkMsg").text("사용 가능한 아이디입니다.").css("color","green");
					}
				},
				error: function(){
					alert("시스템 오류입니다. 관리자에게 문의하세요.");
				}
			});
		};
	}
	
	/* 주소 API 함수 */
	function findAddr(){
        console.log("동작");
       new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                
               	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                 var addr = ''; // 주소 변수
                 var extraAddr = ''; // 참고항목 변수
  
                 //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                 if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                     addr = data.roadAddress;
                 } else { // 사용자가 지번 주소를 선택했을 경우(J)
                     addr = data.jibunAddress;
                 }
  
                 // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                 if(data.userSelectedType === 'R'){
                     // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                     // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                     if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                         extraAddr += data.bname;
                     }
                     // 건물명이 있고, 공동주택일 경우 추가한다.
                     if(data.buildingName !== '' && data.apartment === 'Y'){
                         extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                     }
                     // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                     if(extraAddr !== ''){
                         extraAddr = ' (' + extraAddr + ')';
                     }
                     // 추가해야할 코드
                     // 주소변수 문자열과 참고항목 문자열 합치기
                       addr += extraAddr;
                 
                 } else {
                    addr += ' ';
                 }
  
                 // 제거해야할 코드
                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
                 $("#memberAddr1").val(data.zonecode);
                 $("#memberAddr2").val(addr);            
                 // 커서를 상세주소 필드로 이동한다.
                 $("#memberAddr3").attr("readonly", false);
                 $("#memberAddr3").focus();    
            }
        }).open();     
    }

</script>
</head>
<body>
	<div id="signupContainer">
		<form id="phoneForm">
			<input type="hidden" id="to" name="to" value="">
		</form>
		<h3 class="text-center">Create Your Account</h3>
		<div>
			<form id="signupForm">
				<div class="row form-group">
					<label class="label">아이디</label>
					<div>
						<input type="text" class="form-control" id="memberId" name="memberId" placeholder="5~12자로 입력해주세요" />
						<button type="button" class="form-control button" id="idCheckBtn">중복확인</button>
						<span id="idChkMsg"></span>
					</div> 
				</div>
				<div class="row form-group">
					<label class="label">비밀번호</label> 
					<input type="password" class="form-control" id="memberPasswd" name="memberPasswd" placeholder="영문/숫자/특수문자(!@#$%^&*)를 포함하여 8~16자로 입력해주세요"/>
				</div>
				<div class="row form-group">
					<label class="label">비밀번호 확인</label> 
					<input type="password" class="form-control" id="memberPwdCheck" name="memberPwdCheck" />
					<span id="pwdCheckSpan"></span>
				</div>
				<div class="row form-group">
					<label class="label">이름</label> 
					<input type="text" class="form-control" id="memberName" name="memberName" />
				</div>
				<div class="row form-group">
					<label class="label">생년월일</label> 
					<input type="date" class="form-control" id="memberBirth" name="memberBirth" />
				</div>
				<div class="row form-group">
					<label class="label">전화번호</label> 
					<input type="text" class="form-control" id="memberPhone" name="memberPhone" placeholder="'-'는 제외하고 입력해주세요"/>
					<button type="button" class="form-control button" id="sendMsgBtn">인증번호 보내기</button>
					<input type="text" class="form-control" id="veriNum" placeholder="인증번호 입력">
					<button type="button" class="form-control button" id="phoneCheckBtn">전화번호 인증</button>
					
				</div>
				<div class="row form-group">
					<label class="label">이메일</label> 
					<input type="text" class="form-control" id="memberEmail" name="memberEmail" placeholder="이메일을 입력해주세요." />
					<button type="button" id="emailtestBtn" class="form-control button">인증번호 전송</button>
					<input type="text" class="form-control" id="emailtest" name="emailtest" placeholder="인증번호 입력"/>
					<span id="emailConfirm"></span>
                    <button type="button" id="emailtestBtn2" class="form-control button">이메일 인증</button>
				</div>
				<div class="row form-group">
					<label class="label">주소</label> 
					<input class="selectAddress" value="F" type="hidden">
					<input type="text" readonly="readonly" id="memberAddr1" name="memberAddr1" placeholder="우편번호"/>
					<button type="button" id="findAddrBtn">주소 찾기</button>
					<input type="text" readonly="readonly" id="memberAddr2" name="memberAddr2" placeholder="주소" />
                    <input type="text" readonly="readonly" id="memberAddr3" name="memberAddr3" placeholder="상세주소" />
				</div>
				<div class="row form-group">
					<input type="button" class="form-control button" id="signupBtn" value="회원가입" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>