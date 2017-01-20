<%--
  Created by IntelliJ IDEA.
  User: huazhi
  Date: 2017/1/19
  Time: 10:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <link rel="shortcut icon" href="static/common/images/favicon.ico" type="image/x-icon">
    <title>微信小程序商店-微信小程序官方商店|微信小程序官方市场</title>
    <meta name="keywords" content="小程序,微信小程序,小应用,微信公众号平台,开发,应用号,市场,小程序怎么用,小程序在哪里,微信">
    <meta name="description" content="微信小程序商店（9.cn）拥有最新最全微信小程序应用和微信小程序资源、小程序资讯等，作为国内首家小程序商店，9.cn致力于为用户提供优质的微信小程序体验。">
    <link rel="stylesheet" type="text/css" href="/resource/css/reseting.css">
    <link rel="stylesheet" type="text/css" href="/resource/css/app-common.css">
    <link rel="stylesheet" type="text/css" href="/resource/css/lite.css">
    <script type="text/javascript" src="/resource/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/resource/js/app-common.js" charset="utf-8"></script>
</head>
<body>
<script type="text/javascript" src="static/common/js/template.js"></script>
<div class="body-container">
    <div class="top_fixed">
        <div class="top containers clear">
            <a href="">
                <img class="img1" src="/resource/img/logo.png">
                <img class="img2" src="/resource/img/logo2.png">
            </a>
            <div class="nav clear">
                <a class="" href="">首页</a>
                <a class="" href="charts">排行榜</a>
                <a class="active" href="app">小程序商店</a>
                <a class="" href="news">文章</a>
            </div>
            <div class="searchbox">
                <form id="search_form" action="app/search" method="post">
                    <input type="text" name="keyword" id="keyword"  value="" placeholder="搜索微信小程序">
                    <a onclick="$('#search_form').submit();"><label></label></a>
                </form>
            </div>
        </div>
    </div>
    <div class="keysbox">
        <div class="containers clear">
            <a class="active" href="app">全部</a>
            <c:forEach items="${categoryList}" var="category">
                <li><a href="/app/${category.path}">${category.name}</a></li>
            </c:forEach>
        </div>
    </div>
    <div id="wrapper" class="showbox containers">
        <div id="thelist" class="show-content containers clear paddingTop">
            <c:forEach items="${page.content}" var="appVO">
                <a class="list" href="/app/${appVO.id}" title="${appVO.name}">
                    <div class="imgLeft"><span><img onload="setImgWH(this)" src="${appVO.icon}" style="width: 100%;"></span></div>
                    <div class="dataRight">
                        <div class="title clear">
                        <h3 class="ellipsis">${appVO.name}</h3>
                        <span class="app-try">体验</span>
                        </div>
                        <p class="author">作者：${appVO.name}</p>
                        <p class="introduce">${appVO.description}</p>
                    </div>
                    <div class="list-bottom"><p class="view-count"><label></label>21817</p></div><label>${appVO.category.name}</label>
                    <div class="qrcode" style="display: none;"><img src="${appVO.qrcode}"><p>微信体验扫描</p></div>
                </a>
            </c:forEach>
        </div>
        <div class="lookmore" style="display: none;"><a href="javascript:;">查看更多</a></div>
    </div>
    <div class="foot text-center">
        <div class=""><a href="app">小程序商店</a><label></label><a href="charts">排行榜</a><label></label><a href="news">文章</a>
        </div>
        <p>Copyright © 2017 <span>9.cn</span> 微信小程序商店 闽ICP备13005267号-3版权所有</p>

        <p>微信小程序收录联系QQ：3554537959</p></div>
    <div class="fixed_box" style="bottom: 120px; right: 321.5px;"><a class="to_top" style="display: block;"></a></div>
    <script>    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?8cc9de2a3236780c668bf1a63e533ab2";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
    </script>
</div>
<script id="tpl_list" type="text/html">
    {{each data.list as value i}}
    <a class="list" href="{{value.url}}" title="{{value.title}}">
        <div class="imgLeft"><span><img onload="setImgWH(this)" src="{{value.icon}}" style="width: 100%;"></span></div>
        <div class="dataRight">
            <div class="title clear"><h3 class="ellipsis">{{value.title}}</h3><span class="app-try">体验</span></div>
            <p class="author">作者：{{value.author}}</p>

            <p class="introduce">{{value.content}}</p></div>
        <div class="list-bottom"><p class="view-count"><label></label>{{value.hits}}</p></div>
        <label>{{value.cat}}</label>

        <div class="qrcode"><img src="{{if value.qrcode}}{{value.qrcode}}{{else}}/static/pc/images/default.png{{/if}}">

            <p>{{if value.qrcode}}微信体验扫描{{else}}微信搜索{{/if}}</p></div>
    </a>
    {{/each}}
</script>
<script type="text/javascript">
    var page = 1;
    var cate = '';

    get_list();

    $(function () {
//弹窗
        var H_ture = $(".switchbox .content").height();
        var flag = true;
        if (H_ture > 36) {
            $(".switchbox .content").css("height", "36px");
            $(".slideBtn a").click(function () {
                if (flag) {
                    $(".switchbox .content").animate({
                        "height": H_ture
                    });
                    $(this).addClass("active");
                } else {
                    $(".switchbox .content").animate({
                        "height": "36px"
                    });
                    $(this).removeClass("active");
                }
                flag = !flag;
            });
        }
// 点击标签的效果
        $(".switchbox .content a").click(function () {
            $(".switchbox .content a").removeClass("active");
            $(this).addClass("active");
        });

// 分类加载
        $('.cate').click(function () {
            var cate = $(this).text();
            var html = '<label></label>' + cate;
            $('#wrapper h2').html(html);

            var cid = $(this).attr('data-cid');
            document.getElementById("cid").value = cid;
            get_list();
        });

// 点击加载
        $('.lookmore').click(function () {
//模拟加载数据方法
            $('.dragLoadMore').show();
            page++;
            get_list(function () {
                $('.dragLoadMore').hide();
            });
        });
    });

    //加载数据
    function get_list(callback) {
        if (!callback) {
            page = 1;
            $("body").scrollTop(0);
        }

        var params = get_params();
        $.get("cx/getList.html", params, function (msg) {
            if (msg.status == 0) {
                $('.lookmore').hide();
                $('#wrapper').hide();
                $('#thelist').html('');
                $('.m-container').removeClass('bg_ff');
                $('.nonebox').show();
                return;
            } else {
                $('.lookmore').show();
                $('.nonebox').hide();
            }
            if (msg.data.total <= 12) {
                $('.lookmore').hide();
            }
            if (callback) {
                callback(msg);
            }
            if (page > 1 && msg.data.list == null) {
                $('.lookmore').hide();
            } else {
                var html = template('tpl_list', msg);
                if (callback) {
                    $('#thelist').append(html);
                } else {
                    $('#thelist').html(html);
                }
                $('#wrapper').show();
            }
        }, 'json');
    }

    function get_params() {
// 默认参数
        var params = {
            page: page,
            cate: cate
        }
// 筛选参数
        var cid = $('#cid').val();

        if (cid != '' && cid != undefined) {
            params.cid = cid;
        }
        return params;
    }

</script>
<script type="text/javascript">
    $(function () {
        var $index = 0;
        $("#wrapper").on('mouseenter', '.list .app-try', function () {
            $index = $(this).parents(".list").index();
            $(".qrcode").hide().eq($index).fadeIn();
        });
        $("#wrapper").on('mouseleave', '.list .app-try', function () {
            $index = $(this).parents(".list").index();
            $(".qrcode").hide();
        });
    });
</script>
</body>
</html>
