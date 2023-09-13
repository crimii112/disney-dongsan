<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css"
	href="/resources/include/css/login.css">
<script>
	$(function(){
		$("#allCheck").click(function(){
			if($("#allCheck").is(":checked"))
				$("input[name=check]").prop("checked", true);
			else 
				$("input[name=check]").prop("checked", false);
		});
		
		$("input[name=check]").click(function(){
			let total = $("input[name=check]").length;
			let checked = $("input[name=check]:checked").length;
			
			if(total != checked)
				$("#allCheck").prop("checked", false);
			else 
				$("#allCheck").prop("checked", true);
		});
		
		$("#nextBtn").click(function(){
			if($(".essential:checked").length === 3)
				location.href = "/member/signupForm";
			else {
				alert("필수 사항은 모두 선택해야합니다.");
				return;
			}
		});
	});
</script>
</head>
<body>
	<div id="container">
		<h3>서비스 이용 약관 동의</h3>
		<div id="allCheckArea">
			<input type="checkbox" id="allCheck">
			<label>네, 모두 동의합니다.</label>
		</div>
		<hr>
		<div>
			<input type="checkbox" name="check" class="essential">
			<label>(필수) 만 14세 이상입니다.</label>
		</div>
		<div>
			<input type="checkbox" name="check" class="essential">
			<label>(필수) 서비스 이용약관에 동의</label>
			<button type="button" class="button" id="serviceTosBtn">보기</button>
		</div>
		<div>
			<input type="checkbox" name="check" class="essential">
			<label>(필수) 개인정보 수집이용에 동의</label>
			<button type="button" class="button" id="privacyTosBtn">보기</button>
		</div>
		<div>
			<input type="checkbox" name="check">
			<label>(선택) 홍보 및 마케팅 이용에 동의</label>
			<button type="button" class="button" id="marketingTosBtn">보기</button>
		</div>
		<div>
			<input type="checkbox" name="check">
			<label>(선택) 마케팅 개인정보 제3자 제공 동의</label>
			<button type="button" class="button" id="marketingPrivacyTosBtn">보기</button>
		</div><br>
		<div>
			<button type="button" class="form-control button" id="nextBtn">다음</button>
		</div><br>
		<div class="text-center" id="infoArea">
			'선택'항목에 동의하지 않아도 서비스 이용이 가능합니다. <br>
			개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있으며, <br>
			동의 거부시 회원체 서비스 이용이 제한됩니다.
		</div>
	</div>
</body>
</html>