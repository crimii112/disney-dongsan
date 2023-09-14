<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
</head>
<body>
	<div>
		<h2>회원 정보 수정</h2>
		<form id="updateInfoForm">
			아이디 : ${Member.memberId}<br>
			이름 : ${Member.memberName}<br><br>
			
			전화번호 
			<div>
				<input type="text" id="memberPhone" name="memberPhone">
				<button type="button" id="sendSmsBtn">인증번호 보내기</button>
				<div>
					<input type="text" id="veriNum" placeholder="인증번호 입력">
					<button type="button" id="phoneCheckBtn">확인</button>
				</div>
			</div>
			<br>
			이메일
			<div>
				<input type="text" id="memberEmail" name="memberEmail" placeholder="변경할 이메일을 입력해주세요." />
				<button type="button" id="emailtestBtn" >인증번호 전송</button>
				<div>
					<input type="text" id="emailtest" name="emailtest" placeholder="인증번호 입력"/>
					<span id="emailConfirm"></span>
	                <button type="button" id="emailtestBtn2" >이메일 인증</button>
				</div>
			</div>
			<br>
			주소
			<div>
				<input class="selectAddress" value="F" type="hidden">
				<input type="text" readonly="readonly" id="memberAddr1" name="memberAddr1" placeholder="우편번호"/>
				<button type="button" id="findAddrBtn">주소 찾기</button><br>
				<input type="text" readonly="readonly" id="memberAddr2" name="memberAddr2" placeholder="주소" />
                <input type="text" readonly="readonly" id="memberAddr3" name="memberAddr3" placeholder="상세주소" />
			</div>
		</form>
	</div>
</body>
</html>