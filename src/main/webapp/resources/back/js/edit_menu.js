/*---------------全局数据模块start---------------*/
/*定义菜单对象*/
function MenuObj(myid,mypid,seq) {
	this.id;//后台用
	this.pid;//后台用
    this.myid = myid;//固定值，前台用
    this.childable = false;//能否拥有子菜单。默认不能，固定值，前台用
    this.mypid = mypid;//固定值，前台用
    
    this.deleted = true;//是否已删除。默认已删除，前后台用
    this.hasChild = false;//是否有子菜单。默认没有子菜单
    this.replyType;//该菜单的回复消息类型  1文本   2图片   3语音   4视频    5图文   6音乐    7小程序
    this.replyContent ;// 回复消息内容（不包括图文）
    this.seq = seq;//顺序 一级菜单：1~3对应从左到右，二级菜单：1~5对应从上到下
    
    this.name;// 菜单名称
    this.type;//菜单类型
    this.url;//跳转链接
    this.media_id;
    this.miniappid;//小程序类型使用
    this.pagepath;//小程序类型使用
}

//回复消息内容对象
function replyContentObj(){
	this.menuId;// 所属菜单的id
	this.newsId;//图文消息id
	this.media_id;
	this.title;//消息标题
	this.description;//消息描述
	this.content;//文本消息内容
	this.musicUrl;
	this.hqMusicUrl;
	this.thumbMediaId;
	this.html;
	this.src;//图片本地路径
	this.videoSrc;
	this.voiceSrc;
}

/*新增数据开始*/
//menu1相关数据
var menu1 = new MenuObj(0,undefined,1);
menu1.childable = true;
//子菜单menu1_submenuX数据
var menu1_submenu1 = new MenuObj(1,0,5);
var menu1_submenu2 = new MenuObj(2,0,4);
var menu1_submenu3 = new MenuObj(3,0,3);
var menu1_submenu4 = new MenuObj(4,0,2);
var menu1_submenu5 = new MenuObj(5,0,1);
//menu2相关数据
var menu2 = new MenuObj(6,undefined,2);
menu2.childable = true;
//子菜单menu2_submenuX数据
var menu2_submenu1 = new MenuObj(7,6,5);
var menu2_submenu2 = new MenuObj(8,6,4);
var menu2_submenu3 = new MenuObj(9,6,3);
var menu2_submenu4 = new MenuObj(10,6,2);
var menu2_submenu5 = new MenuObj(11,6,1);
//menu3相关数据
var menu3 = new MenuObj(12,undefined,3);
menu3.childable = true;
//子菜单menu3_submenuX数据
var menu3_submenu1 = new MenuObj(13,12,5);
var menu3_submenu2 = new MenuObj(14,12,4);
var menu3_submenu3 = new MenuObj(15,12,3);
var menu3_submenu4 = new MenuObj(16,12,2);
var menu3_submenu5 = new MenuObj(17,12,1);
//新增的菜单集合
var menu = [menu1, menu1_submenu1, menu1_submenu2, menu1_submenu3, menu1_submenu4, menu1_submenu5, menu2, menu2_submenu1, menu2_submenu2, menu2_submenu3, menu2_submenu4, menu2_submenu5, menu3, menu3_submenu1, menu3_submenu2, menu3_submenu3, menu3_submenu4, menu3_submenu5];
/*新增数据结束*/

/*final数据开始*/
var finalmenu1 = undefined;
var finalmenu1_submenu1 = undefined;
var finalmenu1_submenu2 = undefined;
var finalmenu1_submenu3 = undefined;
var finalmenu1_submenu4 = undefined;
var finalmenu1_submenu5 = undefined;
var finalmenu2 = undefined;
var finalmenu2_submenu1 = undefined;
var finalmenu2_submenu2 = undefined;
var finalmenu2_submenu3 = undefined;
var finalmenu2_submenu4 = undefined;
var finalmenu2_submenu5 = undefined;
var finalmenu3 = undefined;
var finalmenu3_submenu1 = undefined;
var finalmenu3_submenu2 = undefined;
var finalmenu3_submenu3 = undefined;
var finalmenu3_submenu4 = undefined;
var finalmenu3_submenu5 = undefined;
//最终的菜单集合
var finalmenu =[finalmenu1,finalmenu1_submenu1,finalmenu1_submenu2,finalmenu1_submenu3,finalmenu1_submenu4,finalmenu1_submenu5,finalmenu2,finalmenu2_submenu1,finalmenu2_submenu2,finalmenu2_submenu3,finalmenu2_submenu4,finalmenu2_submenu5,finalmenu3,finalmenu3_submenu1,finalmenu3_submenu2,finalmenu3_submenu3,finalmenu3_submenu4,finalmenu3_submenu5];
var originalSeq = new Array(18);
/*final数据结束*/

//当前模式
var currentPattern = 'add';//新增为：add，编辑为：edit
//当前菜单编辑区对应的菜单编号
var currentAreaId;
//当前回复消息体div的id
var currentReplyId = "#div_news";//默认为图文id
/*---------------全局数据模块end---------------*/

/*---------------通用方法start---------------*/
/*隐藏*/
function myhide(obj) {
	obj.css("display", "none");
}

/*显示*/
function myshow(obj) {
	obj.css("display", "");
}

/*切换隐藏和显示的状态*/
function toggleDisplay(obj) {
    if($(obj).css('display')=='none'){
        $(obj).css('display','block');
    }else{
        $(obj).css('display','none');
    }
}

/*关闭编辑区域*/
function closeMenuArea() {
	myhide($('#addMenuArea'));
}

/*时间戳转日期*/
function formatDateTime(timeStamp) {
	var date = new Date();
	date.setTime(timeStamp);
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	m = m < 10 ? ('0' + m) : m;
	var d = date.getDate();
	d = d < 10 ? ('0' + d) : d;
	var h = date.getHours();
	h = h < 10 ? ('0' + h) : h;
	var minute = date.getMinutes();
	var second = date.getSeconds();
	minute = minute < 10 ? ('0' + minute) : minute;
	second = second < 10 ? ('0' + second) : second;
	return y + '年' + m + '月' + d + '日 ';
}
/*---------------通用方法end---------------*/

