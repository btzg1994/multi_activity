<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>渭南联通活动后台</title>
<link
	href="${pageContext.request.contextPath}/resources/back/login/css/login.css"
	rel="stylesheet" type="text/css">
	<script src="${pageContext.request.contextPath }/resources/back/js/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function(){
			document.getElementById('loginform:idInput').focus();
			$(document).keydown(function (event) {
				if (event.keyCode == 13) {
					document.getElementById('loginform:loginBtn').click();
				}
			});
		})
	</script>
</head>

<body>
	<!--顶部信息-->
	<div class="mytop">
		<div class="mytopn">
			<div class="mylogo">
				<img
					src="${pageContext.request.contextPath}/resources/back/images/logo.jpg">
			</div>
			<div class="mytopr"></div>
			<div class="clear"></div>

		</div>
	</div>
	<!--顶部信息结束-->


	<div class="dlmain">
		<div class="dlmainnr">
			<div class="focus" id="focus">
				<div class="login_box">
					<div class="login">
						<form id="loginform" name="loginform" method="post"
							action="${pageContext.request.contextPath }/back/anony/login">
							<p class="ptit">登录</p>
							<dl>
								<dd class="clearfix">
									<input id="loginform:idInput" name="loginName" type="text" class="input_name name_wid"
										placeholder="请输入用户名">
								</dd>
								<dd class="clearfix">
									<input name="loginPwd" type="password"
										class="input_password name_wid" placeholder="请输入密码">
								</dd>
								<dd class="clearfix">
									<div class="fl">
										<input name="checkcode" type="text" class="input_yzm"
											placeholder="请输入验证码" style="width:160px;">
									</div>
									<div class="fr">
										<img id="loginform:vCode"
											src="${pageContext.request.contextPath }/validatecode_back.jsp"
											width="90" height="35"
											onclick="javascript:document.getElementById('loginform:vCode').src='${pageContext.request.contextPath }/validatecode_back.jsp?'+Math.random();">
									</div>
									<div class="clear"></div>
									<p class="kbqc" onclick="javascript:document.getElementById('loginform:vCode').src='${pageContext.request.contextPath }/validatecode_back.jsp?'+Math.random();">看不清楚，换一个？</p>
								</dd>
								<dd class="clearfix" >
									<a id="loginform:loginBtn" href="javascript:;" onclick="document.forms[0].submit()" class="denglu">登录</a>
								</dd>
								<dd class="clearfix" style="display:none;">
									<a href="#" class="zhuce">注册</a>
								</dd>
							</dl>
							<p >${back_errMsg }</p>
						</form>
					</div>
				</div>
				<div id="focus_m" class="focus_m">
					<ul>
						<li class="li_1"><a href="#" hidefocus="true"></a></li>
						<li class="li_2"><a href="#" hidefocus="true"></a></li>
						<li class="li_3"><a href="#" hidefocus="true"></a></li>
					</ul>
				</div>
				<a href="javascript:;" class="focus_l" id="focus_l" hidefocus="true"
					title="上一张"><b></b><span></span></a> <a href="javascript:;"
					class="focus_r" id="focus_r" hidefocus="true" title="下一张"><b></b><span></span></a>
			</div>
		</div>
	</div>

	<div class="footer">Copyright &copy;陕西联通 技术支持：西安彩拓网络科技有限公司</div>


</body>
</html>
