<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   		<div>
         	<div class="event_title"><h3>${detail.e_title }</h3></div>
         	
            <div class="event_image">
	            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
				  <!-- Indicators -->
				  <ol class="carousel-indicators" >
				    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
				  </ol>					
	
				 <!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox" style="max-width: 100%; max-height: 400px; overflow: hidden; text-align: center;">
				    <div class="item active">
				        <img src="/uploadStorage/event/${detail.e_img1 }" alt="..." style="max-width: 100%; max-height: 100%; display: block; margin: 0 auto;" />
				        <div class="carousel-caption">
				        
				        </div>
				    </div>
				    <div class="item">
				        <img src="/uploadStorage/event/${detail.e_img2 }" alt="..." style="max-width: 100%; max-height: 100%; display: block; margin: 0 auto;" />
				        <div class="carousel-caption">
				        
				        </div>
				    </div>
				</div>
	  			<!-- Controls -->
				  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
				</div>
            </div>
            
            <div class="event_content">${detail.e_content }</div>
            
            <div class="event_timeInfo">
            	<div class="event_period">${detail.e_start }<br/>${detail.e_end }</div>
            	<div class="event_time">${detail.e_time }</div>
            </div>
        </div>
