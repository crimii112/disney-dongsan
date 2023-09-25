<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style>	
			.hours{text-align: center;}
			.h_time img{ width: 80px; height: 80px;margin-bottom: 25px;}
			#hoursTime{font-size: 60px;}
			.container{ margin-left:auto;margin-right:auto; width: 900px;}
			.container #title {font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;padding: 50px;}
			
			#t_body {
				border-collapse: separate;
				font-size: 30px;
				font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
				width: 900px;
				height: 500px;
				border-spacing:5px; 
			}
			
			#t_body thead tr:first-child {background: #A4C3FF;}
			thead tr th{
				text-align: center;	
				border-radius: 10px;
				margin: auto;
				color: white;		
			}
			
			#t_body tr td{
				background: #EBF5FF;
				border-radius: 10px;
				font-weight: 400;
				vertical-align : top;
				padding:5px;

			}
					
			#t_body td:nth-child(7n+1) {color: red;}
			#t_body td:nth-child(7n) {color: blue;}
			td span{text-align: center;	color: black;}
			.date_text span{font-size: 30px;}
			.date_text span{color: #6495ED;}
			.poo{width: 30px;margin-left: 10px;margin-right: 0;}
			.btnS{display: inline-block;
			   height: 40px;
			   width: 70px;
			   font-weight: 500;
			   font-size: 20px;
			   line-height: 20px;
			   margin-bottom:10px;
			   margin-left: 10px;
			   color:white;
			   background-color: #6495ED;  }	
			.btnS:hover{
					  border: 2px solid #c3daf7;
					  background-color: white;
					  color:black;
					}
			.ac{
  display: inline-block;
  transform-origin: center;
  padding: 0 0.5rem;
  animation: animate 3s infinite;
}
@keyframes animate{
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.10);
  }
  100% {
    transform: scale(1);
  }
}
	
	</style>
	</head>
	<body>
	  <div class="container">
	  	<div>
			<div class='hours'>
				<h1 id="title">디즈니 동산 운영 시간</h1>
 
				<h1 class="selectDate" id="date_text">2023.08.23</h1>
				<div class="h_time">
					<h1 class="ac">
						<img src="/resources/images/facilityInfo/open.PNG" alt="/" />
						<span id="hoursTime">10:00~20:00</span>
						<img src="/resources/images/facilityInfo/close.PNG" alt="/" />
					</h1>
				</div>
			</div>
			

		    <div id="div_calendar">
		      <div>
		      	

		        <div class="date_text">
		        	<span id="year"  >2020</span><span>-</span>
		        	<span id="month"  onchange="changeMonth(); ">01</span>
		        	<input type="hidden" onclick="changeMonth(-1);" id="fa1" value="" class="btn btnS" />
		        	<input type="button" onclick="changeMonth(1);" id="fa2" value="" class="btn btnS" />
		        </div>
		      </div>
		      <table id="t_body">
		        <thead>
		          <tr>
		            <th>일</th>
		            <th>월</th>
		            <th>화</th>
		            <th>수</th>
		            <th>목</th>
		            <th>금</th>
		            <th>토</th>
		          </tr>
		        </thead>
		        <tbody id="tb_body"></tbody>
		      </table>
		    </div>
		  </div>
	  </div>
	 
	  <script>
	    let date = new Date();
	    let y = date.getFullYear();
	    let m = ('0' + (date.getMonth() + 1)).slice(-2);
	    let d = ('0' + date.getDate()).slice(-2);
	    let today1 = document.getElementById("date_text");
	    //let today2 = document.getElementById("year_month");
	    today1.innerHTML = y + '-' + m  + '-' + d;
	    //today2.innerHTML = y + '-' + m;  	

		$("#fa1").val((Number(m) - 1) + "월");
		$("#fa2").val((Number(m) + 1) + "월");
		
		let current_year = (new Date()).getFullYear();
		let current_month = (new Date()).getMonth() + 1;
		
		//$("#fa1").text((Number(m) - 1) + "월");
		//$("#fa2").text((Number(m) + 1) + "월");
		loadData();
		
			    
	    function checkLeapYear(year) {//윤년 계산
	      if(year%400 == 0) {
	        return true;
	      }else if(year%100 == 0) {
	        return false;
	      }else if(year%4 == 0) {
	        return true;
	      }else {
	        return false;
	      }
	    }

	    function getFirstDayOfWeek(year, month) {//선택한 달의 1일 요일 구하기
	      if(month < 10) month = "0" + month;//month가 10보다 작으면 month앞에 "0"
	
	      return (new Date(year+"-"+month+"-01")).getDay(); //getDay () 메소드는 일주 (0-6), 하루 수를 반환
	    }
	
	    function changeYearMonth(year, month) {//버튼 클릭시 월별 날짜 구하기
	      let month_day = [31,28,31,30,31,30,31,31,30,31,30,31];//월별 마지막 날짜
	
	      if(month == 2) {
	        if(checkLeapYear(year)) month_day[1] = 29;//2월이면 년도 나누기 4 했을 때 0이면 2월29일(윤년이면)
	      }
	
	      let first_day_of_week = getFirstDayOfWeek(year, month);//일요일이면 0, 월요일이면 1....
	      let arr_calendar = [];
	      for(let i=0 ; i<first_day_of_week ; i++){
	        arr_calendar.push("");//
	      }
	
	      for(let i=1 ; i<=month_day[month-1] ; i++) {
	        arr_calendar.push(String(i));//arr_calendar에 월에 마지막 날짜까지 1,2,3... 넣음 
	      }
	
	      let remain_day = 7 - (arr_calendar.length%7);//빈공간
	      if(remain_day < 7) {
	        for(let i=0 ; i<remain_day ; i++) {
	          arr_calendar.push("");
	        }
	      }
	
	      renderCalendar(arr_calendar);
	    }
	
	    function renderCalendar(data) {
	      let h = [];

	      for(let i =0 ; i<data.length ; i++) {
	        if(i==0) {//첫주
	          h.push('<tr>');
	        }else if(i%7 == 0) {
	          h.push('</tr>');
	          h.push('<tr>');//다음주..
	        }
			
	        let dayValue = current_year + "-" +('0' + current_month).slice(-2);
	        console.log(dayValue);
	        
	        if(data[i] === ""){
		        h.push('<td style="background-color:#F7F5F5;"></td>');
	        } else {
	        	h.push('<td class="t_day" id="day' + data[i] + '" onclick="setDate(' + data[i] + ');" style="cursor:pointer;">' +
	        		    data[i] + '<span class="pooImg"></span>' +'<br />' +
	        		    '<input type="hidden" class="dateValue" value="' + dayValue + '-' + ('0' + data[i]).slice(-2) + '">' +
	        		    '<span class="time" id='+dayValue + '-' + ('0' + data[i]).slice(-2)+' style="font-size: 15px;"></span>' +
	        		    '</td>'); 
	        }
	        
	         
	      }
	
	      h.push('</tr>');
		
	
	      $("#tb_body").html(h.join(""));
		  for(let i=1 ; i<= $(".t_day").text().length; i++) {
			if(d == i && m == current_month && y == current_year){
				$("#day"+i).css("backgroundColor","#6495ED");
				$("#day" + i + " > span.pooImg").append('<img class="poo" src="/resources/images/facilityInfo/poo.PNG" alt="/" />');
				}
			
			}
		  
	    }
	    
	    
	    function setDate(day) {//선택할 날짜 가져가기
	    	$(".t_day").css("backgroundColor", "#EBF5FF"); 
	    	$(".poo").remove();
	    	$("#day"+day).css("backgroundColor","#6495ED");
	    	
	    	$("#day" + day + " > span.pooImg").append('<img class="poo" src="/resources/images/facilityInfo/poo.PNG" alt="/" />');
			
			let text_month = current_month;
			//let dateValue = $("#day" + day + " input[type=hidden]").val();
	      	if(day<10) day = "0" + day;
	      	if(current_month<10) text_month = "0" +text_month;
			
	      	let dateText = current_year + "-" + text_month + "-" + day; 
	      	
	      	
	      	$("#date_text").text(dateText);
	      	//$("#a").text(dateValue);
	      	$("#input_date").val(dateText);
	      	//$("#div_calendar").hide();
	      	$("#hoursTime").text($("#"+dateText).text());
	      	
	    }

	    
	    function changeMonth(diff) {
	      if(diff == undefined) {
	        current_month = parseInt($("#month").val());
	      }else {
	        current_month = current_month + diff;
	
	        if(current_month == 0) {//전년도로 바뀜
	          current_year = current_year - 1;
	          current_month = 12;
	        }else if(current_month == 13) {//다음년로 바뀜
	          current_year = current_year + 1;
	          current_month = 1;
	        }
	      }
	
	      loadCalendar();
		    if((current_month) == Number(m)){
		    	$("#fa1").prop("type", "hidden");
		    	//$("#fa1").css("visibility", "hidden");
		    }else{
		    	$("#fa1").prop("type", "button");
		    	//$("#fa1").css("visibility", "visible");
		    }
		    if((current_month) == (Number(m)+1)){
		    	$("#fa2").prop("type", "hidden");
		    	//$("#fa2").css("visibility", "hidden");
		    }else{
		    	$("#fa2").prop("type", "button");
		    	//$("#fa2").css("visibility", "visible");
		    }
	    }
	
	    function loadCalendar() {
	      //$("#year").val(current_year);
	      $("#year").text(current_year);
	      //$("#month").val(current_month);
	      $("#month").text(("0" + current_month).slice(-2));
	      changeYearMonth(current_year,current_month);
	      
		    let previous_month = current_month -1
		    let next_month =current_month +1
		    if(previous_month === 0){
		    	$("#fa1").val(12 + "월");
		    	//$("#fa1").text(12 + "월");
		    }else{
		    	$("#fa1").val(previous_month + "월");
		    	//$("#fa1").text(previous_month + "월");
		    }
		    
		    if(next_month === 13){
		    	$("#fa2").val(1 + "월");	
		    	//$("#fa2").text(1 + "월");	
		    }else{
		    	$("#fa2").val(next_month + "월");
		    	//$("#fa2").text(next_month + "월");
		    }
		    loadData();
		    
		    /* let a = $("#date_text").text();
		    console.log(a); */
	    }
	
	    function loadData(){
		    //$("#year").val(current_year);
		    $("#year").text(current_year);
		    //$("#month").val(current_month);
			$("#month").text(("0" + current_month).slice(-2));
		    changeYearMonth(current_year,current_month);
			
		    
			$.ajax({
			    url: '${pageContext.request.contextPath}/facilityInfo/operatingHours', // Spring 컨트롤러 엔드포인트 URL
			    type: 'POST',
			    data: { data : current_year+"-"+("0" + current_month).slice(-2)},
			    dataType: 'json', // 응답 데이터 형식이 JSON임을 지정
			    success: function(data) {
			        // 서버에서 받은 JSON 데이터를 JavaScript 배열로 파싱
			        let hoursList = data;
			        
			        for(let i=0;i<hoursList.length;i++){
			        	$("#"+hoursList[i].hoursDate).text(hoursList[i].hoursTime);
			        	if(hoursList[i].hoursDate == $("#date_text").text()){
			        		$("#hoursTime").text(hoursList[i].hoursTime);
			        	}
			        }
			        
			        
			    },
			    error: function() {
			        // 오류 처리
			        alert('데이터를 가져오는 데 실패했습니다.');
			    }
			}); 
	    }
	  </script>
	</body>
</html>