/*---------------页面js效果模块start---------------*/
/*清除左侧所有添加按钮的选中样式*/
function removeAllSelected(){
	$('#menuList li').removeClass('selected');
	$('#menuList li').removeClass('current');
}

/*清除右侧回复消息体的页面内容，并切换到相应内容*/
function clearReplyContentDiv(){
	//删除图文
	$('#div_news>div:first').empty();
	$('#div_news>div:last').css('display','');
	$('#div_news>div:first').css('display','none');
	//删除文本
	$('#textarea_text').val('');
	//删除图片
	$('#div_img>div:first img').attr('src','');
	$('#div_img>div:first i').text('');
	$('#div_img>div:last').css('display','');
	$('#div_img>div:first').css('display','none');
	//删除语音
	$('#div_voice>div:first').empty();
	$('#div_voice>div:last').css('display','');
	$('#div_voice>div:first').css('display','none');
	//删除视频
	$('#div_video>div:first').empty();
	$('#div_video>div:last').css('display','');
	$('#div_video>div:first').css('display','none');
}

/*刷新左侧页面效果*/
function refresh(currentMenu) {
	var $menuList = [$('#menua1'),$('#menu1_submenu1'),$('#menu1_submenu2'),$('#menu1_submenu3'),$('#menu1_submenu4'),$('#menu1_submenu5'),$('#menua2'),$('#menu2_submenu1'),$('#menu2_submenu2'),$('#menu2_submenu3'),$('#menu2_submenu4'),$('#menu2_submenu5'),$('#menua3'),$('#menu3_submenu1'),$('#menu3_submenu2'),$('#menu3_submenu3'),$('#menu3_submenu4'),$('#menu3_submenu5')];
	var index = currentMenu.myid;// 将当前菜单的id映射到数组的索引中，对应索引存储着对应myid菜单的jq对象
    if(currentMenu.deleted){
    	//要展示的菜单已删除，则显示添加图标
    	$menuList[index].html("<i class='icon14_menu_add'></i>");
    }else{
        //未删除则显示name
    	$menuList[index].html("<i class='icon20_common sort_gray'></i><span class='js_l1Title'>"+currentMenu.name+"</span>");
    }

}

//根据菜单类型刷新内容
function refreshByType(){
	//当前菜单类型
	var type = $("input[name='menu_type']:checked").val();
	if(type){
		switch (type) {
			case 'click'://回复消息
				$('#click_div').css('display','');
				$('#view_tr').css('display','none');
				$('#miniprogram_tr1').css('display','none');
				$('#miniprogram_tr2').css('display','none');
				$('#miniprogram_tr3').css('display','none');
				break;
			case 'view'://跳转链接
				$('#view_tr').css('display','');
				$('#click_div').css('display','none');
				$('#miniprogram_tr1').css('display','none');
				$('#miniprogram_tr2').css('display','none');
				$('#miniprogram_tr3').css('display','none');
				break;
			case 'miniprogram'://跳转小程序
				$('#miniprogram_tr1').css('display','');
				$('#miniprogram_tr2').css('display','');
				$('#miniprogram_tr3').css('display','');
				
				$('#view_tr').css('display','none');
				$('#click_div').css('display','none');
				break;
		}
	}else{
		$('#view_tr').css('display','none');
		$('#click_div').css('display','none');
		$('#miniprogram_tr1').css('display','none');
		$('#miniprogram_tr2').css('display','none');
		$('#miniprogram_tr3').css('display','none');
	}
}
/*---------------页面js效果方法模块end---------------*/

/*---------------页面中数据操作模块start---------------*/


/*删除菜单*/
function deleteMenu(Id){
    //获取当前菜单
    var currentMenu = menu[Id];
    //判断是否拥有子菜单
    if(currentMenu.hasChild){
        //如果有子菜单,提示确认是否迭代删除
        Ewin.confirm({ message: "当前要删除的菜单包含子菜单，确认删除所有？" }).on(function (e) {
            if (!e) {
                return;
            }else{
                //删除所有相关菜单
                currentMenu.hasChild =false;
                deleteMenu(currentMenu.myid);//删掉父菜单
                switch (currentMenu.myid){
                    case 0:
                        for(var i=1;i<6;i++){
                            if(!menu[i].deleted){
                                //如果子菜单存在，则删除
                                deleteMenu(i);
                            }
                        }
                        break;
                    case 6:
                        for(var i=7;i<12;i++){
                            if(!menu[i].deleted){
                                //如果子菜单存在，则删除
                                deleteMenu(i);
                            }
                        }
                        break;
                    case 12:
                        for(var i=13;i<17;i++){
                            if(!menu[i].deleted){
                                //如果子菜单存在，则删除
                                deleteMenu(i);
                            }
                        }
                        break;
                }
            }
        });
    }else{
        //没有子菜单，则直接删除
        //清空当前菜单的数据
        currentMenu.deleted = true;
        currentMenu.name = undefined;
        currentMenu.type = undefined;
        currentMenu.key = undefined;
        currentMenu.url = undefined;
        currentMenu.media_id = undefined;
        currentMenu.miniappid = undefined;
        currentMenu.pagepath = undefined;
        currentMenu.replyType = undefined;
        currentMenu.replyContent = undefined;
        //对所有子菜单执行
        if(currentMenu.myid != 0 && currentMenu.myid != 6 && currentMenu.myid != 12){
            //检测其父菜单是否还有子菜单，并更新hasChild属性
            var pId = currentMenu.mypid;
            //先假设父菜单没有子菜单
            menu[pId].hasChild = false;
            for(var i=1;i<18;i++){
                //不是子菜单，或者子菜单不存在，跳过循环
                if(i==6||i==12){
                    continue;
                }else{
                    if(menu[i].deleted){
                        continue;
                    }
                    //对于存在的子菜单，比较其父id和pId
                    //若条件始终不满足，说明没有该父菜单没有子菜单
                    if(menu[i].mypid == pId){
                        //相等说明当前父菜单还有子菜单
                        menu[pId].hasChild = true;
                    }
                }
            }
            if(!menu[pId].hasChild){//此时为临界删除状态
            	//删除操作的临界状态，父菜单已经没有子菜单，则父菜单type不为空
            	finalmenu[pId] = menu[pId];
            }
        }

        //更新右侧页面效果
        openAddMenuArea();
        
        //删除的若是一级菜单,则隐藏其子菜单区域
        switch (currentAreaId){
            case 0:
            	myhide( $('#submenuArea1'));
                break;
            case 6:
            	myhide( $('#submenuArea2'));
                break;
            case 12:
            	myhide( $('#submenuArea3'));
                break;
        }
        //刷新左侧效果
        refresh(currentMenu);
        finalmenu[Id] = menu[Id];//将删除的菜单数据放进finalmenu中
    }
}

