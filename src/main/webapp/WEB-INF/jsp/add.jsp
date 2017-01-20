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
    <link rel="shortcut icon" href="static/common/images/favicon.ico" type="image/x-icon" />
    <title></title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <link rel="stylesheet" type="text/css" href="/resource/css/reseting.css" />
    <link rel="stylesheet" type="text/css" href="/resource/css/app-common.css" />
    <link rel="stylesheet" type="text/css" href="/resource/css/lite.css" />

    <script type="text/javascript" src="/resource/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/resource/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="/resource/js/app-common.js" charset="utf-8"></script>
    <script type="text/javascript" src="/resource/js/uploadPreview.js"></script>
    <script type="text/javascript" src="/resource/js/ask.common.js"></script>
</head>

<body>

<%--<script type="text/javascript" src="static/common/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="static/common/js/layer/layer.js"></script>--%>

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
                    <input type="text" name="keyword" id="keyword" value="" placeholder="搜索微信小程序" />
                    <a onclick="$('#search_form').submit();"><label></label></a>
                </form>
            </div>
        </div>
    </div>

    <div class="title_common containers">
        <a href="">首页</a>
        <label></label>
        <a href="app">小程序商店</a>
        <label></label>
        <a>发布</a>
    </div>

    <div class="releasebox containers">
        <div class="title">发布小程序</div>
        <form action="/app/add" method="post" enctype="multipart/form-data">
        <div class="release-content">
            <h2>小程序 &nbsp;&nbsp;名称</h2>
            <div class="lite_name">
                <!--<span>0/10</span>-->
                <input class="am-g" type="text" name="name" id="name" maxlength="10" placeholder="请输入小程序名称">
            </div>
            <h2>小程序 &nbsp;&nbsp;作者</h2>
            <div class="lite_name">
                <!--<span>0/10</span>-->
                <input class="am-g" type="text" name="author" id="author" maxlength="10" placeholder="请输入小程序作者">
            </div>

            <h2>小程序 &nbsp;&nbsp;ICON / 二维码<span>建议尺寸：不小于 400×400px，并且为正方形</span></h2>
            <div class="clear oneimg">
                <div id="filelist1" class="files fl">
                    <span id="filePicker1" class="file-btn">
                        <img id="iconFile" onload="setImgWH(this)" src="/resource/img/file1.png">
                        <input type="file" name="iconFile">
                    </span>
                    <p>上传ICON</p>
                </div>
                <div id="filelist2" class="files fl">
                    <span id="filePicker2" class="file-btn">
                        <img id="qrcodeFile" onload="setImgWH(this)" src="/resource/img/file1.png">
                        <input type="file" name="qrcodeFile">
                    </span>
                    <p>上传二维码</p>
                </div>
            </div>
            <h2>小程序 &nbsp;&nbsp;介绍</h2>
            <div class="lite_content">
                <!--<span>0/30</span>-->
                <textarea class="am-g" name="description" id="description" maxlength="30" placeholder="请输入小程序介绍"></textarea>
            </div>
            <h2 class="special">小程序 &nbsp;&nbsp;分类</h2>
            <div class="sorts clear">
                <c:forEach items="${categoryList}" var="category">
                    <a data-id="${category.id}">${category.name}</a>
                </c:forEach>
                <input type="hidden" name="categoryId" id="categoryId">
            </div>
            <h2 class="special2">小程序 &nbsp;&nbsp;标签<span>（选填）每个标签字数不超 6个字,多个用英文逗号隔开</span></h2>
            <div class="lite_name">
                <input class="am-g" type="text" name="tags" id="tags" placeholder="请输入小程序标签">
            </div>
            <h2>小程序 &nbsp;&nbsp;截图<span>建议尺寸：750x1334px（最多不超过五张)</span></h2>
            <div class="upload2 clear">
                <div class="files4">
                    <span  class="file-btn3">
                        <img  onload="setImgWH(this)" src="/resource/img/file2.png">
                        <input type="file" name="picFile">
                    </span>
                </div>
                <div class="files4">
                    <span  class="file-btn3">
                        <img  onload="setImgWH(this)" src="/resource/img/file2.png">
                        <input type="file" name="picFile">
                    </span>
                </div>
                <div class="files4">
                    <span  class="file-btn3">
                        <img  onload="setImgWH(this)" src="/resource/img/file2.png">
                        <input type="file" name="picFile">
                    </span>
                </div>
                <div class="files4">
                    <span  class="file-btn3">
                        <img  onload="setImgWH(this)" src="/resource/img/file2.png">
                        <input type="file" name="picFile">
                    </span>
                </div>
                <div class="files4">
                    <span  class="file-btn3">
                        <img  onload="setImgWH(this)" src="/resource/img/file2.png">
                        <input type="file" name="picFile">
                    </span>
                </div>
            </div>
            <div class="release-save">
                <p>联系QQ：355453795，加快审核进度，获得独家曝光机会</p>
                <div class="text-center">
                    <a id="save">保存并上传</a>
                    <input type="submit" value="保存并上传">
                    <a class="cancel" onclick="history.back();">取消</a>
                </div>
            </div>
        </div>
        </form>
    </div>

    <div class="foot text-center">
        <div class="">
            <a href="app">小程序商店</a>
            <label></label>
            <a href="charts">排行榜</a>
            <label></label>
            <a href="news">文章</a>
        </div>
        <p>Copyright © 2017 <span>9.cn</span> 微信小程序商店 闽ICP备13005267号-3版权所有</p>
        <p>微信小程序收录联系QQ：3554537959</p>
    </div>
    <div class="fixed_box" style="bottom: 120px; right: 321.5px;"><a class="to_top" style="display: block;"></a></div>
    <%--<script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?8cc9de2a3236780c668bf1a63e533ab2";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>--%>

</div>

<%--<script type="text/javascript">
    var UPLOAD_URL = "file/upload.html";
    var SWF_URL = 'static/common/js/webuplader/Uploader.swf';
    var LOADING_IMG = 'static/common/images/loading.gif';
</script>--%>

<%--<script type="text/javascript" src="static/common/js/common.js" charset="utf-8"></script>--%>

<script>
    $(function () {
/*        upload1();
        upload2();
        upload3();*/

        $(".sorts a").click(function () {
            $(".sorts a").removeClass("active");
            $(this).addClass("active");

            var categoryIds = $(this).attr('data-id');
            document.getElementById('categoryId').value = categoryIds;
        });

        // 保存
        /*$('#save').click(function () {
            var params = get_params();
            $.post(ask.getDomainLink('app/add'), params, function (data) {
                if (data.success) {
                    layer.msg('发布成功，请等待管理员审核！');
                    setTimeout(function () {
                        window.location.href = "";
                    }, 1000);
                } else {
                    layer.msg(data.msg);
                }
            });
        });*/
    });

    function get_params() {
        var name = $('#name').val(),
                author = $('#author').val(),
                description = $('#description').val(),
                categoryId = $('#categoryId').val(),
                tags = $('#tags').val();
        var params = {
            name: name,
            author: author,
            description: description,
            categoryId: categoryId,
            tags: tags
        };


        return params;
    }
</script>

</body>
</html>

