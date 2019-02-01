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
		<title>${activity.name }</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/front/css/cee.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/front/js/jquery-1.11.0.min.js" ></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/front/js/jquery.js" ></script>
        <script src="${pageContext.request.contextPath}/resources/front/js/jquery.mobilePhoneNumber.js"></script>
        <script src="${pageContext.request.contextPath}/resources/front/js/jquery.caret.js"></script>
        <script type="text/javascript">
			var coverImg = "${wxShareImgUrl}";
			var productName = '${activity.name}';
			var productSubName = "${activity.shareText}";
			var shareUrl = '${wxShareUrl}';//当前点击者的分享链接
			function selectCg(){
				var text = $('#salarytype').find("option:selected").text();
				$('#county').text(text);
			}
		</script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/front/js/wx_share.js"></script>
		<style>
		    .content{max-width: 720px;background-color: #${activity.bgColor}; position: relative;}
			.guanzhu {width: 86%;margin-left: 7%;margin-top: 4px;   overflow: hidden;
	                  background-color: #${activity.btnColor};border-radius: 10px;text-align: center; position:relative;}
			.word1{margin-top: 10px; font-size: 40px;color: #${activity.btnTextColor};font-weight: 1200; padding-bottom:10px; line-height:1.1em;}
			.word2{font-size: 14px;color: #${activity.btnTextColor}; font-weight: 600;
			       margin-top: -30px;display: block; position:absolute; right:10px; bottom:10px;}	
			.time {width: 86%;margin: auto;margin-top: 14px; overflow: hidden;background-color: black;}	
			.word5{font-size: 81px;
					font-weight: normal;
					font-stretch: normal;
					letter-spacing: 8px;
					color: #ffffff;
					box-shadow: 4px 14px 18px 0px 
						rgba(255, 146, 102, 0.77);}	
			.img7{width: 15%;margin-left: 7%;}	 
			.word6{margin-left: 25%;
				font-size: 15px;color: #ffffff;}			
			table{width: 86%;margin-left: 7%;margin-top:15px;border: none;}	
			tr{border: 1px solid white;color: white;font-size: 14px;}
			td{text-align: center;border: 1px solid white;color: white;font-size: 14px; padding:8px 5px; line-height:1.6em;}	
			.signup{width :53%; margin-left:23%;margin-top: 40px;}
			.footer{margin-top: 25px;}	
			
			.tankuang input{margin-left: 12%;width: 76%;border-radius: 20px;height: 50px;
			border: none; box-sizing: border-box; padding: 0px 40px;font-size: 16px;}	
			img{width: 100%;}        	
		</style>
		
		
		<script type="text/javascript">
			const DAY = 24*60*60*1000;
			const HOUR = 60*60*1000;
			const MINUTE = 60*1000;
			const SECOND = 1000;
			const ENDTIME = ${endTime};
			const PHONE_REGEX = /^1\d{10}$/;
			
			
			function formateNumGetBasicPhone(v){
			    return $.trim(v).replace("+86",'');
			}
			
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
				
				/* 立即报名按钮*/
			 	$('#signupImg').click(function(){
			 		var date = new Date();
					var nowTime = date.getTime();
					var time = ENDTIME - nowTime;
			 		if(time <= 0){//活动已结束
			 			alert('活动已结束！');
			 			return;
			 		}
			 		//打开弹层
			 		$('#tanceng').show();
			 	});
			 	
			 	$('#closeBtn').click(function(){
			 		$('#tanceng').hide();
			 	})
				
				
				/* 确认报名 */
				$('#signupBtn').click(function(){
					var id = $('#aid').val();
					
					var name = $('#name').val();
					var phone=formateNumGetBasicPhone($("#phone").mobilePhoneNumber('val'));
					/* var phone = $('#phone').val(); */
					var county = $('#salarytype').val();
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
								'county':county
							},
						   function(data){
						   		if(data.rspCode == 1){
						   			location.replace(window.location.href);
						   		}else{
						   			$('#tanceng').attr("display","none");//关掉弹层
						   			alert(data.rspMsg);
						   		}
						   },
					 "json");
					
				});
				
				
			})
			
						//--创建页面监听，等待微信端页面加载完毕 触发音频播放
