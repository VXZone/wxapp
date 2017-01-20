<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>${user.platformUserName}的问答——问答社区|留学e网</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="keywords" content="${user.platformUserName}个人中心,留学问答社区，留学热门问题，留学常见问题">
  <meta name="description" content="留学e网问答社区为您解答所有留学相关的热门问题及常见问题" >
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
  <link href="${g.domain}/resource/css/wap/myquestion.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../common/conmon.jsp"/>
<!--固定头部-->
<div id="header">
  <div id="arr" onclick="javascript:history.back(-1);"></div>
  <div id="School">我的问答</div>
</div>
<!--中间内容 start-->


<!--我的问答 start-->
<div class="M-answer clear">
  <ul class="clear">
    <li  <c:if test="${type =='ask'}" >  class="m-show" </c:if> ><span><a href="/user/${userId}/ask"><c:if test="${!isMine}">TA</c:if>  <c:if test="${isMine}">我</c:if>的提问</a> </span><span></span></li>
    <li  <c:if test="${type =='answer'}" >  class="m-show"</c:if> ><span><a href="/user/${userId}/answer"><span><c:if test="${!isMine}">TA</c:if>  <c:if test="${isMine}">我</c:if>的回答  </span></a></span><span></span></li>
    <li  <c:if test="${type =='collection'}" >  class="m-show"</c:if>  ><span> <a href="/user/${userId}/collection"><span> <c:if test="${!isMine}">TA</c:if>  <c:if test="${isMine}">我</c:if>的收藏 </span></a></span><span></span></li>
<c:if test="${isMine}"><li  <c:if test="${type =='message'}" >  class="m-show"</c:if> > <span><a href="/user/${userId}/message"><span> 我的消息 </span></a></span><span></span></li></c:if>

    </li>
  </ul>
</div>
<input type="hidden" name="type" value="${type}"/>
<input type="hidden" id="page" name="page" value="${pageIndex}"/>
<input type="hidden" name="userId" value="${userId}"/>
<div class="qus-wrap">
  <div class="qus-con  qus-show">
    <ul>
      <c:if test="${type  !='message'}">
        <c:forEach var="item" items="${page.content}">
          <li class="clear">
            <a href="/question/${item.questionId}" class="ques3">${item.questionTitle}</a>
            <p class="ques4">
                <span>${item.createTime}</span>
              <c:if test="${type =='ask' || type =='collection'}">
                  <span>${item.answerCount}个回答</span><span>${item.viewCount}个浏览</span>
              </c:if>
            </p>
          </li>
        </c:forEach>
      </c:if>

    <c:if test="${type  =='message'}">
      <c:forEach var="item" items="${page.content}">
          <li>
            <p class="ques5">
              <span class="horn-user">
                   <c:if test="${item.flag ==3}">
                     <c:forEach var="u" items="${item.userList}" varStatus="status">
                       <c:if test="${item.userList.size() ==(status.index+1)}">
                         <a href="/user/${u.userId}">${u.userName}</a>
                       </c:if>
                       <c:if test="${item.userList.size()!=(status.index+1)}">
                         <a href="/user/${u.userId}">${u.userName}，</a>
                       </c:if>
                     </c:forEach>
                   </c:if>
                    <c:if test="${item.flag !=3}">
                      <a href="/user/${item.user.userId}">${item.user.platformUserName}</a>
                    </c:if>

            </span>
              <span class="horn-com">
                  <c:if test="${item.flag ==1 }">回答了你的问题</c:if>
                  <c:if test="${item.flag ==2 }">向你请教了问题</c:if>
                  <c:if test="${item.flag ==3 }">赞了你对问题</c:if>
              </span>
              <span class="horn-que"><a href="/question/${item.questionId}">${item.questionTitle} </a></span>
                <c:if test="${item.flag ==3 }"> <span class="horn-agr">的回答 。</span></c:if>
            </p>
            <p class="ques6 clear"><span class="time-b">${item.createTime}</span></p>
          </li>
       </c:forEach>

    </c:if>
      <c:if test="${page.totalCount>10}">
        <div class="Load">
          <p class="load-more" id="user-quedtion-more">加载更多</p>
        </div>
      </c:if>
    </ul>
  </div>
</div>

<div class="Blank"></div>
<jsp:include page="../common/footer.jsp"/>
<!--中间内容 end-->
<script type="text/javascript" src="${g.domain}/resource/js/wap/ask.loadmore.js"></script>
</body>

</html>
