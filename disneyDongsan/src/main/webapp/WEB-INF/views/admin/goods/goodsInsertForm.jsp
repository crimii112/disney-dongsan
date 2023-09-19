<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="../resources/include/css/goods/admin/goodsInsert.css">

<script type="text/javascript">
	$(function(){
		
		/* 저장 버튼 클릭 시 처리 이벤트 */
		$("#goodsInsertBtn").click(function(){
			//입력값 체크
			if (!chkData("#g_name","상품명을")) return;
			else if (!chkData("#g_detail","상품설명을")) return;
			else if (!chkData("#g_price","가격을")) return;
			else if (!chkData("#g_origin","원산지를")) return;
			else if (!chkData("#g_company","제조사를")) return;
			else if (!chkData("#g_delivery","배송업체를")) return;
			else{
				if($("#file").val()!=""){
					if(!chkFile($("#file"))) return;
				}
				
				$("#f_writeForm").attr({
					"method":"post",
					"enctype":"multipart/form-data",
					"action":"/admin/goodsInsert"
				});
				$("#f_writeForm").submit();
			}
		});
		
		/* 취소 버튼 클릭시 처리 이벤트 */
		$("#goodsCancelBtn").click(function(){
			$("#f_writeForm").each(function(){
				this.reset();
			});
		});
		/* 목록 버튼 클릭 시 처리 이벤트 */
		$("#goodsListBtn").click(function(){
			location.href="/admin/goodsList";
		});
	});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>굿즈 등록</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<form id="f_writeForm" name="f_writeForm">
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 이름</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_name" id="g_name">
                    			</div>
                    		</div>
                    		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 상세 정보</label>
                    			</div>
                    			<div class="form_section_content">
                    				<textarea rows="8" cols="105" name="g_detail" id="g_detail"></textarea>
                    			</div>
                    		</div>
                           
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_price" value="0" id="g_price">
                    			</div>
                    		</div>               
                    		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>원산지</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_origin" id="g_origin">
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>제조사</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_company" id="g_company">
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>배송업체</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_delivery" id="g_delivery">
                    			</div>
                    		</div>
                    		

                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 이미지</label>
                    			</div>
                    			<div class="form_section_content">
									<input type="file" id ="file" name='file' style="height: 30px;">
                    			</div>
                    		</div> 
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 상세 이미지</label>
                    			</div>
                    			<div class="form_section_content">
									<input type="file" id ="file_detail" name='file_detail' style="height: 30px;">
                    			</div>
                    		</div>           		
                   		</form>
                   			<div class="btn_section">
                   				<button id="goodsCancelBtn" class="btn">취 소</button>
	                    		<button id="goodsInsertBtn" class="btn insert_btn">등 록</button>
	                    		<button id="goodsListBtn" class="btn">목록</button>
	                    	</div> 
							
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
        

 <%@ include file="/WEB-INF/views/admin-template/footer.jsp"%>

	<script type="text/javascript"
		src="/resources/include/js/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script
		src="/resources/include/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script
		src="/resources/include/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/include/assets/vendor/chart.js/chart.umd.js"></script>
	<script src="/resources/include/assets/vendor/echarts/echarts.min.js"></script>
	<script src="/resources/include/assets/vendor/quill/quill.min.js"></script>
	<script
		src="/resources/include/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="/resources/include/assets/vendor/tinymce/tinymce.min.js"></script>
	<script
		src="/resources/include/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="/resources/include/assets/js/main.js"></script>
</body>
</html>