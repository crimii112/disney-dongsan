<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page trimDirectiveWhitespaces="true"%>

<%@ include file="/WEB-INF/views/common/common.jspf"%>

<title>방문정보확인</title>

<link rel="shortcut icon" href="/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/resources/image/icon.png" />

<link rel="stylesheet" type="text/css"
	href="/resources/include/dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/include/dist/css/bootstrap-theme.min.css">

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">
    $(function(){
        // 결제하기 버튼
        $(document).ready(function(){ 
            $(".order_btn").click(function(){ 
                payment(); // 버튼 클릭하면 호출 
            }); 
        })
        
        var cardCompany = '${tvo.card_company}';
		var cardCode = 0;
        if (cardCompany === '삼성카드'){
        	cardCode = 365;
        } else if (cardCompany === '하나카드'){
        	cardCode = 374;
        } else if (cardCompany === '국민카드'){
        	cardCode = 381;
        } else if (cardCompany === 'BC카드'){
        	cardCode = 361;
        } else if (cardCompany === '현대카드'){
        	cardCode = 367;
        } else if (cardCompany === '농협카드'){
        	cardCode = 371;
        } else if (cardCompany === '신한카드'){
        	cardCode = 366;
        } else if (cardCompany === '우리카드'){
        	cardCode = 361;
        } else if (cardCompany === '씨티카드'){
        	cardCode = 370;
        }
        
        // 버튼 클릭하면 실행
        /* function payment(data) {
            $("#ticketPayment_data").attr({
            	"method":"post",
            	"action":"/ticket/ticketPayment"
            });
            $("#ticketPayment_data").submit();
        } */
        function payment(data) {
            IMP.init('imp02353400');
            // 결제시 전달되는 정보
            if (cardCompany) {
                // 제휴카드인 경우에만 bypass 및 card 설정 실행
                IMP.request_pay(
                    {
                        pg: 'html5_inicis.INIpayTest',
                        pay_method: 'card',
                        merchant_uid: 'merchant_' + new Date().getTime(),
                        name: '${tvo.t_category}', /*상품명*/
                        amount: '${tvo.total_price}', /*상품 가격*/
                        buyer_email: '${Member.memberEmail}' /*구매자 이메일*/,
                        buyer_name: '${Member.memberName}', /* '${memberInfo.member_name}', */
                        buyer_tel: '${Member.memberPhone}' /*구매자 연락처*/,
                        bypass: {
                            acceptmethod: "noeasypay" // 간편결제 버튼을 통합결제창에서 제외(PC)
                        },
                        card: {
                            detail: [
                                { card_code: "*", enabled: false },
                                { card_code: cardCode, enabled: true }
                            ]
                        }
                    }, function(rsp) {
                        var result = '';
                        if (rsp.success) {
                            var msg = '결제가 완료되었습니다.';
                            msg += '고유ID : ' + rsp.imp_uid;
                            msg += '상점 거래ID : ' + rsp.merchant_uid;
                            msg += '결제 금액 : ' + rsp.paid_amount;
                            msg += '카드 승인번호 : ' + rsp.apply_num;
                            result = '0';
                        } else {
                            var msg = '결제에 실패하였습니다.';
                            msg += '에러내용 : ' + rsp.error_msg;
                            result = '1';
                        }
                        if (result == '0') {
                        	$("#ticketPayment_data").attr({
                            	"method":"post",
                            	"action":"/ticket/ticketPayment"
                            });
                            $("#ticketPayment_data").submit();
                        	
                            //location.href = "/ticket/Success";
                        }
                        alert(msg);
                    });
            } else {
            	// 제휴카드 아닐때
                IMP.request_pay(
                    {
                        pg: 'html5_inicis.INIpayTest',
                        pay_method: 'card',
                        merchant_uid: 'merchant_' + new Date().getTime(),
                        name: '${tvo.t_category}', /*상품명*/
                        amount: '${tvo.total_price}', /*상품 가격*/
                        buyer_email: '${Member.memberEmail}' /*구매자 이메일*/,
                        buyer_name: '${Member.memberName}', /* '${memberInfo.member_name}', */
                        buyer_tel: '${Member.memberPhone}' /*구매자 연락처*/
                    }, function(rsp) {
                        var result = '';
                        if (rsp.success) {
                            var msg = '결제가 완료되었습니다.';
                            msg += '고유ID : ' + rsp.imp_uid;
                            msg += '상점 거래ID : ' + rsp.merchant_uid;
                            msg += '결제 금액 : ' + rsp.paid_amount;
                            msg += '카드 승인번호 : ' + rsp.apply_num;
                            result = '0';
                        } else {
                            var msg = '결제에 실패하였습니다.';
                            msg += '에러내용 : ' + rsp.error_msg;
                            result = '1';
                        }
                        if (result == '0') {
                        	$("#ticketPayment_data").attr({
                            	"method":"post",
                            	"action":"/ticket/ticketPayment"
                            });
                            $("#ticketPayment_data").submit();
                        	
                            //location.href = "/ticket/Success";
                        }
                        alert(msg);
                    });
            }
        }
    })