/*保存单个菜单之前，检测菜单的内容是否符合要求*/
function checkMenuData($menu_type,$menu_url,$textarea_text,$show_img_src,currentReplyId){
	if($menu_type){//type存在
		if(!$menu_type.val()){//type值为空
			Ewin.alert({
				title : "系统提示",
				message : "当前菜单的类型不能为空，请添加后再保存",
			});
			return -1;
		}
		if($menu_type.val() == 'view'){//view类型,url不能为空
			if(!$menu_url.val().trim()){//url为空
				Ewin.alert({
					title : "系统提示",
					message : "当前菜单的跳转链接不能为空，请添加后再保存",
				});
				return -1;
			}else{
				var reg=new RegExp("^([hH][tT]{2}[pP]:/*|[hH][tT]{2}[pP][sS]:/*|[fF][tT][pP]:/*)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\\/])+(\\?{0,1}(([A-Za-z0-9-~]+\\={0,1})([A-Za-z0-9-~]*)\\&{0,1})*)$");
				if(!reg.test($menu_url.val().trim())){
					Ewin.alert({
						title : "系统提示",
						message : "当前菜单的跳转链接格式不合法",
					});
					return -1;
				}		
			}
		}
		
		if($menu_type.val() == 'miniprogram'){//miniprogram类型,url,miniappid,pagepath不能为空
			if(!$('#menu_miniurl').val().trim()){//url为空
				Ewin.alert({
					title : "系统提示",
					message : "当前菜单的小程序链接不能为空，请添加后再保存",
				});
				return -1;
			}else{
				var reg=new RegExp("^([hH][tT]{2}[pP]:/*|[hH][tT]{2}[pP][sS]:/*|[fF][tT][pP]:/*)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\\/])+(\\?{0,1}(([A-Za-z0-9-~]+\\={0,1})([A-Za-z0-9-~]*)\\&{0,1})*)$");
				if(!reg.test($('#menu_miniurl').val().trim())){
					Ewin.alert({
						title : "系统提示",
						message : "当前菜单的跳转链接格式不合法",
					});
					return -1;
				}		
			}
			if(!$('#menu_miniappid').val().trim()){//miniappid为空
				Ewin.alert({
					title : "系统提示",
					message : "当前菜单的小程序appid不能为空，请添加后再保存",
				});
				return -1;
			}
			if(!$('#menu_pagepath').val().trim()){
				Ewin.alert({
					title : "系统提示",
					message : "当前菜单的小程序pagepath不能为空，请添加后再保存",
				});
				return -1;
			}
		}
		
		if($menu_type.val() == 'click'){//click类型，回复内容不能为空
			if(currentReplyId == '#div_text'){//回复内容为文本，则对应textarea内容不为空
				if(!$textarea_text.val().trim()){//内容为空
					Ewin.alert({
						title : "系统提示",
						message : "当前菜单的文本回复内容不能为空，请添加后再保存",
					});
					return -1;
				}
			}else if(currentReplyId == '#div_img'){//回复内容为图片，则对应图片src内容不为空
				if(!$show_img_src.attr('src')){//src属性不存在
					Ewin.alert({
						title : "系统提示",
						message : "当前菜单的图片回复内容不能为空，请添加后再保存",
					});
					return -1;
				}
			}else if(currentReplyId == '#div_voice'){
				if(!$(currentReplyId+">div:first").html()){//为空
					Ewin.alert({
						title : "系统提示",
						message : "当前菜单的语音回复内容不能为空，请添加后再保存",
					});
					return -1;
				}
			}else if(currentReplyId == '#div_video'){
				if(!$(currentReplyId+">div:first").html()){//为空
					Ewin.alert({
						title : "系统提示",
						message : "当前菜单的视频回复内容不能为空，请添加后再保存",
					});
					return -1;
				}
			}else if(currentReplyId == '#div_news'){
				if(!$(currentReplyId+">div:first").html()){//为空
					Ewin.alert({
						title : "系统提示",
						message : "当前菜单的图文回复内容不能为空，请添加后再保存",
					});
					return -1;
				}
			}
		}
	}else {//type 为空
		Ewin.alert({
			title : "系统提示",
			message : "当前菜单内容为空，请添加后再保存",
		});
		return -1;
	}
}

