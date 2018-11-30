/*文章对象（article）*/
function Article(index){
	this.index = index;//对应的变量名索引
	this.title;//标题
	this.description;//描述
	this.picurl;//图片链接
	this.url;//跳转链接
    this.src;
	this.deleted = true;//是否已删除。默认已删除
}

function NewsVo(newsId,articles){
    this.id = newsId;
    this.articles = articles; 
}

/*图文列表相关数据*/
//article列表
var article1 = new Article(1);
var article2 = new Article(2);
var article3 = new Article(3);
var article4 = new Article(4);
var article5 = new Article(5);
var article6 = new Article(6);
var article7 = new Article(7);
var article8 = new Article(8);
//图文集合
var articles = [article1,article2,article3,article4,article5,article6,article7,article8];
//当前图文编辑区域对应的图文
var currentArticle;
//当前图文图片的物理地址
var currentSrc = "images/c3.jpg";
//当前articles的id
var news_id;
function removeAllSelected(){
	$('#article1').removeClass('twxz-sel');
	$('#article2').removeClass('twxz-sel');
	$('#article3').removeClass('twxz-sel');
	$('#article4').removeClass('twxz-sel');
	$('#article5').removeClass('twxz-sel');
	$('#article6').removeClass('twxz-sel');
	$('#article7').removeClass('twxz-sel');
	$('#article8').removeClass('twxz-sel');
}

/*
打开编辑图文区域
 */
function openEditArticleArea(obj){
	if(obj){
		//获取当前点击对象的id
		var objId = obj.attr('id');
		//设置currentArticle
		switch(objId){
			case "article1":
    			currentArticle = article1;
    			removeAllSelected();
    			$('#article1').addClass('twxz-sel');
    			break;
            case "article2":
                currentArticle = article2;
                removeAllSelected();
                $('#article2').addClass('twxz-sel');
                break;
            case "article3":
                currentArticle = article3;
                removeAllSelected();
                $('#article3').addClass('twxz-sel');
                break;
            case "article4":
                currentArticle = article4;
                removeAllSelected();
                $('#article4').addClass('twxz-sel');
                break;
            case "article5":
                currentArticle = article5;
                removeAllSelected();
                $('#article5').addClass('twxz-sel');
                break;
            case "article6":
                currentArticle = article6;
                removeAllSelected();
                $('#article6').addClass('twxz-sel');
                break;
            case "article7":
                currentArticle = article7;
                removeAllSelected();
                $('#article7').addClass('twxz-sel');
                break;
            case "article8":
                currentArticle = article8;
                removeAllSelected();
                $('#article8').addClass('twxz-sel');
                break;
		}
	}

    //判断当前选中的图文状态
    //如果是已删除状态，打开空页面
    if(currentArticle.deleted){
         $('#news_title').val('');
         $('#news_description').val('');
         $('#news_url').val('');
         $('#coverpic_div')[0].innerHTML='';
         currentSrc = '';
    }else{
        //未删除状态，则带着数据打开编辑页面
         $('#news_title').val(currentArticle.title);
         $('#news_description').val(currentArticle.description);
         $('#news_url').val(currentArticle.url);
        //图片数据
         $('#coverpic_div')[0].innerHTML='<div class="sctp-tu " style="padding-top: 10px; ">'
				+'<img src="'+currentArticle.src+'"><i id="news_picurl" style="display:none">'+currentArticle.picurl+'</i></div>';
         currentSrc = currentArticle.src;
    }
    //显示编辑区域
     $('#editArticleArea').css("display", "");

}

/*删除图文*/
function deleteArticle(){
    //清空当前图文的数据
    currentArticle.deleted = true;
    currentArticle.title = undefined;
    currentArticle.description = undefined;
    currentArticle.picurl = undefined;
    currentArticle.url = undefined;
    //更新页面效果
    openEditArticleArea();
    refreshCurrentLeft();
}

/*关闭编辑区域*/
function closeArea(){
    $('#editArticleArea').css("display", "none");
}

/*刷新左侧图文预览效果*/
function refreshCurrentLeft(){
    var article ="#article"+currentArticle.index;
    if (currentArticle.deleted) {
        //要展示的图文已被删除，则显示添加图标
        $(article)[0].innerHTML= "<div class='twtj'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span></div><div class='selxz'></div>";
    }else{
        //未删除则显示对应的样式
    	var first_liId=$('#left_list li')[0].id;
    	var i = first_liId.charAt(first_liId.length-1);
        if(currentArticle.index == i){
            //首个显示大图
             $(article)[0].innerHTML="<div class='cover_appmsg_item'><h4 class='zz_title'>"+currentArticle.title+"</h4><div class='appmsg_thumb_wrp'><img src='"+currentArticle.src+"'></div></div><div class='selxz'></div>";
        }else{
            //其余显示缩略图
            $(article)[0].innerHTML="<div class='appmsg_item'><img src='"+currentArticle.src+"' class='appmsg_thumb'><h4 class='ej_title'>"+currentArticle.title+"</h4><div class='clear'></div></div><div class='selxz'></div>";
        }
        //TODO 
    }
}