document.addEventListener('DOMContentLoaded', function () {
    function audioAutoPlay() {
        var audio = document.getElementById('musicfx');
            audio.play();
        document.addEventListener("WeixinJSBridgeReady", function () {
            audio.play();
        }, false);
    }
    audioAutoPlay();
});

			
		</script>
	</head>
	
	
<style type="text/css">
	#musicControl { position:fixed;right:10px;top:10px;display:inline-block;}
	#musicControl a { display:inline-block;width:30px;height:30px;overflow:hidden;background-image:url('http://wxdata.52116.cn/static/img/mcbg4.png');background-repeat: no-repeat;background-size:30px auto;}
	#musicControl a audio{width:100%;height:30px;}
	#musicControl a.stop { background-position:0px bottom;}
	#musicControl a.on { background-position:0px 0px;-webkit-animation:reverseRotataZ 1.2s linear infinite;}
	#music_play_filter{width:100%;height:100%;overflow:hidden;position:fixed;top:0;left:0;z-index:99999998;}
	@-webkit-keyframes reverseRotataZ{
		0%{-webkit-transform: rotateZ(0deg);}
		100%{-webkit-transform: rotateZ(-360deg);}
	}
</style>

	
	<body>
		<input type="hidden" value="${activity.id}" id="aid">
		<div class="content">
			<!-- 播放器 -->
			<div id="music_play_filter" onclick="just_play(1)"></div>
		    <span id="musicControl">
		    <a id="mc_play" class="on" onclick="play_music();">
				<audio id="musicfx" loop="loop" autoplay="autoplay">
					<source src="${pageContext.request.contextPath}/${activity.musicUrl}" type="audio/mpeg" />
				</audio>
			</a>
			</span>
			<!-- 播放器 -->
			<div class="di">
				<img  src="${pageContext.request.contextPath}/${activity.bannerUrl}"/>
				<c:if test="${!empty activity.img2 && !empty activity.img2Href}">
					<div  style="margin-left: 7%;margin-bottom:30px; width: 86%;border-radius: 10px;">
	                	<a href="${activity.img2Href }"><img style="width: 100%;" src="${pageContext.request.contextPath}/${activity.img2}" /></a>
	                </div>
				</c:if>
				<div class="guanzhu">
					<div class="word1"> ${activity.pv + activity.pvBaseNumber}人正在关注</div>
				</div>
				<img style="width: 38%;margin-left: 31%;margin-top: 40px;" src="${pageContext.request.contextPath}/resources/front/img/ing-juhui.png" />
				<div class="time" >
						<img style="width: 36%;margin-left: 32%;margin-top:20px;" src="${pageContext.request.contextPath}/resources/front/img/img-huodong.png" />
							<div class="djs">
                                <table  border="0" cellspacing="0" cellpadding="0" class="tabdjs">
                                  <tr>
                                    <td>
                                        <div class="jsspan">
                                            <span class="xian"></span>
                                            <div id="whole_day" class="divx"></div>
                                        </div>
                                    </td>
                                    <td class="imgdian"><img  src="${pageContext.request.contextPath}/resources/front/img/img-dian.png" /></td>
                                    <td>
                                        <div class="jsspan">
                                            <span class="xian"></span>
                                            <div id="whole_hour" class="divx"></div>
                                        </div>
                                    </td>
                                    <td class="imgdian"><img  src="${pageContext.request.contextPath}/resources/front/img/img-dian.png" /></td>
                                    <td>
                                        <div class="jsspan">
                                            <span class="xian"></span>
                                            <div id="whole_minute" class="divx"></div>
                                        </div>
                                    </td>
                                    <td class="imgdian"><img  src="${pageContext.request.contextPath}/resources/front/img/img-dian.png" /></td>
                                    <td>
                                        <div class="jsspan">
                                            <span class="xian"></span>
                                            <div id="whole_second" class="divx"></div>
                                        </div>
                                    </td>
                                  </tr>
                                  <tr>
                                    <th>天</th>
                                    <th>&nbsp;</th>
                                    <th>时</th>
                                    <th>&nbsp;</th>
                                    <th>分</th>
                                    <th>&nbsp;</th>
                                    <th>秒</th>
                                  </tr>
                                  
                                </table>

                            </div>
							<!--<div class="time2"  style=" width: 11%;margin-left: 12%; background-color: #A30602;
								position: relative; border-radius:10px ;overflow: hidden;">
								<div class="line"  style="width: 100%;height: 4px;background-color: black;margin-top: 49%;"></div>
								<b class="word4" style="font-size: 30px;color: #fff;position: absolute;top: 10px;left: 13px;">88</b>
							</div>
							<img style="width: 1.4%;" src="${pageContext.request.contextPath}/resources/front/img/img-dian.png" />
							
							
							<div class="time3">
								<div class="line"></div>
								<b class="word7">88</b>
							</div>
							<img style="width: 1.4%;" src="${pageContext.request.contextPath}/resources/front/img/img-dian.png" />
							
							<div class="time4">
								<div class="line"></div>
								<b class="word8">88</b>
							</div>
							<img style="width: 1.4%;" src="${pageContext.request.contextPath}/resources/front/img/img-dian.png" />
							<div class="time5">
								<div class="line"></div>
								<b class="word9">88</b>
							</div>-->
			    </div>		
				</div>
                
                <img src="${pageContext.request.contextPath}/resources/front/img/img-6.png" style="margin-top:20px; width: 58%; margin-left: 25%"/>
                <div class="jstab">
                     <div class="jstab-rg">活动预定人数：${customer_count + activity.baseNumber}人</div>
                </div>
				
				
				
				<form>
					<table  style="border-collapse: collapse;" border="3px"  bordercolor="#fff"  cellpadding="0px" cellspacing="0">
						<tr>
							<td style="width: 10%;">编号</td>
							<td  style="width: 20%;">姓名</td>
							<td  style="width: 30%;">联系电话</td>
							<td  style="width: 40%;">报名时间</td>
						</tr>
						<c:forEach items="${ customer_list}" var="customer_map" varStatus="vs">
						<tr>
							<td>${customer_map.number + activity.baseNumber}  </td>
							<%-- <td>${vs.count }</td> --%>
							<td>${customer_map.customer.name }</td>
							<td>${customer_map.customer.phone }</td>
							<td>
								<fmt:formatDate value="${customer_map.customer.createTime }" pattern="yyyy-MM-dd"/><br>
								<fmt:formatDate value="${customer_map.customer.createTime }" pattern="HH：mm：ss"/>
								
							 </td>
						</tr>
					</c:forEach>
					</table>
				</form>
				<!-- <div id="signupImg" class="guanzhu" style="margin:auto; width: 50%; max-width:600px; position: fixed;margin: auto;bottom: 20px;left: 50%; transform: translate(-50%,0); -webkit-transform: translate(-50%,0);
					border-radius: 10px;text-align: center;line-height: 40px;">
					<div class="word1"  style="margin-top: 15px;padding-bottom: 15px; font-size: 40px;">立即报名</div>
				</div> -->
				
				<div id="signupImg" class="fuceng" style="width: 100%;height: 80PX;position: fixed;bottom: 0px;left: 50%;transform: translate(-50%,0);
					 -webkit-transform: translate(-50%,0);background-color: rgba(255,255,255,0.5);max-width: 750px;margin: auto;" >
				    <div style="width: 56%;max-width: 600px; background-color:#ffe92f ;margin: auto;
					border-radius: 10px;margin-top: 10px;margin-left:23%; font-size: 20px;color: white;text-align: center;line-height: 40px;">
						<div class="word1"  style="padding: 10px; font-size: 40px;">立即疯抢</div>
					</div>
			    </div> 
				
				
				
				<%-- <img id="signupImg" class="signup" style="cursor: pointer;" src="${pageContext.request.contextPath}/resources/front/img/img-button.png"/> --%>
				<img class="footer" src="${pageContext.request.contextPath}/resources/front/img/img-footer.png"/>
			</div>
			
			<!--弹框开始-->
            
            <div id="tanceng" class="mengban" style="display: none;" >
                <table  border="0" cellspacing="0" cellpadding="0" class="tckn">
                  <tr>
                    <td>
                        <div class="share_fx_fxtc zoomIn0s" style="max-width:320px;">
                           <span id="closeBtn" class="tcclose"></span>
                            <div class="share_fx_fxtcnr2">
                                 <div class="tcbr">
                                     <dl class="dltc">
                                         <dt>用户资料填写</dt>
                                         <dd><input id="name" type="text" class="input-dl" placeholder="请输入您的姓名"></dd>
                                         <dd><input id="phone" type="tel"  class="input-dl" placeholder="请输入您的手机号码" style="font-size:20px;"></dd>
                                          <!--新增区域-->
                                         <dd>
                                             <div class="xzds">
                                                 <div class="xzdsn">
                                                     <div class="dishitab">
                                                         <div class="dishitab-lf"><div class="wnqx">渭南市</div></div>
                                                         <div class="dishitab-rg">
                                                             <div class="xxselect">
                                                                   <div class="selt">
                                                                        <span id="county" class="sval c_tdefault">区/县选择</span>	
                                                                        <span  class="sval" style="display:none">临渭区</span>	
                                                                        <select id="salarytype" onchange="selectCg()">							
                                                                            <option value="临渭区">临渭区</option>
                                                                            <option value="华州区">华州区</option>
                                                                            <option value="潼关">潼关县</option>
                                                                            <option value="大荔">大荔县</option>
                                                                            <option value="蒲城">蒲城县</option>
                                                                            <option value="澄城">澄城县</option>
                                                                            <option value="白水">白水县</option>
                                                                            <option value="合阳">合阳县</option>
                                                                            <option value="富平">富平县</option>
                                                                            <option value="韩城">韩城县</option>
                                                                            <option value="华阴">华阴县</option>
                                                                        </select>
                                                                    </div>
                                                                  </div>
                                                         </div>
                                                     </div>
                                                 </div>
                                             </div>
                                         </dd>
                                         <!--新增区域结束-->
                                         <dd><p class="perror"></p></dd>
                                         <dd>
                                             <div class="butdiv"><a id="signupBtn" href="javascript:;"><img src="${pageContext.request.contextPath}/resources/front/img/img-button2.png"></a></div>
                                         </dd>
                                     </dl>
                                      <script>
			                            jQuery(function($){
			                                  var input = $("#phone")
			                                  input.mobilePhoneNumber({allowPhoneWithoutPrefix: '+86'});
			                                });
			                            </script>
                                 </div>
                                 
                                 
                                
                            </div>
                        </div>
                    </td>
                  </tr>
                </table>
            </div>
                        
			<!--弹框结束-->
			
			<!--弹框开始-->
			<%-- <div id="tanceng" class="tankuang" style="position: fixed;top:0px;right: 0px;left: 0px;bottom: 0px; max-width: 720px;background-color: #a30602;display: none;">
				<img class="close" src="${pageContext.request.contextPath}/resources/front/img/icon-close.png"   style="position: absolute;right: 10px;top: 10px; width: 4%;"/>
				<img src="${pageContext.request.contextPath}/resources/front/img/img-head1.png"/>
			    <p class="name" style="font-size: 24px;margin-left: 12%;margin-top:0px;color: white;">您的姓名：</p>
				<input type="text" />	
				<p class="phone" style="font-size: 24px;margin-left: 12%;color: white;">您的联系电话：</p>
				<input type="text" />
				<img class="signup" style="width:53%;margin-top: 30px;margin-left: 23%;"  src="${pageContext.request.contextPath}/resources/front/img/img-button2.png"/>
				<div style="height: 40px;"></div>
			</div> --%>
			<!--弹框结束-->
			
		</div>
		
		<script>
			$(function  () {
				$(".signup").click( function (){
					$(".tankuang").show();
					$(".di").hide();
				});
				$(".close").click( function (){
					$(".tankuang").hide();
					$(".di").show();
				});
				});
        </script>
	</body>
</html>
<script type="text/javascript">
	function just_play(id){
		$('#mc_play audio').get(0).play();
		$('#mc_play').attr('class','on');
		if (typeof(id)!='undefined'){
			$('#music_play_filter').hide();
		}
	}
	function play_music(){
		if ($('#mc_play').hasClass('on')){
			$('#mc_play audio').get(0).pause();
			$('#mc_play').attr('class','stop');
		}else{
			$('#mc_play').attr('class','on');
		}
		$('#music_play_filter').hide();
	}
var play_filter=document.getElementById('music_play_filter');
play_filter.addEventListener('click', function(){
	just_play(1);
});
play_filter.addEventListener('touchstart', function(){
	just_play(1);
});
play_filter.addEventListener('touchend', function(){
	just_play(1);
});
play_filter.addEventListener('touchmove', function(){
	just_play(1);
});
play_filter.addEventListener('mousedown', function(){
	just_play(1);
});
play_filter.addEventListener('mouseup', function(){
	just_play(1);
});
play_filter.addEventListener('mousemove',function(){
	just_play(1);
});
</script>
