//var basePath=getRootPath();


var loadScript = function(url, callback) {
	var head= document.getElementsByTagName('head')[0];  
	var script= document.createElement('script');  
	script.type= 'text/javascript';  
	script.onreadystatechange= function () {  
	     if (this.readyState == 'complete') 
	     callback();  
	   }     
	script.onload= function(){  
	    callback(); 
	 }  
	script.src= url;  
	head.appendChild(script);  
};

var jssdk;
function share(){
	loadScript('http://oauth.bestchinaunicom.cn/wxapi_proxy/resources/sea.js', function() {
		seajs.use(["http://oauth.bestchinaunicom.cn/wxapi_proxy/resources/jssdk/jssdk.js"], function(jssdk) {
				try {
					window.jssdk=jssdk;
					shareCustom(jssdk);
				} catch (E) {
					shareCustom(jssdk);
				}
			});
	});

}

//放到jsp 页面--如果固定连接，就不动
var shareCustom=function(jssdk) {
	jssdk.shareCustom(
		'wolegou', 
		productName, 
		productSubName,
		coverImg, 
		shareUrl, 
		function(type, result, parmar) {
				// console.log(type,result,parmar);
		});
};
share();