/*根据页面排序刷新菜单seq值*/
function refreshMenuSeq(){
		//按页面顺序获取一级菜单li数组
		var $plis = $('#menuList>li');
		//按页面顺序获取二级菜单li数组（3个）
		var $slis1 = $('#submenu1>li');
		var $slis2 = $('#submenu2>li');
		var $slis3 = $('#submenu3>li');
		
		/*给一级菜单排序*/
		//根据数组顺序给相应id的menu对象的seq属性赋值
		for(var i = 0;i < $plis.length;i++){
			var liId = $plis[i].id;//获取对应的li标签id
			switch(liId){//根据liId给相应的对象赋值
				case "menu1":
					setMenuSeq(0,i);
					break;
				case "menu2":
					setMenuSeq(6,i);
					break;
				case "menu3":
					setMenuSeq(12,i);
					break;
			}
		}
	/*给二级菜单排序*/
		//根据顺序给相应的id的menu对象的seq属性赋值
		for(var i = 0;i < $slis1.length;i++){//$slis1
			var liId = $slis1[i].id;//获取对应的li标签id
			switch(liId){//根据liId给相应的对象赋值
				case "menu1_submenu1":
					setMenuSeq(1,i);
					break;
				case "menu1_submenu2":
					setMenuSeq(2,i);
					break;
				case "menu1_submenu3":
					setMenuSeq(3,i);
					break;
				case "menu1_submenu4":
					setMenuSeq(4,i);
					break;
				case "menu1_submenu5":
					setMenuSeq(5,i);
					break;
			}
		}
		for(var i = 0;i < $slis2.length;i++){//$slis2
			var liId = $slis2[i].id;//获取对应的li标签id
			switch(liId){//根据liId给相应的对象赋值
				case "menu2_submenu1":
					setMenuSeq(7,i);
					break;
				case "menu2_submenu2":
					setMenuSeq(8,i);
					break;
				case "menu2_submenu3":
					setMenuSeq(9,i);
					break;
				case "menu2_submenu4":
					setMenuSeq(10,i);
					break;
				case "menu2_submenu5":
					setMenuSeq(11,i);
					break;
			}
		}
		for(var i = 0;i < $slis3.length;i++){//$slis3
			var liId = $slis3[i].id;//获取对应的li标签id
			switch(liId){//根据liId给相应的对象赋值
				case "menu3_submenu1":
					setMenuSeq(13,i);
					break;
				case "menu3_submenu2":
					setMenuSeq(14,i);
					break;
				case "menu3_submenu3":
					setMenuSeq(15,i);
					break;
				case "menu3_submenu4":
					setMenuSeq(16,i);
					break;
				case "menu3_submenu5":
					setMenuSeq(17,i);
					break;
			}
		}
}

