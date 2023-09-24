<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript">
				$(function() {
					$(".nav-link").click(function() {
						$(".nav-link").removeClass("active");
						$(this).addClass("color");
					});
				});
			</script>
	</head>
	<body>
		<div class="mypage_side col-3">
				<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary"
					style="width: 280px; height: 100%;">
					<a href="/mypage/pwdChkForm"
						class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
						<svg class="bi pe-none me-2" width="40" height="32">
							<use xlink:href="#bootstrap" /></svg> <span class="fs-4">MyPage</span>
					</a>
					<hr>
					<ul class="nav nav-pills flex-column mb-auto">
					
						<li class="nav-item">
							<a href="/mypage/pwdChkForm" class="nav-link active" aria-current="page"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>개인정보 수정</a></li>
									
						<li><a href="/mypage/userTicketList" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>예매내역</a></li>
									
						<li><a href="/mypage/userGoodsList" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>주문내역</a></li>
									
						<li><a href="/mypage/userReviewList" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>리뷰</a></li>
									
						<li><a href="/mypage/userQAList" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>1:1문의 내역</a></li>
					</ul>
					
				</div>
			</div>
	</body>
</html>