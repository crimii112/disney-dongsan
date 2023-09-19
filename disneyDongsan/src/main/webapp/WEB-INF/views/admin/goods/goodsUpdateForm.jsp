<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<script type="text/javascript">
	$(function(){
		$("#goodsUpdateBtn").click(function(){
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
				
				$("#f_updateForm").attr({
					"method":"post",
					"enctype":"multipart/form-data",
					"action":"/admin/goodsUpdate"
				});
				$("#f_updateForm").submit();
			}
		});
	
		$("#goodsCancelBtn").click(function(){
			$("#f_updateForm").each(function(){
				this.reset();
			});
		});
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
			<h1>굿즈 수정</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<form action="/admin/goodsUpdateForm" method="post" id="f_updateForm">
                    		<input type="hidden" id="g_id" name="g_id" value="${updateData.g_id} " />
							<input type="hidden" id="g_image" name="g_image" value="${updateData.g_image}" />
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 이름</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_name" id="g_name" value="${updateData.g_name}">
                    			</div>
                    		</div>
                    		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 상세 정보</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_detail" id="g_detail" value="${updateData.g_detail}">
                    			</div>
                    		</div>
                           
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_price" id="g_price" value="${updateData.g_price}">
                    			</div>
                    		</div>               
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>원산지</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_origin" id="g_origin" value="${updateData.g_origin}">
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>제조사</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_company" id="g_company" value="${updateData.g_company}">
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>배송업체</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="g_delivery" id="g_delivery" value="${updateData.g_delivery}">
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
	                    		<button type="button" id="goodsUpdateBtn" class="btn insert_btn">수정</button>
								<button type="button" id="goodsCancelBtn" class="btn delete_btn">취소</button>
								<button type="button" id="goodsListBtn" class="btn btn-success">목록</button>
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