/*添加菜单*/
function addMenu() {
	/*检验表单数据*/
	var $menu_name = $('#menu_name');//菜单名称
	var $menu_type = $('input[name="menu_type"]:checked');//菜单类型
	var $menu_url = $('#menu_url');//view类型的url
	var $textarea_text = $('#textarea_text');//回复文本的内容
	var $show_img_src = $('#show_img_src');//回复图片路径
	
    var currentMenu = menu[currentAreaId];
    
    if(!$menu_name.val().trim()){
    	Ewin.alert({
			title : "系统提示",
			message : "当前菜单的名称不能为空，请添加后再保存",
		});
		return;
    }
    if(currentMenu.childable){ //该菜单是一级菜单
		if(!currentMenu.hasChild){//修改无后一级菜单，  type及相应内容不为空
			var res = checkMenuData($menu_type,$menu_url,$textarea_text,$show_img_src,currentReplyId);
			if(res == -1){
				return;
			}
		}
    	
        //添加之前必须将deleted的值变为false
        currentMenu.deleted = false;
        //存值
        currentMenu.name = $('#menu_name').val();//菜单名称
        currentMenu.type = $("input[name='menu_type']:checked").val();//菜单类型
        switch(currentMenu.type){
        	case "click":// 需要存储回复内容
        		currentMenu.url = undefined;
        		currentMenu.miniappid = undefined;
        		currentMenu.pagepath = undefined;
        		$('#menu_url').val('');
        		$('#menu_miniurl').val('');
        		$('#menu_miniappid').val('');
        		$('#menu_pagepath').val('');
        		var replyContent = new replyContentObj();
    			switch(currentReplyId){
    				case "#div_news":
    					//回复内容为图文
    					currentMenu.replyType = 5;
    					replyContent.newsId = $(currentReplyId+" i")[0].innerText;
    					replyContent.html = $(currentReplyId+">div:first").html();
    					break;
    				case "#div_text":
    					//回复内容为文本
    					currentMenu.replyType = 1;
    					replyContent.content = $('#textarea_text').val();
    					break;
    				case "#div_img":
    					//回复内容为图片
    					currentMenu.replyType = 2;
    					replyContent.media_id = $(currentReplyId+" i")[0].innerText;
    					replyContent.src =  $(currentReplyId+" img")[0].src;
    					break;
    				case "#div_voice":
    					//回复内容为语音
    					currentMenu.replyType = 3;
    					replyContent.media_id = $(currentReplyId+" input").val();
    					replyContent.html = $(currentReplyId+">div:first").html();
    					break;
    				case "#div_video":
    					//回复内容为视频
    					currentMenu.replyType = 4;
    					replyContent.title = $(currentReplyId+" .sp-tit")[0].innerText;
    					replyContent.description = $(currentReplyId+" em")[0].innerText;
    					replyContent.media_id = $(currentReplyId+" i")[0].innerText;
    					replyContent.html = $(currentReplyId+">div:first").html();
    					break;
    			}
    			currentMenu.replyContent = replyContent;
        		break;
        	case "view"://存储跳转链接即可
                currentMenu.key = undefined;
                currentMenu.media_id = undefined;
                currentMenu.miniappid = undefined;
                currentMenu.pagepath = undefined;
                currentMenu.replyType = undefined;
                currentMenu.replyContent = undefined;
                
                clearReplyContentDiv();
                $('#menu_miniappid').val('');
        		$('#menu_pagepath').val('');
        		$('#menu_miniurl').val('');
        		currentMenu.url = $('#menu_url').val();
        		break;
        	case "miniprogram"://存储url,appid,pagepath
        		currentMenu.key = undefined;
                currentMenu.media_id = undefined;
                currentMenu.replyType = undefined;
                currentMenu.replyContent = undefined;
                
                $('#menu_url').val('');
                clearReplyContentDiv();
        		currentMenu.url = $('#menu_miniurl').val();
        		currentMenu.miniappid = $('#menu_miniappid').val();
                currentMenu.pagepath = $('#menu_pagepath').val();
                break;
        }
        //刷新页面
        refresh(currentMenu);
        //关掉编辑区域
        closeMenuArea();
        finalmenu[currentAreaId] = menu[currentAreaId];
    }else{
        //该菜单是二级菜单
    	var res = checkMenuData($menu_type,$menu_url,$textarea_text,$show_img_src,currentReplyId);
    	if(res == -1){
			return;
		}
    	//添加之前必须将delete的值变为false
        currentMenu.deleted = false;
        //修改其父菜单的haschild为true
        menu[currentMenu.mypid].hasChild = true;
        menu[currentMenu.mypid].replyType = undefined;
        menu[currentMenu.mypid].replyContent = undefined;
        menu[currentMenu.mypid].url = undefined;
        menu[currentMenu.mypid].miniappid = undefined;
        menu[currentMenu.mypid].pagepath = undefined;
        // 如果一级菜单不是新建的，则给二级菜单添加pid
        if(menu[currentMenu.mypid].id){
        	currentMenu.pid = menu[currentMenu.mypid].id;
        }
        //更新final中的对应菜单
        if( menu[currentMenu.mypid].id){
        	if(menu[currentMenu.mypid].type){
        		//说明要修改已存在的菜单,将该数据更新到final中
                menu[currentMenu.mypid].type = undefined;
                menu[currentMenu.mypid].replyContent = undefined;
        		finalmenu[currentMenu.mypid] = menu[currentMenu.mypid];
        	}
        }
        
        //存值
        currentMenu.name = $('#menu_name').val();//菜单名称
        currentMenu.type = $("input[name='menu_type']:checked").val();//菜单类型
        switch(currentMenu.type){
        	case "click":// 需要存储回复内容
        		currentMenu.url = undefined;
        		var replyContent = new replyContentObj();
    			switch(currentReplyId){
    				case "#div_news":
    					//回复内容为图文
    					currentMenu.replyType = 5;
    					replyContent.newsId = $(currentReplyId+" i")[0].innerText;
    					replyContent.html = $(currentReplyId+">div:first").html();
    					break;
    				case "#div_text":
    					//回复内容为文本
    					currentMenu.replyType = 1;
    					replyContent.content = $('#textarea_text').val();
    					break;
    				case "#div_img":
    					//回复内容为图片
    					currentMenu.replyType = 2;
    					replyContent.media_id = $(currentReplyId+" i")[0].innerText;
    					replyContent.src =  $(currentReplyId+" img")[0].src;
    					break;
    				case "#div_voice":
    					//回复内容为语音
    					currentMenu.replyType = 3;
    					replyContent.media_id = $(currentReplyId+" input").val();
    					replyContent.html = $(currentReplyId+">div:first").html();
    					break;
    				case "#div_video":
    					//回复内容为视频
    					currentMenu.replyType = 4;
    					replyContent.title = $(currentReplyId+" .sp-tit")[0].innerText;
    					replyContent.description = $(currentReplyId+" em")[0].innerText;
    					replyContent.media_id = $(currentReplyId+" i")[0].innerText;
    					replyContent.html = $(currentReplyId+">div:first").html();
    					break;
    			}
    			currentMenu.replyContent = replyContent;
        		break;
        	case "view"://存储跳转链接即可
        		currentMenu.key = undefined;
                currentMenu.media_id = undefined;
                currentMenu.miniappid = undefined;
                currentMenu.pagepath = undefined;
                currentMenu.replyType = undefined;
        		currentMenu.replyContent = undefined;
        		currentMenu.url = $('#menu_url').val();
        		break;
        	case "miniprogram"://存储url,appid,pagepath
        		currentMenu.key = undefined;
                currentMenu.media_id = undefined;
                currentMenu.replyType = undefined;
                currentMenu.replyContent = undefined;
                
        		currentMenu.url = $('#menu_miniurl').val();
        		currentMenu.miniappid = $('#menu_miniappid').val();
                currentMenu.pagepath = $('#menu_pagepath').val();
                break;
        }
        //刷新页面
        refresh(currentMenu);
        //关掉编辑区域
        closeMenuArea();
        finalmenu[currentAreaId] = menu[currentAreaId];
    }
    currentAreaId = undefined;
    clearReplyContentDiv();
}

