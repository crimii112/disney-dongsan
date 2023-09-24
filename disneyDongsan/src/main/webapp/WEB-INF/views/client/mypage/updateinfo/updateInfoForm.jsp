<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	let phoneCheckStatus = false;
	let emailCheckStatus = false;
	
	$(function(){
		let errorMsg = "${errorMsg}";
		if(errorMsg != ''){
			alert(errorMsg);
			errorMsg = '';
		};
		
		/* 전화번호 모달 : 전화번호 input keydown 이벤트 */
		$("#memberPhone").keydown(function(){
			$("#phoneChkSpan").html('');
		});
		
		/* 전화번호 모달 : 인증번호 보내기 클릭 시 이벤트 */
		$("#sendSmsBtn").click(function(){
			phoneCheckStatus = false;

			let memberPhone = $("#phone").val();
			let inputPhone = $("#memberPhone").val();

			$("#to").val(inputPhone);
			
			if (!chkData("#memberPhone","전화번호를"))		return;
			else if (!phoneValidation("#memberPhone"))		return;
			else if(memberPhone == inputPhone){
				$("#phoneChkSpan").html("현재 등록된 휴대전화 정보와 동일합니다.").css("color", "red");
				$("#memberPhone").select();
			} else {
				$("#veriNum").focus();
				$.ajax({
					url:"/sms/send",
					type:"post",
					data:$("#sendSmsForm").serialize(),
					success: function(data){
						phoneCheckStatus = false;
						console.log(data.statusName);
						if(data.statusName == "success"){
							/* 인증번호 확인 버튼 클릭 시 이벤트 */
							$("#phoneChkSpan").html('인증번호를 발송했습니다.');
							$("#phoneCheckBtn").unbind("click").bind("click", function(){
								let veriNum = $("#veriNum").val();
								if(data.createSmsKey == veriNum){
									phoneCheckStatus = true;
									$("#phoneChkSpan").html('인증을 성공하였습니다.');
									
									$("#updatePhoneForm").attr({
										"method":"post",
										"action":"/member/updateInfoPhone"
									});
									$("#updatePhoneForm").submit();
								
								} else {
									phoneCheckStatus = false;
									$("#phoneChkSpan").html('인증번호가 올바르지 않습니다. 확인 후 다시 입력해 주세요.').css("color", "red");
								}
							});
						}
					},
					error: (xhr, textStatus, errorThrown) => {
						phoneCheckStatus = false;
			        	alert("시스템 오류입니다. 관리자에게 문의하세요.");
			        }
				});
			}
		});
		
		/* 전화번호 모달창 벗어났을 때 값 초기화 */
		$("#phoneModal").on("hidden.bs.modal", function(e){
			$("#memberPhone").val('');
			$("#veriNum").val('');
			$("#phoneChkSpan").html('');
		});
		
		
		/* 이메일 인증번호 보내기 버튼 클릭 시 이벤트*/		
		$("#emailtestBtn").click(function(){
			if(!chkData("#memberEmail", "이메일을")) return;
			else if (!emailValidation("#memberEmail"))		return;
			else {
				const memberEmail = $("#memberEmail").val(); // 사용자가 입력한 이메일을 가져옴
	 	        $.post("/mail/process", { memberEmail: memberEmail }, function(response){
	 	        	//서버로부터 받은 응답을 처리
	 	        	randomString = response;
	 	        	console.log(response);
	 	        	$("#emailConfirm").html('인증번호가 발송되었습니다').css("color","green");
	 	        	$("#emailtest").focus();
	 	        	emailCheckStatus = false;
	 	        	
	 	        	/* 이메일 인증번호 확인 버튼 클릭 시 이벤트 */
	 	        	$("#emailtestBtn2").click(function() {
	 	    	    	if(!chkData("#emailtest", "인증번호를")) return;
	 	    	         
	 	    	    	//인증번호 일치하는지 확인
	 	    	    	if($("#emailtest").val()==randomString){
	 	    	        	$('#emailConfirm').html('인증되었습니다').css('color', 'green'); 
	 	    	    		emailCheckStatus = true;
	 	    	    		
	 	    	    		$("#updateEmailForm").attr({
								"method":"post",
								"action":"/member/updateInfoEmail"
							});
							$("#updateEmailForm").submit();
	 	    	    	} else {
	 	    	        	$('#emailConfirm').html('인증번호가 일치하지 않습니다').css('color', 'red'); 
	 	    	    	}
	 	    	    	console.log("randomString:"+randomString);
	 	    	    	console.log("사용자 입력값:"+$("#emailtest").val());
	 	    	   	});
	 	        });
			}
 	        
 	    });
		
		/* 이메일 모달창 벗어났을 때 값 초기화 */
		$("#emailModal").on("hidden.bs.modal", function(e){
			$("#memberEmail").val('');
			$("#emailtest").val('');
			$("#emailConfirm").html('');
		});
		
		/* 주소 찾기 버튼 클릭 시 이벤트 */
		$("#findAddrBtn").click(function(){
			findAddr();
		});
		
		/* 주소 변경 버튼 클릭 시 이벤트 */
		$("#updateAddr").click(function(){
			if (!chkData("#memberAddr1","주소를")){ findAddr();	return;}
			else if (!chkData("#memberAddr3","상세 주소를"))	return;
			else {
				$("#updateAddrForm").attr({
					"method":"post",
					"action":"/member/updateInfoAddr"
				});
				$("#updateAddrForm").submit();
			}
		});
		
		/* 주소 모달창 벗어났을 때 값 초기화 */
		$("#addrModal").on("hidden.bs.modal", function(e){
			$("#memberAddr1").val('');
			$("#memberAddr2").val('');
			$("#memberAddr3").val('');
		});
	});
	
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
	<div>
		<h2>회원 정보 수정</h2>
		<form id="sendSmsForm">
			<input type="hidden" id="to" name="to">
		</form>
		<form id="updateInfoForm">
			아이디 : ${Member.memberId}<br> 이름 : ${Member.memberName}<br>
			<br> 전화번호
			<div>
				<input type="text" id="phone" name="phone" value="${Member.memberPhone}" readonly="readonly">
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#phoneModal">수정</button>
			</div>
			<br> 이메일
			<div>
				<input type="text" id="email" name="email" value="${Member.memberEmail}" readonly="readonly">
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#emailModal">수정</button>
			</div>
			<br> 주소
			<div>
				<p>${Member.memberAddr2} &nbsp;${Member.memberAddr3}&nbsp;(${Member.memberAddr1})</p>
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addrModal">수정</button>
				
			</div>
		</form>
	</div>

	<%-- ===================== 모달창 - 전화번호 ===================== --%>
	<div class="modal fade" id="phoneModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalToggleLabel">전화번호 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h5><strong>${Member.memberName}</strong>님의 회원정보 중 전화번호를 수정하기 위해 인증절차가 필요합니다.</h5>
					<hr>
					<form id="updatePhoneForm">
						<input type="hidden" id="memberId" name="memberId" value="${Member.memberId}">
						<p>${Member.memberPhone}</p>
						<input type="text" id="memberPhone" name="memberPhone" placeholder="전화번호">
						<button type="button" id="sendSmsBtn" class="btn btn-primary">인증번호 보내기</button>
						<input type="text" id="veriNum" placeholder="인증번호 입력">
						<br><span id="phoneChkSpan"></span>	
					</form>
					
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="phoneCheckBtn">변경</button>
				</div>
			</div>
		</div>
	</div>

	<%-- ===================== 모달창 - 이메일 ===================== --%>
	<div class="modal fade" id="emailModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalToggleLabel">이메일 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h5><strong>${Member.memberName}</strong>님의 회원정보 중 이메일을 수정하기 위해 인증절차가 필요합니다.</h5>
					<hr>
					<form id="updateEmailForm">
						<input type="hidden" id="memberId" name="memberId" value="${Member.memberId}">
						<p>${Member.memberEmail}</p>
						<input type="text" id="memberEmail" name="memberEmail" placeholder="이메일">
						<button type="button" id="emailtestBtn" class="btn btn-primary">인증번호 보내기</button>
						<input type="text" id="emailtest" name="emailtest" placeholder="인증번호 입력" /> 
						<br><span id="emailConfirm"></span>	
					</form>
					
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="emailtestBtn2">변경</button>
				</div>
			</div>
		</div>
	</div>

	<%-- ===================== 모달창 - 주소 ===================== --%>
	<div class="modal fade" id="addrModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalToggleLabel">주소 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="updateAddrForm">
						<input type="hidden" id="memberId" name="memberId" value="${Member.memberId}">
						<input class="selectAddress" value="F" type="hidden"> 
						<input type="text" readonly="readonly" id="memberAddr1" name="memberAddr1" placeholder="우편번호" />
						<button type="button" id="findAddrBtn">주소 찾기</button>
						<br>
						<input type="text" readonly="readonly" id="memberAddr2" name="memberAddr2" placeholder="주소" /> 
						<input type="text" readonly="readonly" id="memberAddr3" name="memberAddr3" placeholder="상세주소" />
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="updateAddr">저장</button>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>