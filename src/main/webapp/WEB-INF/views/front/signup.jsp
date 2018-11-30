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
		<link rel="stylesheet" type="text/css" href="css/cee.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/front/js/jquery.min.js"></script>
		
		<style>
		    .content{max-width: 720px;background-color: #a30602; margin: auto;}
			input{margin-left: 12%;width: 76%;border-radius: 20px;height: 70px;
			border: none; box-sizing: border-box; padding: 0px 40px;font-size: 16px;}
			.name{font-size: 36px;}	 
			p{font-size: 36px;}
			img{width: 100%;}    	
		</style>
		<script type="text/javascript">
			const PHONE_REGEX = /^1\d{10}$/;
			$(function(){
				/* 确认报名 */
				$('#signupBtn').click(function(){
					var id = $('#id').val();
					var name = $('#name').val();
					var phone = $('#phone').val();
					
					//校验
					if(!id){
						alert('服务器繁忙！');
						return;
					}
					if(!name){
						alert('姓名不能为空！');
						return;
					}
					if(name.length > 10){
						alert('姓名长度不能超过10位！');
						return;
					}
					if(!phone || !phone.match(PHONE_REGEX)){
						alert('手机号格式有误！');
						return;
					}
					$.post("${pageContext.request.contextPath}/front/anony/signup", 
							{ 
								"id": id,
								"name": name,
								"phone": phone,
							},
						   function(data){
						   		if(data.rspCode == 1){
						   			window.location.href = "${pageContext.request.contextPath}/front/anony/finishView";
						   		}else{
						   			alert(data.rspMsg);
						   		}
						   },
					 "json");
					
				});
			})
		</script>
	</head>
	<body>
		<div class="content">
			<img src="${pageContext.request.contextPath}/resources/front/img/img-head3.png"/>
			<input id="id" type="hidden" value="${id}">
			<p class="name" style="font-size: 24px;margin-left: 12%;margin-top:40px;color: white;">您的姓名</p>
			<input id="name"  type="text" />	
			<p class="phone" style="font-size: 24px;margin-left: 12%;color: white;">您的电话</p>
			<input id="phone"  type="text" />
			<img id="signupBtn" class="signup" style="width:80%;margin-top: 30px;margin-left: 10%;"  src="${pageContext.request.contextPath}/resources/front/img/img-button2.png"/>
			
		</div>
	</body>
</html>