/*打开编辑区域*/
function openAddMenuArea(obj) {
    if(obj){
        //获取当前点击对象的id
        var objId = obj.attr('id');
        //设置currentAreaId
        switch (objId) {
            case "menua1":
                currentAreaId = menu1.myid;
                $('#title').html("菜单一");
                removeAllSelected();
                $('#menu1').addClass('selected');
                $('#menu1').addClass('current');
                break;
            case "menu1_submenu1":
                currentAreaId = menu1_submenu1.myid;
                $('#title').html("菜单一 -> 子菜单一");
                removeAllSelected();
                $('#menu1_submenu1').addClass('selected');
                $('#menu1_submenu1').addClass('current');
                break;
            case "menu1_submenu2":
                currentAreaId = menu1_submenu2.myid;
                $('#title').html("菜单一 -> 子菜单二");
                removeAllSelected();
                $('#menu1_submenu2').addClass('selected');
                $('#menu1_submenu2').addClass('current');
                break;
            case "menu1_submenu3":
                currentAreaId = menu1_submenu3.myid;
                $('#title').html("菜单一 -> 子菜单三");
                removeAllSelected();
                $('#menu1_submenu3').addClass('selected');
                $('#menu1_submenu3').addClass('current');
                break;
            case "menu1_submenu4":
                currentAreaId = menu1_submenu4.myid;
                $('#title').html("菜单一 -> 子菜单四");
                removeAllSelected();
                $('#menu1_submenu4').addClass('selected');
                $('#menu1_submenu4').addClass('current');
                break;
            case "menu1_submenu5":
                currentAreaId = menu1_submenu5.myid;
                $('#title').html("菜单一 -> 子菜单五");
                removeAllSelected();
                $('#menu1_submenu5').addClass('selected');
                $('#menu1_submenu5').addClass('current');
                break;
            case "menua2":
                currentAreaId = menu2.myid;
                $('#title').html("菜单二");
                removeAllSelected();
                $('#menu2').addClass('selected');
                $('#menu2').addClass('current');
                break;
            case "menu2_submenu1":
                currentAreaId = menu2_submenu1.myid;
                $('#title').html("菜单二 -> 子菜单一");
                removeAllSelected();
                $('#menu2_submenu1').addClass('selected');
                $('#menu2_submenu1').addClass('current');
                break;
            case "menu2_submenu2":
                currentAreaId = menu2_submenu2.myid;
                $('#title').html("菜单二 -> 子菜单二");
                removeAllSelected();
                $('#menu2_submenu2').addClass('selected');
                $('#menu2_submenu2').addClass('current');
                break;
            case "menu2_submenu3":
                currentAreaId = menu2_submenu3.myid;
                $('#title').html("菜单二 -> 子菜单三");
                removeAllSelected();
                $('#menu2_submenu3').addClass('selected');
                $('#menu2_submenu3').addClass('current');
                break;
            case "menu2_submenu4":
                currentAreaId = menu2_submenu4.myid;
                $('#title').html("菜单二 -> 子菜单四");
                removeAllSelected();
                $('#menu2_submenu4').addClass('selected');
                $('#menu2_submenu4').addClass('current');
                break;
            case "menu2_submenu5":
                currentAreaId = menu2_submenu5.myid;
                $('#title').html("菜单二 -> 子菜单五");
                removeAllSelected();
                $('#menu2_submenu5').addClass('selected');
                $('#menu2_submenu5').addClass('current');
                break;
            case "menua3":
                currentAreaId = menu3.myid;
                $('#title').html("菜单三");
                removeAllSelected();
                $('#menu3').addClass('selected');
                $('#menu3').addClass('current');
                break;
            case "menu3_submenu1":
                currentAreaId = menu3_submenu1.myid;
                $('#title').html("菜单三 -> 子菜单一");
                removeAllSelected();
                $('#menu3_submenu1').addClass('selected');
                $('#menu3_submenu1').addClass('current');
                break;
            case "menu3_submenu2":
                currentAreaId = menu3_submenu2.myid;
                $('#title').html("菜单三 -> 子菜单二");
                removeAllSelected();
                $('#menu3_submenu2').addClass('selected');
                $('#menu3_submenu2').addClass('current');
                break;
            case "menu3_submenu3":
                currentAreaId = menu3_submenu3.myid;
                $('#title').html("菜单三 -> 子菜单三");
                removeAllSelected();
                $('#menu3_submenu3').addClass('selected');
                $('#menu3_submenu3').addClass('current');
                break;
            case "menu3_submenu4":
                currentAreaId = menu3_submenu4.myid;
                $('#title').html("菜单三 -> 子菜单四");
                removeAllSelected();
                $('#menu3_submenu4').addClass('selected');
                $('#menu3_submenu4').addClass('current');
                break;
            case "menu3_submenu5":
                currentAreaId = menu3_submenu5.myid;
                $('#title').html("菜单三 -> 子菜单五");
                removeAllSelected();
                $('#menu3_submenu5').addClass('selected');
                $('#menu3_submenu5').addClass('current');
                break;
            default:
        }
    }
    $('#menu_name').val('');
    clearReplyContentDiv();
    $('#menu_url').val('');//清空跳转地址
    $('#menu_miniurl').val('');//清空跳转地址
    $('#menu_miniappid').val('');//清空appid
    $('#menu_pagepath').val('');//清空appid
    //判断当前对象的状态
    //如果是已删除状态，打开空页面
    var currentMenu = menu[currentAreaId];
    if(currentMenu.deleted){
    	//清空页面内容
        $('#menu_name').val('');
        $("input[name='menu_type']").prop("checked",false); //菜单类型取消选中
        $('#menu_url').val('');//清空跳转地址
        $('#menu_miniurl').val('');//清空跳转地址
        $('#menu_miniappid').val('');//清空appid
        $('#menu_pagepath').val('');//清空pagepath
        //清空消息体
     	clearReplyContentDiv();
        //页面不出现提示
        $('#js_innerNone').css('display','none');
        //所有属性可用
        $("input[name='menu_type']").attr("disabled",false);
        $('#menu_url').attr("disabled",false);
        $('#menu_miniurl').attr("disabled",false);
        $('#menu_miniappid').attr("disabled",false);
        $('#menu_pagepath').attr("disabled",false);
        $('#a_news').click();
        refreshByType();
    }else{
        //未删除状态，则带着数据打开编辑页面
        if(currentMenu.hasChild){
            //如果有子菜单，则只能操作name属性
            //将页面属性设为空，并且设为不可用
            $('#menu_name').val(currentMenu.name);
            $('#menu_url').val('');
            $('#menu_miniurl').val('');
            $('#menu_miniappid').val('');//清空appid
            $('#menu_pagepath').val('');//清空pagepath
            
            $("input[name='menu_type']").attr("disabled",true);
            $("input[name='menu_type']").prop("checked",false);
            refreshByType();
            clearReplyContentDiv();
            //将该菜单其余属性设为空
            currentMenu.type = undefined;
            currentMenu.url = undefined;
            currentMenu.replyContent = undefined;
            currentMenu.replyType = undefined;
            currentMenu.miniappid = undefined;
            currentMenu.pagepath = undefined;
            
          //同时打开二级菜单添加区域
            switch (currentAreaId){
                case 0:
                    toggleDisplay($('#submenuArea1'));
                    break;
                case 6:
                	toggleDisplay($('#submenuArea2'));
                    break;
                case 12:
                	toggleDisplay($('#submenuArea3'));
                    break;
            }
            //页面出现提示
            $('#js_innerNone').css('display','');
        }else{
           //如果没有子菜单，则正常显示
            //所有属性可用
            $("input[name='menu_type']").attr("disabled",false);
            $('#menu_url').attr("disabled",false);
            $('#menu_miniurl').attr("disabled",false);
            $('#menu_miniappid').attr("disabled",false);
            $('#menu_pagepath').attr("disabled",false);

            $('#menu_name').val(currentMenu.name);
            if(!currentMenu.type){
            	 $("input[name='menu_type']").prop("checked",false);
            }else{
	            switch(currentMenu.type){
		        	case "click":// 需要回显回复内容
		        		$("input[name='menu_type'][value='view']").prop('checked',false);
		        		$("input[name='menu_type'][value='click']").prop('checked',true);
		        		$("input[name='menu_type'][value='miniprogram']").prop('checked',false);
		    			switch(currentMenu.replyType){
		    				case 5:
		    					//回显内容为图文
		    					 $('#div_news>div:first').css('display','');
		    					 $('#div_news>div:last').css('display','none');
		    					 $("#div_news>div:first").html(currentMenu.replyContent.html);
		    					 $('#delete_show_news').click(function(){
		    					   		//删除图文
		    					   		$('#div_news>div:first').empty();
		    					   		
		    					   		$('#div_news>div:last').css('display','');
		    					   		$('#div_news>div:first').css('display','none');
		    					   });
		    					 $('#a_news').click();
		    					break;
		    				case 1:
		    					//回显内容为文本
		    					$('#div_text>div:first').css('display','');
		    					$('#div_text>div:last').css('display','none');
		    					$('#textarea_text').val(currentMenu.replyContent.content);
		    					$('#a_text').click();
		    					break;
		    				case 2:
		    					//回显内容为图片
		    					//回显在页面上
		    					$('#div_img>div:first').css('display','');
		    					$('#div_img>div:last').css('display','none');
		    					$('#div_img>div:first img').attr('src',currentMenu.replyContent.src);
		    					$('#div_img>div:first i').text(currentMenu.replyContent.media_id);
		    					
		    					$('#div_img>div:first').css('display','');
		    					$('#div_img>div:last').css('display','none');
		    					
		    					$('#a_img').click();
		    					break;
		    				case 3:
		    					//回显内容为语音
		    					 $('#div_voice>div:first').css('display','');
		    					 $('#div_voice>div:last').css('display','none');
		    					 $("#div_voice>div:first").html(currentMenu.replyContent.html);
		    					 $('#delete_show_voice').click(function(){
	    					   		//删除语音
	    					   		$('#div_voice>div:first').empty();
	    					   		
	    					   		$('#div_voice>div:last').css('display','');
	    					   		$('#div_voice>div:first').css('display','none');
	    					   	 });
		    					$('#a_voice').click();
		    					break;
		    				case 4:
		    					//回显内容为视频
		    					 $('#div_video>div:first').css('display','');
		    					 $('#div_video>div:last').css('display','none');
		    					 $("#div_video>div:first").html(currentMenu.replyContent.html);
		    					 $('#delete_show_video').click(function(){
		    					   		//删除视频
		    					   		$('#div_video>div:first').empty();
		    					   		
		    					   		$('#div_video>div:last').css('display','');
		    					   		$('#div_video>div:first').css('display','none');
		    					 });
		    					$('#a_video').click();
		    					break;
		    			}
		        		break;
		        	case "view"://回显跳转链接即可
		        		$("input[name='menu_type'][value='click']").prop('checked',false);
		        		$("input[name='menu_type'][value='view']").prop('checked',true);
		        		$('#menu_url').val(currentMenu.url);
		        		break;
		        	case "miniprogram"://回显数据
		        		$("input[name='menu_type'][value='click']").prop('checked',false);
	        			$("input[name='menu_type'][value='view']").prop('checked',false);
		        		$("input[name='menu_type'][value='miniprogram']").prop('checked',true);
		        		$('#menu_miniurl').val(currentMenu.url);
		        		$('#menu_miniappid').val(currentMenu.miniappid);
		        		$('#menu_pagepath').val(currentMenu.pagepath);
		        }
            }
            refreshByType();
            
            //同时打开二级菜单添加区域
            switch (currentAreaId){
                case 0:
                    toggleDisplay($('#submenuArea1'));
                    break;
                case 6:
                    toggleDisplay($('#submenuArea2'));
                    break;
                case 12:
                    toggleDisplay($('#submenuArea3'));
                    break;
            }
            //页面不出现提示
            $('#js_innerNone').css('display','none');
        }

    }

    $('#addMenuArea').css("display", "");
}

