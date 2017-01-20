<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/function.tld" prefix="z"%>
<%@page  import="com.eduwo.ask.core.Constants" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${tag.tagName}常见问题_留学e网问答社区</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="keywords" content="${tag.tagName}">
    <meta name="description" content="留学e网,专业出国留学20年,DIY留学第一品牌,免费咨询电话:400-626-6788.留学e网问答社区为您解答${tag.tagName}常见问题" >
    <meta name="360-site-verification" content="2a51660781fbbbac8f3fd39db453a7c3">
    <link rel="stylesheet" type="text/css" href="/resource/css/label.css">
<body>
<!-- 头部 -->
<jsp:include page="../common/header.jsp"/>
<!-- 头部 start-->

<!-- 导航条 end-->
<!-- 问答内容 start-->
<div class="details-nav">
    <a href="/" class="nav-a"><span>问答></span><span></span></a>
    <a href="/tag"><span class="nav-s">全部分类</span></a>
    <span class="nav-c">>${parentTag.tagName}</span>
</div>
<div class="main-content">
    <%--<form name="questionTagForm" action="/askTag/tagQuestionList" method="get"  >
        <input type="hidden" name="flag" id="flag">
        <input type="hidden" name="tagId" id="tagId" value="${tagId}">
        <input type="hidden" name="tagParentId" value="${tagParentId}">
        <input type="hidden" name="page" value="1">
    </form>--%>
    <div class="wrap-left">
        <div class="type-nav clear tagList ">
            <p>${parentTag.tagName}：</p>
            <div class="ul-wrap addM">
            <ul class="clear">
                <c:forEach var="item" items="${tagList}">
                    <li   <c:if test="${item.tagId==tag.tagId}" > <c:set var="currentTagName" value="${item.tagName}"/> class="tagSelect"</c:if>  ><a href="/tag/${item.tagId}">${item.tagName}</a></li>
                </c:forEach>
            </ul>
            </div>
            <div class="all-show">点击展开</div>
        </div>
        <ul class="ques-type clear">
            <c:set var="LIST_TYPE_HOT" value="<%=Constants.LIST_TYPE_HOT%>" />
            <c:set var="LIST_TYPE_NEW" value="<%=Constants.LIST_TYPE_NEW%>" />
            <c:set var="LIST_TYPE_UNANSWERED" value="<%=Constants.LIST_TYPE_UNANSWERED%>" />
            <li <c:if test="${listType==LIST_TYPE_HOT}" > class="ques-type-active"</c:if>><span><a href="/tag/${tag.tagId}/hot">热门问题 </a></span></li>
            <li <c:if test="${listType==LIST_TYPE_NEW}" > class="ques-type-active"</c:if>><span><a href="/tag/${tag.tagId}/new">最新问题  </a></span></li>
            <li  <c:if test="${listType==LIST_TYPE_UNANSWERED}" > class="ques-type-active"</c:if>><span><a href="/tag/${tag.tagId}/unanswered">待回答问题 </a></span></li>
        </ul>
        <c:if test="${page.totalCount >0}">
        <ul class="ques-list ">
            <li class="list-show">
                <c:forEach var="item" items="${page.content}">
                    <div class="list1">
                        <p class="list-top"><a href="/question/${item.questionId}">${item.questionTitle} </a><span>${item.answerCount}</span><span>个回答</span></p>
                        <p class="list-bottom clear"><a href="/user/${item.user.userId}" class="l-fl">${item.user.platformUserName}</a><span class="l-fl">${z:dateFormat(item.createTime)}</span><span class="r-fl">收藏 ${item.collectionCount}</span><span class="r-fl">浏览 ${item.viewCount}</span></p>
                    </div>
                </c:forEach>
            </li>
        </ul>
        </c:if>
        <c:if test="${page.totalCount <=0}">
            <div class="no-result-tip">
                <img src="/resource/images/no_result.png">
                <p>暂未找到相关问题，可尝试提问</p>
                <a href="/question/ask">立即提问</a>
            </div>
        </c:if>
        <jsp:include page="../common/pagination.jsp" flush="false" />
    </div>
    <div class="wrap-right">
        <jsp:include page="../common/subject.jsp" flush="false" />
        <jsp:include page="../common/apply.jsp" flush="false" />
        <jsp:include page="../common/hot_tag.jsp" flush="false" />
    </div>
</div>

<!-- 问答内容 end-->
<!-- 底部 footer-->
<jsp:include page="../common/footer.jsp"/>
<!--底部 end-->
<script type="text/javascript" src="/resource/js/ask.question.js"></script>
<script type="text/javascript" src="/resource/js/ask.tag.js"></script>
</body>
</html>