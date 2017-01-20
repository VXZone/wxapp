<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ page import="com.eduwo.ask.core.Constants" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>留学问答社区_${title}_留学问答平台|留学e网</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="description" content="留学e网问答社区，专门为留学生创建的留学问答平台,为您解答所有的关于留学申请,留学选校,留学选专业,留学费用,申请条件等留学的问题,希望对您有帮助." >
  <meta name="keywords" content="留学问答,留学问答平台,留学e网">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
  <link href="/resource/css/wap/interlocution.css" rel="stylesheet" type="text/css">

</head>

<body>
<jsp:include page="common/conmon.jsp"/>
<!--固定头部-->
<div id="header">
  <div id="arr" onclick="javascript:history.back(-1);" ></div>
  <div id="School">留学问答</div>

</div>
<!--中间内容 start-->

<!--搜索框 start-->
<div class="search clear">
  <form  action="/question/search" action="/question/search">
    <div class="inp-wrap clear">
    <input type="search" class="entry"name="q" name="questionTitle" value="${q}"  placeholder="搜索你感兴趣的问题" >
    <input class="btn" type="submit" value="搜索">
    </div>
  </form>
</div>
<!--搜索框 end-->
<!--切换导航 start-->
<%--<form name="questionIndexForm"  action="/question/search">
  <input type="hidden" id="questionTitle" name="questionTitle" value="${questionTitle}" />
  <input type="hidden" id="flag" name="flag" value="${flag}" />
  <input type="hidden" id="page" value="${pageIndex}"/>
</form>--%>

<div class="interlocution clear">
  <ul class="inter-left clear" >
    <c:set var="LIST_TYPE_HOT" value="<%=Constants.LIST_TYPE_HOT%>" />
    <c:set var="LIST_TYPE_NEW" value="<%=Constants.LIST_TYPE_NEW%>" />
    <c:set var="LIST_TYPE_UNANSWERED" value="<%=Constants.LIST_TYPE_UNANSWERED%>" />
    <li <c:if test="${listType==LIST_TYPE_HOT}" > class="inter-show"</c:if>><span> <a href="/question/hot">热门问题 </a></span><span></span></li>
    <li <c:if test="${listType==LIST_TYPE_NEW}" > class="inter-show"</c:if>><span> <a href="/question/new">最新问题  </a></span><span></span></li>
    <li <c:if test="${listType==LIST_TYPE_UNANSWERED}"> class="inter-show"</c:if> style="width:3.2rem;"><span> <a href="/question/unanswered">待回答问题 </a></span><span></span></li>
  </ul>
  <c:if test="${sessionScope.userId != null}">
    <div class="inter-right">
      <a href="/user/${sessionScope.userId }">
        <span></span>
        <span>我的问答</span>
      </a>
    </div>
  </c:if>
</div>
<!--切换导航 end-->

<!--切换内容 start-->
<div class="answer">
  <input type="hidden" name="listType" value="${listType}"/>
  <input type="hidden" name="userId" value="${userId}"/>
  <input type="hidden" id="page" name="page" value="${pageIndex}"/>
  <!--推荐问答-->
  <div class="con-wrap con-show">
    <ul>
    <c:forEach var="item" items="${page.content}">
      <li class="clear">
        <div class="con-right">
          <div class="title-wrap clear">
            <div class="con-left1">
              <span>问</span>
            </div>
            <a href="/question/${item.questionId}" class="user-ask">${item.questionTitle}</a>
            <div class="collect">
              <c:set var="isCollection" value="false" />
              <c:forEach var="questionCollection" items="${questionCollectionList}">
                <c:if test="${item.questionId == questionCollection.questionId}">
                  <c:set var="isCollection" value="true" />
                </c:if>
              </c:forEach>
              <c:if test="${isCollection}">
                <span class="ect" data-qid="${item.questionId}">已收藏</span>
              </c:if>
              <c:if test="${!isCollection}">
                <span class="coll" data-qid="${item.questionId}">收藏</span>
              </c:if>
                <%--<input type="hidden" value="${item.questionId}">--%>
            </div>
          </div>
          <div class="co-wrap clear">
            <div class="con-left2">
              <span>答</span>
            </div>
            <div class="new-wrap">
              <c:if test="${item.answerVoPage.content[0] !=null}">
                <a href="/user/${item.answerVoPage.content[0].user.userId}" class="user-answer">${item.answerVoPage.content[0].user.platformUserName}</a>
              </c:if>
              <c:if test="${item.answerVoPage.content[0] ==null}">
                <a class="to-answer" >还没有人回答，直接回复</a>
              </c:if>
              <p class="answer-co">
                <c:set var="firstAnswerContent" value="${item.answerVoPage.content[0].answerContent}" />
                <c:choose>
                <c:when test="${fn:length(firstAnswerContent)>35}">
                 <a class="answer-c">   ${ fn:substring(firstAnswerContent, 0, 35)}。。。</a>
                  <a class="read-all"  href="/question/${item.questionId}">查看全部</a>
                  <a class="answer-c" style="display: none">${firstAnswerContent}</a>
              </c:when>
              <c:otherwise>
                 <a class="answer-c">   ${firstAnswerContent}</a>
              </c:otherwise>
              </c:choose>
              </p>

            </div>
          </div>
        </div>

      </li>
    </c:forEach>
      <c:if test="${page.totalCount>10}">
        <div class="Load" id="index-more">
          <p class="load-more" >加载更多</p>
        </div>
      </c:if>
    </ul>
  </div>
  <div class="Blank"></div>
</div>
<!--切换内容 end-->
<!--我要提问 start-->
<div class="Ask">
  <a href="/question/ask">提问</a>
</div>
<!--我要提问 end-->

<!--中间内容 end-->
<!--尾部-->
<jsp:include page="common/footer.jsp"/>
<script type="text/javascript" src="/resource/js/wap/ask.loadmore.js"></script>
<script type="text/javascript" src="${g.domain}/resource/js/ask.question.js"></script>
</body>
</html>