/*---------------页面中数据操作方法模块end---------------*/

/*---------------bootstrap 组建封装start---------------*/
(function ($) {

    window.Ewin = function () {
        var html = '<div id="[Id]" class="modal fade" role="dialog" aria-labelledby="modalLabel">' +
            '<div class="modal-dialog modal-sm">' +
            '<div class="modal-content">' +
            '<div class="modal-header">' +
            '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>' +
            '<h4 class="modal-title" id="modalLabel">[Title]</h4>' +
            '</div>' +
            '<div class="modal-body">' +
            '<p>[Message]</p>' +
            '</div>' +
            '<div class="modal-footer">' +
            '<button type="button" class="btn btn-default cancel" data-dismiss="modal">[BtnCancel]</button>' +
            '<button type="button" class="btn btn-primary ok" data-dismiss="modal">[BtnOk]</button>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>';


        var dialogdHtml = '<div id="[Id]" class="modal fade" role="dialog" aria-labelledby="modalLabel">' +
            '<div class="modal-dialog">' +
            '<div class="modal-content">' +
            '<div class="modal-header">' +
            '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>' +
            '<h4 class="modal-title" id="modalLabel">[Title]</h4>' +
            '</div>' +
            '<div class="modal-body">' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>';
        var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm');
        var generateId = function () {
            var date = new Date();
            return 'mdl' + date.valueOf();
        }
        var init = function (options) {
            options = $.extend({}, {
                title: "操作提示",
                message: "提示内容",
                btnok: "确定",
                btncl: "取消",
                width: 200,
                auto: false
            }, options || {});
            var modalId = generateId();
            var content = html.replace(reg, function (node, key) {
                return {
                    Id: modalId,
                    Title: options.title,
                    Message: options.message,
                    BtnOk: options.btnok,
                    BtnCancel: options.btncl
                }[key];
            });
            $('body').append(content);
            $('#' + modalId).modal({
                width: options.width,
                backdrop: 'static'
            });
            $('#' + modalId).on('hide.bs.modal', function (e) {
                $('body').find('#' + modalId).remove();
            });
            return modalId;
        }

        return {
            alert: function (options) {
                if (typeof options == 'string') {
                    options = {
                        message: options
                    };
                }
                var id = init(options);
                var modal = $('#' + id);
                modal.find('.ok').removeClass('btn-success').addClass('btn-primary');
                modal.find('.cancel').hide();

                return {
                    id: id,
                    on: function (callback) {
                        if (callback && callback instanceof Function) {
                            modal.find('.ok').click(function () { callback(true); });
                        }
                    },
                    hide: function (callback) {
                        if (callback && callback instanceof Function) {
                            modal.on('hide.bs.modal', function (e) {
                                callback(e);
                            });
                        }
                    }
                };
            },
            confirm: function (options) {
                var id = init(options);
                var modal = $('#' + id);
                modal.find('.ok').removeClass('btn-primary').addClass('btn-success');
                modal.find('.cancel').show();
                return {
                    id: id,
                    on: function (callback) {
                        if (callback && callback instanceof Function) {
                            modal.find('.ok').click(function () { callback(true); });
                            modal.find('.cancel').click(function () { callback(false); });
                        }
                    },
                    hide: function (callback) {
                        if (callback && callback instanceof Function) {
                            modal.on('hide.bs.modal', function (e) {
                                callback(e);
                            });
                        }
                    }
                };
            },
            dialog: function (options) {
                options = $.extend({}, {
                    title: 'title',
                    url: '',
                    width: 800,
                    height: 550,
                    onReady: function () { },
                    onShown: function (e) { }
                }, options || {});
                var modalId = generateId();

                var content = dialogdHtml.replace(reg, function (node, key) {
                    return {
                        Id: modalId,
                        Title: options.title
                    }[key];
                });
                $('body').append(content);
                var target = $('#' + modalId);
                target.find('.modal-body').load(options.url);
                if (options.onReady())
                    options.onReady.call(target);
                target.modal();
                target.on('shown.bs.modal', function (e) {
                    if (options.onReady(e))
                        options.onReady.call(target, e);
                });
                target.on('hide.bs.modal', function (e) {
                    $('body').find(target).remove();
                });
            }
        }
    }();
})(jQuery);
/*---------------bootstrap 组建封装end---------------*/

