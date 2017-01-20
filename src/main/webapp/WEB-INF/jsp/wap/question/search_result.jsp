<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>${q} 问答搜索_问答社区|留学e网</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="keywords" content="${q}热门问题，${q}常见问题">
    <meta name="description" content="留学e网问答社区为您解答所有留学相关的热门问题及常见问题" >
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
    <link href="/resource/css/wap/result.css" rel="stylesheet" type="text/css">
</head>

<body>
<jsp:include page="../common/conmon.jsp"/>
<!--固定头部-->
<div id="header">
    <div id="arr" onclick="javascript:history.back(-1);"></div>
    <div id="School">搜索结果</div>

</div>
<!--中间内容 start-->

<!--搜索框 start-->

<div class="search clear">
    <form  action="/question/search">
        <div class="inp-wrap clear">
        <input type="search" class="entry"name="q" placeholder="搜索你感兴趣的问题" value="${q}">
        <input class="btn" type="submit" value="搜索">
        </div>
    </form>
</div>
<%--<div class="Search clear">
    <form name="questionSearchForm" method="post" action="/question/questionSearchList">
        <input type="text" class="entry" name="questionTitle"  placeholder="搜索你感兴趣的问题" value="${questionTitle}">
        <input type="hidden" id="page" value="${pageIndex}"/>
    </form>
    <div class="btn">搜索</div>
</div>--%>
<!--搜索框 end-->
<!--搜索结果 start-->
<c:if test="${page.totalCount>0}">
    <div class="s-result">
        <c:forEach var="item" items="${page.content}">
            <div class="list">
                <p class="list-top"><a href="/question/${item.questionId}">${item.questionTitle}</a></p>
                <p class="list-bottom clear"><span>${item.answerCount}个</span><span>回答</span><span> 浏览</span><span>${item.viewCount}</span><a href="/question/${item.questionId}">查看回答<span></span></a></p>
            </div>
        </c:forEach>

        <c:if test="${page.totalCount>10}">
            <div class="Load" id="search-more">
                <p class="load-more">加载更多</p>
            </div>
        </c:if>
        <div class="Blank"></div>
    </div>
</c:if>
<c:if test="${page.totalCount<=0}">
    <div class="s-result-blank">
        <img src="/resource/images/wap/blank.png">
        <p>暂未搜索到符合条件的问题</p>
        <a href="/question/ask">立即提问</a>
    </div>
</c:if>
<!--搜索结果 end-->
<!--中间内容 end-->
<!--尾部-->
<jsp:include page="../common/footer.jsp"/>
<script type="text/javascript" src="/resource/js/wap/ask.loadmore.js"></script>
</body>
</html>