</script>

	</head>
	<body>
		<form name="ticketPayment_data" id="ticketPayment_data" method="post">
			<input type="hidden" name="t_member_id" value="${Member.memberId}">
			<input type="hidden" name="t_category" value="${tvo.t_category}" />
			<input type="hidden" name="visit_date" value="${tvo.visit_date}" />
			<input type="hidden" name="t_afternoon" value="${tvo.t_afternoon}" />
			<input type="hidden" name="t_multi" value="${tvo.t_multi}" />
			<input type="hidden" name="t_adult" value="${tvo.t_adult}" />
			<input type="hidden" name="t_student" value="${tvo.t_student}" />
			<input type="hidden" name="t_child" value="${tvo.t_child}" />
			<input type="hidden" name="allday_price" value="${tvo.allday_price}" />
			<input type="hidden" name="total_price" value="${tvo.total_price}" />
			<input type="hidden" name="card_company" value="${tvo.card_company}" />
		</form>
		<h1>방문 정보 확인</h1>
		
		<div>
			<h3>방문자 정보</h3>
			<table class="table table-bordered" style=width:500px;>
				<tr>
					<td>이름</td>
					<td><input type="text" value="${Member.memberName}" readonly/></td>
				</tr>
				<tr>
					<td>휴대폰 번호</td>
					<td><input type="text" value="${Member.memberPhone}" readonly/></td>
				</tr>
				<tr>
					<td>이메일 주소</td>
					<td><input type="text" value="${Member.memberEmail}" readonly/></td>
				</tr>
			</table>
		</div>
		
		<div>
			<h3>방문 정보</h3>
			<table class="table table-bordered" style=width:500px;>
				<tr>
					<td>티켓</td>
					<td>${tvo.t_category}</td>
				</tr>
				<tr>
					<td>방문 날짜</td>
					<td>${tvo.visit_date}</td>
				</tr>
				
				<c:choose>
			        <c:when test="${tvo.t_afternoon != 0}">
			            <tr>
			                <td>오후권</td>
			                <td>${tvo.t_afternoon}명</td>
			            </tr>
			        </c:when>
			    </c:choose>
			    <c:choose>
			        <c:when test="${tvo.t_multi != 0}">
			            <tr>
			                <td>2/3/4인권</td>
			                <td>${tvo.t_multi}인</td>
			            </tr>
			        </c:when>
			    </c:choose>
			    <c:choose>
			        <c:when test="${tvo.t_adult != 0}">
			            <tr>
			                <td>대인</td>
			                <td>${tvo.t_adult}명</td>
			            </tr>
			        </c:when>
			    </c:choose>
			    <c:choose>
			        <c:when test="${tvo.t_student != 0}">
			            <tr>
			                <td>청소년</td>
			                <td>${tvo.t_student}명</td>
			            </tr>
			        </c:when>
			    </c:choose>
			    <c:choose>
			        <c:when test="${tvo.t_child != 0}">
			            <tr>
			                <td>소인/경로</td>
			                <td>${tvo.t_child}명</td>
			            </tr>
			        </c:when>
			    </c:choose>
				
				<c:choose>
			        <c:when test="${tvo.allday_price != 0}">
			            <tr>
			                <td>티켓 금액</td>
			                <td>${tvo.allday_price}명</td>
			            </tr>
			        </c:when>
			    </c:choose>

				<tr>
					<td>결제 금액</td>
					<td>${tvo.total_price}원</td>
				</tr>

				<c:if test="${not empty tvo.card_company}">
				    <tr>
				        <td>제휴카드</td>
				        <td>${tvo.card_company}</td>
				    </tr>
				</c:if>
			</table>
			<input type="button" value="결제하기" class="order_btn btn btn-success" />
		</div>
	</body>
</html>