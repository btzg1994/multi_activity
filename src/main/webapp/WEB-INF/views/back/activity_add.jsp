<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>渭南联通活动后台</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/back/js/easyui/themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/back/js/easyui/themes/icon.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/back/js/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">

<link href="${pageContext.request.contextPath}/resources/back/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/back/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/resources/back/css/my.css" rel="stylesheet" type="text/css">   
<link href="${pageContext.request.contextPath}/resources/back/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">   
<link href="${pageContext.request.contextPath}/resources/jpicker-1.1.6/css/jPicker-1.1.6.min.css" rel="stylesheet" type="text/css">   
<link href="${pageContext.request.contextPath}/resources/jpicker-1.1.6/jPicker.css" rel="stylesheet" type="text/css">   
<style type="text/css">
	.pms_unit{}
	.pms_second{}
	.pms_first{}
</style>
<!--[if lt IE 9]><script src="${pageContext.request.contextPath}/resources/back/jrjs/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="${pageContext.request.contextPath}/resources/back/jrjs/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="${pageContext.request.contextPath}/resources/back/jrjs/html5shiv.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/back/jrjs/respond.min.js"></script>
<![endif]-->

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/jquery.min.js"></script>   
<script src="${pageContext.request.contextPath}/resources/back/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/easyui/jquery.easyui.min.js"></script>  
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/easyui/outOfBounds.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/zTree/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/jquery.ocupload-1.1.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/datetimeformat.js"></script>
<script src="${pageContext.request.contextPath}/resources/back/js/jquery.easyui.plus.js"></script>
<script src="${pageContext.request.contextPath}/resources/back/js/myjs.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/back/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jpicker-1.1.6/jpicker-1.1.6.min.js"></script>
<script type="text/javascript">
	
