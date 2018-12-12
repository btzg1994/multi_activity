<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>渭南联通活动后台</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/back/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/back/js/easyui/themes/icon.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/back/js/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">

<link
	href="${pageContext.request.contextPath}/resources/back/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/back/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/back/css/my.css"
	rel="stylesheet" type="text/css">
<style type="text/css">
.resetPwdBtn {
	
}

.frozenBtn {
	
}
</style>
<!--[if lt IE 9]><script src="${pageContext.request.contextPath}/resources/back/jrjs/ie8-responsive-file-warning.js"></script><![endif]-->
<script
	src="${pageContext.request.contextPath}/resources/back/jrjs/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="${pageContext.request.contextPath}/resources/back/jrjs/html5shiv.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/back/jrjs/respond.min.js"></script>
<![endif]-->

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/back/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/back/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/back/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/back/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/back/js/easyui/outOfBounds.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/back/js/zTree/jquery.ztree.all.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/back/js/jquery.ocupload-1.1.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/back/js/datetimeformat.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/back/js/jquery.easyui.plus.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/back/js/myjs.js"></script>
<script type="text/javascript">


	function doReload() {
		location.replace(location.href);
	}

	$(function() {
		/* 重置密码 */
		var $resetPwdBtn = $('a.resetPwdBtn');
		if ($resetPwdBtn) {
			$resetPwdBtn.click(function() {
				var id = $(this).find('span').text();
				$.post("${pageContext.request.contextPath}/back/root/resetPwd/" + id, {},
					function(data) {
						if (data == "-1") {
							Ewin.alert({
								title : "系统提示",
								message : '重置失败！',
							});
						} else {
							Ewin.alert({
								title : "系统提示",
								message : '重置成功！新密码为：' + data,
							});
						}
					}, "text");
			});
		}
		
		/* 冷冻账号 */
		/* var $frozenBtn = $('a.frozenBtn');
		if ($frozenBtn) {
			$frozenBtn.click(function() {
				var id = $(this).find('span').text();
				$.post("${pageContext.request.contextPath}/operator/frozen/" + id, {},
					function(data) {
						if (data == "-1") {
							Ewin.alert({
								title : "系统提示",
								message : '冻结失败！',
							});
						} else if (data = "1") {
							alert('冻结成功！');
							doReload();
						}
					}, "text");
			});
		} */
		
		/* 激活账号 */
		/* var $activeBtn = $('a.activeBtn');
		if ($activeBtn) {
			$activeBtn.click(function() {
				var id = $(this).find('span').text();
				$.post("${pageContext.request.contextPath}/operator/active/" + id, {},
					function(data) {
						if (data == "-1") {
							Ewin.alert({
								title : "系统提示",
								message : '解冻失败！',
							});
						} else if (data = "1") {
							alert('解冻成功！');
							doReload();
						}
					}, "text");
			});
		}
 */
	});
</script>

</head>


