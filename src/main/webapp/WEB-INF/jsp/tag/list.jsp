<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${parentTag.tagName}热门问题_留学e网问答社区</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="keywords" content="${parentTag.tagName}">
    <meta name="description" content="留学e网,专业出国留学20年,DIY留学第一品牌,免费咨询电话:400-626-6788.留学e网问答社区为您解答各个国家的${parentTag.tagName}问题." >
    <meta name="360-site-verification" content="2a51660781fbbbac8f3fd39db453a7c3">
    <link rel="stylesheet" type="text/css" href="/resource/css/classify.css">
<body>
 <jsp:include page="../common/header.jsp"/>
<!-- 问答详情 start-->
<div class="details-nav">
    <a href="/" class="nav-a"><span>问答></span><span></span></a>
    <span class="nav-s">全部分类</span>
    <%--<span class="nav-c">>申请细节</span>--%>
</div>
<div class="main-content">
    <div class="type-nav clear">
        <p>根据标签分类进行查找： </p>
        <ul class="clear tagClass">
            <c:forEach var="item" items="${tagPList}">
                    <li  <c:if  test="${item.tagId == parentTag.tagId}"> class ='tagSelect' </c:if>  ><a href="/tag/${item.tagId}">${item.tagName}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="classify">
        <ul class="clear">
            <c:forEach var="item" items="${page.content}">
                <li>
                    <a href="/tag/${item.tagId}">
                        <div class="cl-h2">${item.tagName}</div>
                    </a>
                        <p><span class="cl-orange  addFollow">${item.tagFollowCount}</span><span>人关注</span></p>
                        <p><span class="cl-orange">${item.tagQuestionCount}</span><span>相关问题</span><span class="add-att"><c:if test="${item.attention ==1}">+关注</c:if><c:if test="${item.attention ==2}">已关注</c:if>
                      </span><input type="hidden" value="${item.tagId}"></p>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
 <jsp:include page="../common/pagination.jsp" flush="false" />

<!-- 问答内容 end-->

<!--底部 start-->
 <jsp:include page="../common/footer.jsp"/>
 <script type="text/javascript" src="/resource/js/ask.question.js"></script>
 <script type="text/javascript" src="/resource/js/ask.tag.js"></script>
</body>
</html>