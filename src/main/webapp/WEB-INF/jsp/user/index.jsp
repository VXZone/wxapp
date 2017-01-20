<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${user.platformUserName}的问答——问答社区|留学e网</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="keywords" content="${user.platformUserName}个人中心,留学问答社区，留学热门问题，留学常见问题">
    <meta name="description" content="留学e网问答社区为您解答所有留学相关的热门问题及常见问题" >
    <meta name="360-site-verification" content="2a51660781fbbbac8f3fd39db453a7c3">
    <link rel="stylesheet" type="text/css" href="/resource/css/ask-user-question.css">
<body>
<!-- 头部 -->
<!-- 全局各模块根地址-->
<!-- 全局各模块根地址-->
<!-- 头部 start-->
<jsp:include page="../common/header.jsp"/>
<!-- 导航条 end-->
<!-- 问答内容 start-->

<div class="details-nav">
    <a href="/" class="nav-a"><span>问答></span><span></span></a>
    <span class="nav-s"><c:if test="${isMine}">我</c:if><c:if test="${!isMine}">TA</c:if>的问答</span>
    <span class="nav-c"></span>
</div>
<div class="main-content">
    <div class="wrap-left">
        <div class="type-nav clear">
            <div class="type-user">
                <a href="/user/${user.userId}" class="type-a type-b"><img src="${user.avatarUrl!=null?user.avatarUrl:'/resource/images/no_avatar.jpg'}" onerror="this.src='/resource/images/no_avatar.jpg'"></a>
                <%--<div class="User-W2">
                    <div class="toparr"></div>
                    <div class="botblock">
                        <ul class="user-p">
                            <li><a href="#" class="pe1"><img ></a></li>
                            <li><a href="#" class="pe2">那片海yaya</a></li>
                            <li class="pe3">简介：留学e网、澳洲留学顾问</li>
                        </ul>
                        <div class="i-w">
                            <ul class="user-i clear">
                                <li><a href="#" class="pe4"><span>回答</span><span>214</span></a><span>&nbsp;&nbsp;|</span></li>
                                <li><a href="#" class="pe4"><span>提问</span><span>47</span></a><span>&nbsp;&nbsp;|</span></li>
                                <li><a href="#" class="pe4"><span>获赞</span><span>12</span></a></li>
                            </ul>
                            <div class="user-a"><a href="#" class="pe7">向TA提问</a></div>
                        </div>
                    </div>
                </div>--%>
            </div>
            <div class="type-name">
                <a href="/user/${user.userId}" class="type-a">${user.platformUserName}</a>
                <c:if test="${!isMine}"><span><a href="/question/ask?userId=${user.userId}" target="_blank">向TA提问</a></span></c:if>
                <c:if test="${isMine}"><span><a href="/question/ask" target="_blank">我要提问</a></span></c:if>
            </div>
            <div class="type-an">
                <span>${approvalCount != null ?approvalCount:0}</span>
                <span>获得赞同</span>

            </div>
            <div class="type-ag">
                <span>${answerCount}</span>
                <span>回答问题</span>
            </div>
        </div>
        <ul class="ques-type clear">
            <li  <c:if test="${type =='ask'}" >  class="ques-type-active" </c:if> >     <span><a href="/user/${userId}/ask"> <c:if test="${!isMine}">TA</c:if>  <c:if test="${isMine}">我</c:if>的提问</a> </span><span></span></li>
            <li  <c:if test="${type =='answer'}" >  class="ques-type-active"</c:if>>    <span><a href="/user/${userId}/answer"><c:if test="${!isMine}">TA</c:if><c:if test="${isMine}">我</c:if>的回答  </a> </span><span></span></li>
            <li  <c:if test="${type =='collection'}" >  class="ques-type-active"</c:if> >  <span><a href="/user/${userId}/collection"> <c:if test="${!isMine}">TA</c:if><c:if test="${isMine}">我</c:if>的收藏 </a></span><span></span></li>
            <c:if test="${isMine}"><li  <c:if test="${type =='message'}" >  class="ques-type-active"</c:if>> <span>  <a href="/user/${userId}/message"> 我的消息 </a></span><span></span></li> </c:if>
        </ul>
        <ul class="ques-list">
            <li class="qu-li-show qu-li">
                <c:if test="${type =='ask' || type =='collection'}">
                    <c:forEach var="item" items="${page.content}">
                        <div class="list1">
                            <p class="list-top"><a href="/question/${item.questionId}">${item.questionTitle}</a><span>${item.answerCount}</span><span>个回答</span></p>
                            <p class="list-middle">
                                <c:forEach var="tag" items="${item.tagList}">
                                    <a href="/tag/${tag.tagId}" class="">${tag.tagName}</a>
                                </c:forEach>
                            </p>
                            <p class="list-bottom clear"><a href="/user/${user.userId}" class="l-fl">${user.platformUserName}</a><span class="l-fl">${item.createTime}</span><span class="l-fl"></span><span class="r-fl">${item.collectionCount}</span><span class="r-fl">收藏</span><span class="r-fl">${item.viewCount}</span><span class="r-fl"> 浏览</span></p>
                        </div>
                    </c:forEach>
                    <c:if test="${type =='ask' &&page.totalCount <=0}">
                        <div class="no-result-tip">
                            <p>暂未提出问题，有任何疑问请抛给问答社区吧</p>
                            <a href="/question/ask">立即提问</a>
                        </div>
                    </c:if>
                    <c:if test="${type =='collection' &&page.totalCount <=0}">
                        <div class="no-result-tip">
                            <p>暂未收藏问题，收藏感兴趣的问题，以便查看最新解答</p>
                            <a href="/">立即前往问题广场</a>
                        </div>
                    </c:if>
                </c:if>

                <c:if test="${type =='answer'}">
                    <c:forEach var="item" items="${page.content}">
                        <div class="list1">
                            <p class="list-top"><a  href="/question/${item.questionId}">${item.questionTitle}</a></p>
                            <p class="list-mid">
                                 <span   class="mi-co">
                                    <c:choose>
                                        <c:when test="${fn:length(item.answerContent)>80}">
                                            ${ fn:substring(item.answerContent, 0, 80)}。。。
                                            <a class="read-all" style="color:#99ccff" href="/question/${item.questionId}">查看全部</a>
                                        </c:when>
                                        <c:otherwise>
                                            ${item.answerContent}
                                        </c:otherwise>
                                    </c:choose>
                                  </span>

                            </p>
                            <div class="list-bottom clear">
                                <div class="right-h l-fl">
                                    <a href="/user/${user.userId}" class="type-a" style="border-radius: 0;">${user.platformUserName}</a>
                                </div>
                                <span class="l-fl">${item.createTime}</span><span class="l-fl"></span><span class="r-fl">${item.collectionCount}</span><span class="r-fl">收藏</span><span class="r-fl">${item.viewCount}</span><span class="r-fl"> 浏览</span>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${page.totalCount <=0}">
                        <div class="no-result-tip">
                            <p>暂未回答问题，大牛快快去回答问题吧</p>
                            <a href="/">立即前往问题广场</a>
                        </div>
                    </c:if>
                </c:if>

                <c:if test="${type =='message'}">
                    <c:forEach var="item" items="${page.content}">
                        <div class="list1">
                            <div class="news-wrap clear">
                                <span class="horn"></span>
                                    <span class="horn-user">
                                        <c:if test="${item.flag ==3}">
                                            <c:forEach var="u" items="${item.userList}" varStatus="status">
                                                <c:if test="${item.userList.size() ==(status.index+1)}">
                                                    <a href="/user/${u.userId}">${u.userName}</a>
                                                </c:if>
                                                <c:if test="${item.userList.size()!=(status.index+1)}">
                                                    <a href="/user/${u.userId}">${u.userName}</a> 、
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${item.flag !=3}">
                                            <a href="/user/${item.user.userId}">${item.user.platformUserName}</a>
                                        </c:if>
                                    </span>
                                <c:if test="${item.flag ==1 }">
                                    <span class="horn-com">回答了你的问题</span>
                                </c:if>
                                <c:if test="${item.flag ==2 }">
                                    <span class="horn-com">向你请教了问题</span>
                                </c:if>
                                <c:if test="${item.flag ==3 }">
                                    <span class="horn-com">赞了你对问题</span>
                                </c:if>
                                <span class="horn-que"><a href="/question/${item.questionId}">${item.questionTitle} </a></span>
                                <c:if test="${item.flag ==3 }">
                                    <span class="horn-agr">的回答 。</span>
                                </c:if>
                                <span class="time-b">${item.createTime}<span class="time-s"> </span></span>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${page.totalCount <=0}">
                        <div class="no-result-tip">
                            <p>暂未收到任何消息，有任何与您相关消息将在这里第一时间通知您</p>
                            <a href="/">我要找存在感</a>
                        </div>
                    </c:if>
                </c:if>
            </li>
        </ul>

        <div class="row-fulid">
            <div class="col-sm-6 col-md-6">
                <div id="pager">
                    <jsp:include page="../common/pagination.jsp" flush="false" />
                </div>
            </div>
        </div>

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
<!-- 底部 end-->
<script type="text/javascript" src="/resource/js/ask.question.js"></script>
</body>
</html>