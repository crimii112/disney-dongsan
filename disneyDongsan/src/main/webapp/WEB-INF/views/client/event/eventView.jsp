<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />

    <title>이벤트</title>

    <link rel="shortcut icon" href="/resources/image/icon.png" />
    <link rel="apple-touch-icon" href="/resources/image/icon.png" />

    <!--[if lt IE 9]>
    <script src="../js/html5shiv.js"></script>
    <![endif]-->

    <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap-theme.min.css"/>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
    <script type="text/javascript" src="/resources/include/js/common.js"></script>
    <script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>

    <style type="text/css">
        .thumbnail > img { width: 320px; height: 200px; }
        .image > img { width: 100px; height: 100px; }
/*         .detailModal { display: none; } */
/*         .thumbnail > img { */
/*             width: 320px; */
/*             height: 200px; */
/*         } */
/*         /* 모달 창 크기 조정 */ 
/*         .modal-dialog { */
/*             max-width: 700px; /
/*         } */
        /* 달력 css */
        .saturday {color: gray;}
        .sunday {color: red; }
        
        
        image {width: 100px; height: 100px;}
        
        .container {
	        box-sizing: border-box;
	        margin-left: 130px;
	    }
	
	    .clear {
	        clear: both;
	    }
	
	    .event_period {
	        margin-top: 50px;
	    }
	
	    .event_image {
	        margin-bottom: 50px;
	        text-align: center;
	        max-width: 100%; 
	        height: auto; 
	    }
	
 	    .modal-content { 
 	        margin: 0 auto; 
 	        text-align: left; 
	    } 
	
	    .carousel-inner > .item > img {
		    width: 100%; 
		    height: 400px; 
		}
	
	    /* 모달 창 크기 조정 */
 	    .modal-dialog { 
 		    max-width: 100%; 
	    	margin: 10px auto; 
		} 
		
		.carousel {
		    max-height: 400px; 
		    margin: 0 auto; 
		}
		.event_timeInfo {
		    display: flex;
		    justify-content: space-between;
		    padding: 10px;
		    margin-top: 20px;
		}
		
		.event_time {
		    flex-basis: 48%;
		    text-align: center;
		    border: 2px solid #000;
		    box-sizing: border-box; /* 내부 패딩과 경계를 높이에 포함시킵니다. */
		}
		.event_period {
		    margin-top: 0;
		    flex-basis: 48%;
		    text-align: center;
		    border: 2px solid #000;
		    box-sizing: border-box; /* 내부 패딩과 경계를 높이에 포함시킵니다. */
		    height: 200px; /* 원하는 높이로 설정하세요. */
		}
		
