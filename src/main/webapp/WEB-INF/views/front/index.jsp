<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html> 
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		<meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
		<title>渭南联通大动作</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/front/css/cee.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/front/js/jquery.min.js"></script>   
		
		
		<style>
		    .content{max-width: 720px;background-color: #a30602; }
			.guanzhu {width: 78%;margin-left: 12%;margin-top: 40px;   overflow: hidden;
	                  background-image: url("${pageContext.request.contextPath}/resources/front/img/img-3.png");
	                  background-size: 100% 100%;}
			.word1{text-align: center;padding:30px ;
				font-size: 20px;color: #a30602;}
			.word2{font-size: 30px;
					letter-spacing: 3px;
					color: #a30602;}	
			.time {width: 300px;margin: auto;margin-top: 64px; overflow: hidden;
	                  background-image: url("${pageContext.request.contextPath}/resources/front/img/img-5.png");
	                  background-size:100% 100%;}	
	        .black{padding: 175px 0px 85px  0px;}          
	        .word4{ margin-left: 13%; font-size: 20px;color: #fff;} 
			.word7{ margin-left: 12.8%;font-size: 20px;color: #fff;}
			.word8{margin-left: 12.8%;font-size: 20px;color: #fff;}
			.word9{margin-left: 12.8%;font-size: 20px;color: #fff;}
			.word5{font-size: 81px;
					font-weight: normal;
					font-stretch: normal;
					letter-spacing: 8px;
					color: #ffffff;
					box-shadow: 4px 14px 18px 0px 
						rgba(255, 146, 102, 0.77);}	
			.img7{width: 15%;margin-left: 12%;}	 
			.word6{margin-left: 25%;
				font-size: 15px;color: #ffffff;}			
			table{width: 76%;margin-left: 12%;margin-top:32px;border: none;}	
			tr{height: 84px;border: 1px solid white;color: white;font-size: 14px;}
			td{text-align: center;border: 1px solid white;color: white;font-size: 14px;}	
			.signup{max-width: 720px;position: fixed;bottom:0px;left: 50%; transform: translate(-50%,0); -webkit-transform: translate(-50%,0);}
			.footer{margin-top: 282px;}	
			img{width: 100%;}		        	
		</style>
		
		<script type="text/javascript">
			const DAY = 24*60*60*1000;
			const HOUR = 60*60*1000;
			const MINUTE = 60*1000;
			const SECOND = 1000;
			const ENDTIME = ${endTime};
			
			/* 倒计时效果 */
			function countdown(){
				//获取截止时间
				//获取当前时间
				var date = new Date();
				var nowTime = date.getTime();
				
				//整天
				var time = ENDTIME - nowTime;
				if(time <= 0){
					clearInterval(countdown);
					$('#whole_day').text('00');
					$('#whole_hour').text('00');
					$('#whole_minute').text('00');
					$('#whole_second').text('00');
					return;
				}
				
				var whole_day = Math.floor(time/DAY);
				//整时
				time = time - whole_day * DAY;
				var whole_hour = Math.floor(time/HOUR);
				//整分
				time = time - whole_hour * HOUR;
				var whole_minute = Math.floor(time/MINUTE);
				//整秒
				time = time - whole_minute * MINUTE;
				var whole_second = Math.floor(time/SECOND);
				
				
				if(whole_day < 10){
					whole_day = '0' + whole_day;
				}
				if(whole_hour < 10){
					whole_hour = '0' + whole_hour;
				}
				if(whole_minute < 10){
					whole_minute = '0' + whole_minute;
				}
				if(whole_second < 10){
					whole_second = '0' + whole_second;
				}
				$('#whole_day').text(whole_day);
				$('#whole_hour').text(whole_hour);
				$('#whole_minute').text(whole_minute);
				$('#whole_second').text(whole_second);
			}
			
			$(function(){
				countdown();
				setInterval(countdown,1000);
				
				/* 立即报名 */
			 	$('#signupImg').click(function(){
			 		var date = new Date();
					var nowTime = date.getTime();
					var time = ENDTIME - nowTime;
			 		if(time <= 0){//活动已结束
			 			alert('活动已结束！');
			 			return;
			 		}
			 		window.location.href = "${pageContext.request.contextPath}/front/anony/signupView/"+${id};
			 	});
				
				
				
			})
		</script>
		
		
	</head>
	<body>
		<div class="content">
			<img src="${pageContext.request.contextPath}/${bannerUrl}"/>
			<div class="guanzhu">
				<div class="word1"><span  class="word2">${customer_count}</span> 人正在关注</div>
			</div>
			<div class="time">
				<div class="black">
						<b id="whole_day" class="word4"></b>
						<b id="whole_hour" class="word7"></b>
						<b id="whole_minute" class="word8"></b>
						<b id="whole_second" class="word9"></b>
				</div>		
			</div>
			<img src="${pageContext.request.contextPath}/resources/front/img/img-6.png"/>
			<img class="img7" src="${pageContext.request.contextPath}/resources/front/img/img-7.png" />
			<span class="word6">活动预定人数：${customer_count}人</span>
			<form>
				<table style="border-collapse: collapse;" border="3px"  bordercolor="#fff"  cellpadding="0px" cellspacing="0">
					<tr>
						<td>编号</td>
						<td>姓名</td>
						<td>联系电话</td>
						<td>购买时间</td>
					</tr>
					<c:forEach items="${ customer_list}" var="customer_map">
						<tr>
							<td>${customer_map.number }</td>
							<td>${customer_map.customer.name }</td>
							<td>${customer_map.customer.phone }</td>
							<td><fmt:formatDate value="${customer_map.customer.createTime }" pattern="yyyy-MM-dd HH：mm：ss"/> </td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<img id="signupImg" class="signup"  src="${pageContext.request.contextPath}/resources/front/img/img-button.png"/>
		    <div  style="padding-bottom: 20px;"></div>
			<img class="footer" src="${pageContext.request.contextPath}/resources/front/img/img-footer.png"/>
			
			
		</div>
	</body>
</html>