/*给menu对象的seq属性赋值*/
function setMenuSeq(myid,i){
	menu[myid].seq = i+1;
	if(originalSeq[myid]){
		//seq存在
		if(originalSeq[myid] != menu[myid].seq){
			// 和初始seq不同，则存入final
			finalmenu[myid] = menu[myid];
		}
	}else{
		if(finalmenu[myid]){
			finalmenu[myid].seq = menu[myid].seq;
		}
	}
}

$(function () {
/*---------------页面初始化模块start---------------*/
    
    //保存菜单
    $('#saveBtn').click(function () {
        addMenu();
    })
    
    //注册删除按钮的事件
    $("#deleteMenu").click(function () {
        Ewin.confirm({ message: "确认要删除当前选中的菜单吗？" }).on(function (e) {
            if (!e) {
                return;
            }
            deleteMenu(currentAreaId);
        });
    });

    //生成json按钮绑定
    $('#jsonbtn').click(function () {
    	myhide($('#jsonbtn'));
        saveToDb();
    });
    
    //更新微信菜单
    $('#createWxmenuBtn').click(function () {
    	createWechatMenu();
    });
    
    
    
    /*右侧编辑区开始*/
    //动态加载表单内容
  	$("input[name='menu_type']").change(function(){
  		refreshByType();
  	})
  	
  	//根据按钮切换消息体div
  	var temp_arr0 = ['news','text','img','voice','video'];
  	for(var i = 0;i<temp_arr0.length;i++){
  		var aId="#a_"+temp_arr0[i];
  		$(aId).click(function(){//当点击a时
  			//先隐藏所有div，清除样式
  			for(var j = 0;j<temp_arr0.length;j++){
  				$(("#div_"+temp_arr0[j])).css('display','none');
  				$(("#a_"+temp_arr0[j]+">div")).removeClass('secl');
  			}
  			//再显示当前选中的div,并给对应的a添加样式
  			var currentdivId= "#div"+this.id.substr(1,this.id.length-1);
  			currentReplyId = currentdivId;
  			$(currentdivId).css('display','');
  			$("#"+this.id+">div").addClass('secl');
  		});
  	}
  	//删除按钮
  		
  	 $('#delete_show_img').click(function(){
  		//删除图片
  		$('#div_img>div:first img').attr('src','');
  		$('#div_img>div:first i').text('');
  		
  		$('#div_img>div:last').css('display','');
  		$('#div_img>div:first').css('display','none');
  	 });
  	 
  	
  	
  	/*右侧编辑区结束*/
  
/*---------------页面初始化模块end---------------*/

});