/* 		.event_title h3 { */
/* 		    margin: 0; /* h3 요소의 상하 마진을 제거합니다. */ */
/* 		} */
    </style>

    <script type="text/javascript">
        $(function(){
            /* 달력 함수 */
            var currentDate = new Date(); // 현재 날짜
            currentDate.setHours(0, 0, 0, 0); // 시간을 자정으로 설정

            var options = {
                showDay: true,
                showFullDayName: true,
                showToday: true
            };
            
            // 페이지 로드 시 오늘 날짜 이벤트 로딩
            var today = new Date();
            getEventsForDate(today);

            function updateCalendar(date) {
                var currentDate = new Date(date);
                var html = "<table><tbody><tr>";

                for (var i = 0; i < 7; i++) {
                    var cellDate = currentDate.getDate();
                    var cellClass = "";

                    if (currentDate.getDay() === 0) {
                        cellClass = "sunday";
                    } else if (currentDate.getDay() === 6) {
                        cellClass = "saturday";
                    }

                    html += "<td data-date=\"" + currentDate.toISOString().substring(0, 10) + "\" class=\"" + cellClass + "\">";

                    html += currentDate.toISOString().substring(8, 10) + "&nbsp;&nbsp;";

                    html += "</td>";
                    currentDate.setDate(currentDate.getDate() + 1); 
                }

                html += "</tr></tbody></table>";
                return html;
            }

            function setButtonsState() {
                var today = new Date();
                today.setHours(0, 0, 0, 0);

                $("#prevWeekButton").prop("disabled", currentDate <= today);
            }

            var html = updateCalendar(currentDate);
            $(".calendar-yearmonth").html(currentDate.getFullYear() + "년 " + (currentDate.getMonth() + 1) + "월");
            $("#calendar").html(html);
            setButtonsState();

            $("#nextWeekButton").click(function() {
                currentDate.setDate(currentDate.getDate() + 7);
                var html = updateCalendar(currentDate);
                $(".calendar-yearmonth").html(currentDate.getFullYear() + "년 " + (currentDate.getMonth() + 1) + "월");
                $("#calendar").html(html);
                setButtonsState();
            });

            $("#prevWeekButton").click(function() {
                if ($(this).prop("disabled")) {
                    return; 
                }

                currentDate.setDate(currentDate.getDate() - 7); // 이전 주로 이동
                var html = updateCalendar(currentDate);
                $(".calendar-yearmonth").html(currentDate.getFullYear() + "년 " + (currentDate.getMonth() + 1) + "월");
                $("#calendar").html(html);
                setButtonsState();
            });
            
            function getEventsForDate(date) {
                var clickedDate = date.toISOString().substring(0, 10);

                $.ajax({
            	    url: '/event/getEvents?selectedDate=' + clickedDate, 
            	    method: 'GET',
            	    success: function(data) {
            	        displayEvents(data);
            	    },
            	    error: function() {
            	        console.error('이벤트를 가져오는 중에 오류가 발생했습니다.');
            	    }
            	});
            }

            // 이벤트 목록 표시 함수
            function displayEvents(events) {
			    var eventTable = $('#eventTable tbody');
			    eventTable.empty(); 
			
			    if (events.length === 0) {
			        eventTable.append('<tr><td colspan="3">이 날짜에 이벤트가 없습니다.</td></tr>');
			    } else {
			        for (var i = 0; i < events.length; i++) {
			            var event = events[i];
			            eventTable.append('<tr><td rowspan="2" class="col-md-3 event-thum"><img src="/uploadStorage/event/' + event.e_thum + '" style="width:200px; height:100px;"></td><td class="event-title" data-event-id="' + event.e_no + '">' + event.e_title + '</td></tr><tr><td class="event-time">' + event.e_time + '</td></tr>');
			        }
			    }
			}


            $('#calendar').on('click', 'td', function() {
                var clickedDate = $(this).data('date');
                if (clickedDate) {
                    getEventsForDate(new Date(clickedDate));
                }
            });
		
            
            
          // 동적으로 생성된 요소 이벤트
          // 모달
            $('#eventTable').on('click', '.event-title, .event-thum', function() {
            	var eventId = $(this).closest('tr').find('.event-title').data('event-id');
            	$.ajax({
                    url: '/event/eventDetail?e_no=' + eventId, 
                    method: 'GET',
                    success: function(data) {
                    	var modal = $('#detailModal');
                        modal.find('.modal-title').text('이벤트 상세 정보');
                        modal.find('.modal-body').html(data); 
                        
                        var modalFooter = modal.find('.modal-footer');
                        modalFooter.empty(); 
                        modalFooter.append('<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>');
                        
                        modal.modal('show'); 
                    },
                    error: function() {
                        console.error('이벤트 상세 정보를 가져오는 중에 오류가 발생했습니다.');
                    }
                });
            });
          
            $('#eventTable').on('click', '.event-time', function() {
                var eventId = $(this).closest('tr').prev().find('.event-title').data('event-id'); 
                $.ajax({
                    url: '/event/eventDetail?e_no=' + eventId, 
                    method: 'GET',
                    success: function(data) {
                    	var modal = $('#detailModal');
                        modal.find('.modal-title').text('이벤트 상세 정보'); 
                        modal.find('.modal-body').html(data); 
                        
                        var modalFooter = modal.find('.modal-footer');
                        modalFooter.empty(); 
                        modalFooter.append('<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>');
                        
                        modal.modal('show'); 
                    },
                    error: function() {
                        console.error('이벤트 상세 정보를 가져오는 중에 오류가 발생했습니다.');
                    }
                });
            });
            
         
           
            $(".event_time").each(function() {
		        let e_time = $(this).text();
		        if (e_time === "on") {
		            $(this).text("상시");
		        }
		    });
            
         
        }); // $ 종료
       
        

    </script>
</head>
<body>
	<div id="container">
	<div class="Row">
	    <div class="text-center"><h2>이벤트</h2></div>
	    
	    <div class="calendar month">
	        <div class="calendar-header">
	            <span class="calendar-yearmonth"></span>
	        </div>
	        <button id="prevWeekButton" disabled>저번 주</button>
	        <div id="calendar"></div>
	        <button id="nextWeekButton">다음 주</button>
	    </div>
	    <!-- 이벤트 목록 출력 테이블 -->
	    <div id="eventTableContainer">
	        <table id="eventTable" class="table">
	            <tbody>
	               
	            </tbody>
	        </table>
	    </div>
	    
		<div>
			<div id="detailModal" class="modal fade" role="dialog">
			    <div class="modal-dialog modal-dialog-centered" style="max-width: 800px;">
			        <!-- 모달 -->
			        <div class="modal-content">
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal">&times;</button>
			                <h4 class="modal-title">이벤트 상세 정보</h4>
			            </div>
			            <div class="modal-body">
			                <jsp:include page="../../modal/eventDetail.jsp"></jsp:include>
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			            </div>
			        </div>
			    </div>
			</div>
        </div>
	</div>	
	</div>
</body>
</html>