$(function(){
	
	/* 提交表单 */
	$('#saveBtn').click(function() {
		var name = $('#name').val();
		var startTime = $('#startTime').val();
		var endTime = $('#endTime').val();
		var bgColor = $('#bgColor').val();
		var btnColor = $('#btnColor').val();
		var btnTextColor = $('#btnTextColor').val();
		var shareText = $('#shareText').val();
		var baseNumber = $('#baseNumber').val();
		var pvBaseNumber = $('#pvBaseNumber').val();
		
		if(!name){
			alert('活动名称不能为空！');
			return;
		}
		if(!bgColor){
			alert('背景颜色不能为空！');
			return;
		}
		if(!btnColor){
			alert('按钮颜色不能为空！');
			return;
		}
		if(!btnTextColor){
			alert('按钮内的文字颜色不能为空！');
			return;
		}
		if(!startTime){
			alert('活动开始时间不能为空！');
			return;
		}
		if(!endTime){
			alert('活动结束时间不能为空！');
			return;
		}
		if(!shareText){
			alert('微信分享语不能为空！');
			return;
		}
		if(!baseNumber){
			alert('报名基数不能为空！');
			return;
		}
		if(baseNumber < 0){
			alert('报名基数不能小于0！');
			return;
		}
		if(!pvBaseNumber){
			alert('关注人数基数不能为空！');
			return;
		}
		if(pvBaseNumber < 0){
			alert('关注人数基数不能小于0！');
			return;
		}
		
		var x1 = Date.parse(startTime);
		var x2 = Date.parse(endTime);
		var x3 = x2 - x1;
		if(x3 < 0 ){//时间差小于0，提示重新输入
			alert('活动开始时间不能大于活动结束时间！');
			return;
		}
	
	
		var formData = new FormData($('#addActivityForm')[0]);
		$.ajax({
			type : 'post',
			url : "${pageContext.request.contextPath}/back/activity/addActivity",
			data : formData,
			cache : false,
			processData : false,
			contentType : false,
		}).success(function(data) {
			if(data){
				if(data.rspCode == 1){
					alert(data.rspMsg);
					window.location.href="${pageContext.request.contextPath}/back/activity/findActivities/1/10";
				}else{
					alert(data.rspMsg);
				}
			}
		}).error(function() {
		});
	});
	
	/* 初始化时间插件 */
	 $('#startTime').datetimepicker({
	    format: 'yyyy-mm-dd hh:ii:ss',
	    language:'zh-CN',
	    autoclose:true,
	    todayBtn:"linked",
	    minuteStep:1
	});
	
	$('#endTime').datetimepicker({
	    format: 'yyyy-mm-dd hh:ii:ss',
	    language:'zh-CN',
	    autoclose:true,
	    todayBtn:"linked",
	    minuteStep:1
	});
	
	const jpickerSettings= {
          window:
          {
        	  position:
              {
                x: 'screenCenter', /* acceptable values "left", "center", "right", "screenCenter", or relative px value */
                y: 'bottom' /* acceptable values "top", "bottom", "center", or relative px value */
              },
            expandable: true
          },
          images:
          {
            //clientPath: '/'+document.location.pathname.split("/")[1]+'/commons/jpicker-1.1.6/images/', /* Path to image files */
            clientPath: '${pageContext.request.contextPath}/resources/jpicker-1.1.6/images/', /* Path to image files */
          },
          localization: /* alter these to change the text presented by the picker (e.g. different language) */
          {
            text:
            {
              title: '拖动鼠标选中一个颜色',
              newColor: '选中颜色',
              currentColor: '当前颜色',
              ok: '确定',
              cancel: '取消'
            },
            tooltips:
            {
              colors:
              {
                newColor: '点击‘确定’提交新选颜色',
                currentColor: '点击这里还原当前颜色'
              },
              buttons:
              {
                ok: '提交选中的颜色',
                cancel: '取消并恢复当前颜色'
              }
            }
          }
          
        };
	
	 /* 背景颜色 */
	 $("#bgColor").jPicker(jpickerSettings);
	 /* 按钮颜色 */
	 $("#btnColor").jPicker(jpickerSettings);
	 /* 按钮文字颜色 */
	 $("#btnTextColor").jPicker(jpickerSettings);
	/************************jpicker********************************/
	
	
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
            
             <div class="rgtit">
                <ul>
                    <li class="sele"><span>添加活动</span></li>
                </ul>
                <div class="clear"></div>
            </div>
            
            <div class="rgcon bodybai">
                <div class="formdiv">
                	<form id="addActivityForm" >
	                     <table  border="0" cellspacing="0" cellpadding="0" class="contab contab-wid">
	                          <tr>
	                            <th>活动名称：</th>
	                            <td><input id="name"  name="name" type="text" class="form-control myinput" ></td>
	                          </tr>
	                          <tr >
	                            <th>活动图片：</th>
								<td ><input style="border: none;" id="banner"  name="banner" type="file" class="form-control myinput" ><font style="color:red;">（建议图片尺寸：1080*1423，大小不超过100KB）</font></td>
	                          </tr>
	                          <tr >
	                            <th>背景音乐：</th>
								<td ><input style="border: none;" id="music"  name="music" type="file" class="form-control myinput" ><font style="color:red;">（建议音乐文件大小不超过 1MB）</font></td>
	                          </tr>
	                          <tr >
	                            <th>背景颜色：</th>
								<td ><input  id="bgColor"  name="bgColor" type="text" class="form-control myinput" ></td>
	                          </tr>
	                          <tr >
	                            <th>按钮颜色：</th>
								<td ><input  id="btnColor"  name="btnColor" type="text" class="form-control myinput" ></td>
	                          </tr>
	                          <tr >
	                            <th>按钮内的文字颜色：</th>
								<td ><input  id="btnTextColor"  name="btnTextColor" type="text" class="form-control myinput" ></td>
	                          </tr>
	                          <tr>
	                            <th>活动开始时间：</th>
	                            <td><input id="startTime"  name="startTime" type="text" class="form-control myinput" ></td>
	                          </tr>
	                          <tr>
	                            <th>活动结束时间：</th>
	                            <td><input id="endTime" name="endTime" type="text" class="form-control myinput" ></td>
	                          </tr>
	                          <tr >
	                            <th>微信分享图片：</th>
								<td ><input style="border: none;" id="shareImg"  name="shareImg" type="file" class="form-control myinput" > <font style="color:red;">（建议图片尺寸：200*200，大小不超过20KB）</font></td>
	                          </tr>
	                          <tr>
	                            <th>微信分享语：</th>
	                            <td>	<textarea id="shareText" name="shareText" rows="7" class="form-control myinput"></textarea> </td>
	                          </tr>
	                          <tr>
	                            <th>报名基数：</th>
	                            <td>	<input  id="baseNumber"  name="baseNumber" type="number" class="form-control myinput" value="0"> </td>
	                          </tr>
	                          <tr>
	                            <th>关注人数基数：</th>
	                            <td>	<input  id="pvBaseNumber"  name="pvBaseNumber" type="number" class="form-control myinput" value="0"> </td>
	                          </tr>
	                          <tr>
	                            <th>备注：</th>
	                            <td><input id="remark" name="remark" type="text" class="form-control myinput" ></td>
	                          </tr>
	                      </table>
	                        
	                      <div class="but-div">
	                      	<button id="saveBtn" type="button" class="btn btn-info but120">保存</button>
	                      	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                      	<button onclick="javascript:history.back(-1);" type="button" class="btn btn-info but120">返回</button>
	                      </div>
                      </form>
                 </div>
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
								<a id="chgPwd_close" class="closegb" aria-hidden="true" data-dismiss="modal"></a>
								<h4 class="modal-title">修改密码</h4>
							</div>

								<div class="modal-body yc-body">
									<div class="yc-body-nr">
										<table border="0" cellspacing="0" cellpadding="0" class="contab-tc contab-wid2" style="margin-top:20px;">
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
										<button type="button" id="chgPwdSaveBtn" class="btn btn-info px14 padlr buml10"
											style="width:100px;">保存</button>
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