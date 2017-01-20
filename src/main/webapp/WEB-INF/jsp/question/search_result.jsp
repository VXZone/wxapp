<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/function.tld" prefix="z"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${q} 问答搜索_问答社区|留学e网</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="keywords" content="${q}热门问题，${q}常见问题">
    <meta name="description" content="留学e网问答社区为您解答所有留学相关的热门问题及常见问题" >
    <meta name="360-site-verification" content="2a51660781fbbbac8f3fd39db453a7c3">
    <link rel="stylesheet" type="text/css" href="/resource/css/result.css">
<body>
<!-- 头部 -->
<jsp:include page="../common/header.jsp"/>
<!-- 头部 start-->

<!-- 导航条 end-->
<!-- 问答内容 start-->
<jsp:include page="../common/search.jsp"/>
<div class="main-content">
    <div class="wrap-left">
        <div class="type-nav clear">
            <p>为您找到与<span>${q}</span>相关的内容</p>

        </div>
        <ul class="ques-type clear">
            <li  class="ques-type-active"><span>问题(${page.totalCount})</span></li>
        </ul>
        <c:if test="${page.totalCount >0}">
            <ul class="ques-list">
                <c:forEach var="item" items="${page.content}">
                    <li class="list1">
                        <p class="list-top"><a href="/question/${item.questionId}">${item.questionTitle}</a><span>${item.answerCount}</span><span>个回答</span></p>
                        <p class="list-middle">
                            <c:forEach var="tag" items="${item.tagList}">
                                <a href="/tag/${tag.tagId}" class="">${tag.tagName}</a>
                            </c:forEach>
                        </p>
                        <p class="list-bottom clear"><a href="/user/${item.user.userId}" target="_blank" class="l-fl">${item.user.platformUserName}</a><span class="l-fl">${z:dateFormat(item.createTime)}</span><span class="r-fl">${item.collectionCount}</span><span class="r-fl">收藏</span><span class="r-fl">${item.viewCount}</span><span class="r-fl"> 浏览</span></p>
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        <c:if test="${page.totalCount <=0}">
            <div class="no-result-tip">
                <img src="/resource/images/no_result.png">
                <p>暂未搜索到符合条件的问题，可尝试提问或修改搜索关键词</p>
                <a href="/question/ask">立即提问</a>
            </div>
        </c:if>

        <jsp:include page="../common/pagination.jsp" flush="false" />
    </div>
    <div class="wrap-right">
        <jsp:include page="../common/subject.jsp" flush="false" />
        <jsp:include page="../common/apply.jsp" flush="false" />
        <jsp:include page="../common/hot_tag.jsp" flush="false"/>
    </div>

</div>
<!-- 问答内容 end-->
<!-- 底部 footer-->
<jsp:include page="../common/footer.jsp"/>
<!--底部 end-->
<script type="text/javascript" src="/resource/js/ask.question.js"></script>
</body>
</html>