<body>
	<div class="content">
		 <!--顶部信息-->
		<div class="mytop">
			<div class="mytopn">
				<div class="mylogo">
					<img
						src="${pageContext.request.contextPath}/resources/back/images/logo.jpg">
				</div>
				<div class="mytopr">
					<div class="mydlxx fr">
						<a href="${pageContext.request.contextPath}/global/logout" class="tuichu ml10">退出</a>
					</div>
				</div>
				<div class="clear"></div>

			</div>
		</div>
		<!--顶部信息结束-->
    
    
    <div class="content-box">
    
      <!--左边导航-->
			<div class="content-lf">
				<dl class="mymenu">
					<!-- 不含子节点 -->
					<dt class="menu_title">
						<p class="gl_ico">
							<a href="${pageContext.request.contextPath}/back/activity/findActivities/1/10">活动管理</a>
						</p>
					</dt>
				</dl>
			</div>
			<!--左边导航结束-->

			<!--右边内容-->
			<div class="content-rg">
				<div class="tityj">
					<p id="contentTitle" class="fl">活动管理</p>
					<div class="fr"></div>
					<div class="clear"></div>
				</div>

				<div class="rgcon bodybai">
					<div class="butdivs">
						<a type="button"
							href="${pageContext.request.contextPath}/back/activity/addActivityView"
							class="btn btn-info">添加活动</a> </div>
						<div class="border-bom">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="table mytab">
							<thead>
								<tr>
									<th>活动编号</th>
									<th>活动图片</th>
									<th>活动名称</th>
									<th>活动开始时间</th>
									<th>活动结束时间</th>
									<th>创建时间</th>
									<th>备注</th>
									<th>操作</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${pageInfo.list}" var="activity"
									varStatus="vs">
									<tr>
										<td>${activity.id}</td>
										<td ><img width="150px;" src="${pageContext.request.contextPath}/${activity.bannerUrl}"> </td>
										<td>${activity.name}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
												value="${activity.startTime}" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
												value="${activity.endTime}" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
												value="${activity.createTime}" /></td>
										<td>${activity.remark}</td>
										<td>
												<a class="frozenBtn" href="${pageContext.request.contextPath}/back/activity/findActivityById?id=${activity.id}">编辑</a>&nbsp;&nbsp;
												<a class="frozenBtn" href="${pageContext.request.contextPath}/front/anony/index/${activity.id}">活动主页</a>&nbsp;&nbsp;
												<a class="frozenBtn" href="${pageContext.request.contextPath}/back/statistics/index?id=${activity.id}">明细下载</a>&nbsp;&nbsp;
										</td>
									</tr>
								</c:forEach>
							<tbody>
						</table>
					</div>

					<c:if test="${pageInfo.size != 0 }">
						<!--分页-->
						<div class="fenye">
							<div class="black2 black1 fl">
								<span>每页显示条数：</span>
								<c:choose>
									<c:when test="${pageInfo.pageSize == 5 }">
										<span class="current">5条</span>
									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath }/back/activity/findActivities/${pageInfo.pageNum}/5">5条</a>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${pageInfo.pageSize == 10 }">
										<span class="current">10条</span>
									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath }/back/activity/findActivities/${pageInfo.pageNum}/10">10条</a>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${pageInfo.pageSize == 20 }">
										<span class="current">20条</span>
									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath }/back/activity/findActivities/${pageInfo.pageNum}/20">20条</a>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${pageInfo.pageSize == 30 }">
										<span class="current">30条</span>
									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath }/back/activity/findActivities/${pageInfo.pageNum}/30">30条</a>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="black2 fr">
								<c:choose>
									<c:when test="${pageInfo.pageNum == 1 }">
										<span class="disabled"> &lt; </span>
									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath }/back/activity/findActivities/${pageInfo.pageNum - 1}/${pageInfo.pageSize}">
											&lt; </a>
									</c:otherwise>
								</c:choose>

								<c:set var="maxNavigatepageNum" value="0"></c:set>

								<c:forEach items="${pageInfo.navigatepageNums }" var="num">
									<c:choose>
										<c:when test="${pageInfo.pageNum == num }">
											<span class="${pageInfo.pageNum == num ? 'current':'' }">${num}</span>
										</c:when>
										<c:otherwise>
											<a
												href="${pageContext.request.contextPath }/back/activity/findActivities/${num}/${pageInfo.pageSize}">${num }</a>
										</c:otherwise>
									</c:choose>

									<c:set var="maxNavigatepageNum" value="${ num}"></c:set>
								</c:forEach>

								<c:if test="${maxNavigatepageNum != pageInfo.pages }">
                       	...
                       	<a
										href="${pageContext.request.contextPath }/back/activity/findActivities/${pageInfo.pages}/${pageInfo.pageSize}">${pageInfo.pages }</a>
								</c:if>
								<c:choose>
									<c:when test="${pageInfo.pageNum == pageInfo.pages }">
										<span class="disabled"> &gt; </span>
									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath }/back/activity/findActivities/${pageInfo.pageNum + 1}/${pageInfo.pageSize}">
											&gt; </a>
									</c:otherwise>
								</c:choose>

							</div>

							<div class="clear"></div>
						</div>
						<!--分页结束-->
					</c:if>
				</div>

			</div>
			<!--右边内容结束-->
		</div>
	</div>

	<!--修改密码弹层信息-->
	<div id="chgPwdLayer" style="display: none;" class="tclayer">
		<table border="0" cellspacing="0" cellpadding="0" class="tclayertab">
			<tr>
				<td>
					<div class="tcnr-tc wid-tc" style="width:540px">
						<div class="modal-content">
							<div class="modal-header">
								<a id="chgPwd_close" class="closegb" aria-hidden="true"
									data-dismiss="modal"></a>
								<h4 class="modal-title">修改密码</h4>
							</div>

							<div class="modal-body yc-body">
								<div class="yc-body-nr">
									<table border="0" cellspacing="0" cellpadding="0"
										class="contab-tc contab-wid2" style="margin-top:20px;">
										<tr>
											<th>原密码：</th>
											<td><input name="oldPwd" id="oldPwdId" type="password"
												class="form-control myinput3"></td>
										</tr>

										<tr>
											<th>新密码：</th>
											<td><input name="newPwd" id="newPwdId" type="password"
												class="form-control myinput3"></td>
										</tr>

										<tr>
											<th>确认密码：</th>
											<td><input id="confirmPwdId" type="password"
												class="form-control myinput3"></td>
										</tr>
									</table>
								</div>
							</div>

							<div class="modal-footer tcbom">
								<div class="bombut" style="text-align:center">
									<button type="button" id="chgPwdSaveBtn"
										class="btn btn-info px14 padlr buml10" style="width:100px;">保存</button>
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
		$(function() {
	
			/* 修改密码相关js */
			//修改密码按钮
			$('#chgPwdBtn').click(function() {
				$('#chgPwdLayer h4').html('修改密码');
				$('#oldPwdId').val('');
				$('#newPwdId').val('');
				$('#confirmPwdId').val('');
				$('#chgPwdLayer').css('display', '');
			})
	
			$('#chgPwd_close').click(function() {
				$('#chgPwdLayer').css('display', 'none');
			})
	
			//修改密码保存按钮
			$('#chgPwdSaveBtn').click(function() {
				//检查表单数据
				if (!$('#oldPwdId').val().trim()) {
					$('#chgPwdLayer h4').html('<font color ="red">原密码不能为空！</font>');
					return;
				}
	
				if (!$('#newPwdId').val().trim()) {
					$('#chgPwdLayer h4').html('<font color ="red">新密码不能为空！</font>');
					return;
				}
	
				if (!$('#confirmPwdId').val().trim()) {
					$('#chgPwdLayer h4').html('<font color ="red">确认密码不能为空！</font>');
					return;
				}
	
				if ($('#newPwdId').val().trim() != $('#confirmPwdId').val().trim()) {
					$('#chgPwdLayer h4').html('<font color ="red">新密码和确认密码输入不一致！</font>');
					return;
				}
	
				if ($('#newPwdId').val().trim() == $('#oldPwdId').val().trim()) {
					$('#chgPwdLayer h4').html('<font color ="red">新密码与旧密码一致！</font>');
					return;
				}
	
				$.ajax({
					type : "POST",
					url : "${pageContext.request.contextPath}/chgPwd",
					data : {
						oldPwd : $('#oldPwdId').val().trim(),
						newPwd : $('#newPwdId').val().trim(),
					},
					dataType : "text",
					success : function(data) {
						if (data == "success") {
							$('#chgPwdLayer').css('display', 'none');
							alert('密码修改成功,请重新登录！');
							location.href = "${pageContext.request.contextPath}/backindex";
						} else if (data = "oldPwdError") {
							$('#chgPwdLayer').css('display', 'none');
							Ewin.alert({
								title : "系统提示",
								message : '修改失败！原密码错误！',
							});
						} else {
							$('#chgPwdLayer').css('display', 'none');
							Ewin.alert({
								title : "系统提示",
								message : '修改失败！',
							});
						}
					}
				});
			});
	
		/*修改密码信息结束*/
		})
	</script>
</body>

</html>