function refreshLeft(){
    //先获取第一个图文li的id
    var first_articleId = $('#left_list .addBtn')[0].id;
    //该图文在数组中对应的索引
    var index = first_articleId.charAt(first_articleId.length-1)-1;
    var first_article = articles[index];
    if(!first_article.deleted){
        //令当前第一个图文的样式更新
        var first_li = $("#"+first_articleId)[0];
        first_li.innerHTML="<div class='cover_appmsg_item'><h4 class='zz_title'>"+first_article.title+"</h4><div class='appmsg_thumb_wrp'><img src='"+first_article.src+"'></div></div><div class='selxz'></div>";
    }
    //再更新其余样式
    for(var i = 1;i<8;i++){
        var articleId = $('#left_list .addBtn')[i].id;
        var index2 = articleId.charAt(articleId.length-1)-1;
        var article = articles[index2];
        if(!article.deleted){
            //未删除的,则更新样式
            $("#"+articleId)[0].innerHTML="<div class='appmsg_item'><img src='"+article.src+"' class='appmsg_thumb'><h4 class='ej_title'>"+article.title+"</h4><div class='clear'></div></div><div class='selxz'></div>";
        }
    }
}

/*添加图文*/
function addArticle(){
	
	var res = checkData();
	if(res == -1){
		return ;
	}
	
	var arr = [$('#news_title').val(),$('#news_description').val(),$('#news_picurl').val(),$('#news_url').val(),currentSrc];
	var flag = false;
	for(var i=0;i<arr.length;i++){
		if(arr[i]!=""&&arr[i]!=undefined){
			flag = true;
		}
	}
	if(!flag){
		deleteArticle();
		//关掉编辑区域
	    closeArea();
	    return;
	}
    //添加之前必须将delete的值变为false
    currentArticle.deleted = false;
    //存值
    currentArticle.title = $('#news_title').val();
    currentArticle.description = $('#news_description').val();
    currentArticle.picurl = $('#news_picurl').text();
    currentArticle.url = $('#news_url').val();
    currentArticle.src = currentSrc;
    //刷新页面
    refreshLeft();
    //关掉编辑区域
    closeArea();
}


function sortArticle(){
    //按照页面排序处理article,根据真实排序情况重组articles
   var articleLis = $('#left_list >li');
   for(var i = 0;i<7;i++){
        switch(articleLis[i].id){
            case "article1":
                articles[i] = article1;
                break;
            case "article2":
                articles[i] = article2;
                break;
            case "article3":
                articles[i] = article3;
                break;
            case "article4":
                articles[i] = article4;
                break;
            case "article5":
                articles[i] = article5;
                break;
            case "article6":
                articles[i] = article6;
                break;
            case "article7":
                articles[i] = article7;
                break;
            case "article8":
                articles[i] = article8;
                break;
        }
   }
}



$(function () {
    // 给每个添加图文按钮绑定点击事件
    $('.addBtn').click(function () {
        openEditArticleArea($(this));
    });
    //保存图文
    $('#saveBtn').click(function () {
        addArticle();
    })
    //重置按钮
     $('#resetBtn').click(function () {
    	 $('#news_title').val('');
    	 $('#news_description').val('');
    	 $('#news_picurl').val('');
    	 $('#news_url').val('');
    	 
    	 
    	 currentSrc = '';
    	 $('#coverpic_div')[0].innerHTML='';
    	 
    });
    //注册删除按钮的事件
    $("#deleteBtn").click(function () {
        Ewin.confirm({ message: "确认要删除当前选中的图文吗？" }).on(function (e) {
            if (!e) {
                return;
            }
            deleteArticle();
        });
    });
    //提交按钮
    $('#submitBtn').click(function(){
    	saveToDb();
    })
    //排序插件
    var left_list = document.getElementById('left_list');
    var sort_lef_list = Sortable.create(left_list,{
        onSort:function(evt){ //发生排序发生该事件
        	refreshLeft();
        },
    });

    
});


/*bootstrap 组建封装开始*/
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
/*bootstrap 组建封装结束*/