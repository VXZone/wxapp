<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/function.tld" prefix="z"%>
<!DOCTYPE HTML>
<html>
<head>
  <title>${questionVO.questionTitle}_问答社区|留学e网</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="keywords" content="${questionVO.questionTitle}">
  <meta name="description" content="${questionVO.questionTitle} ${questionVO.questionContent}" >
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
  <link href="${g.domain}/resource/css/wap/question.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="${g.domain}/resource/jquery-fancybox-1.3.1/css/jquery.fancybox.css">
</head>
<body>
<jsp:include page="../common/conmon.jsp"/>
<!--固定头部-->
<div id="header">
  <div id="arr" onclick="javascript:history.back(-1);"></div>
  <div id="School">问答详情</div>
  <div class="share"></div>
</div>
<!--中间内容 start-->

<!--中间内容 start-->
<div class="qus-wrap clear">
  <div class="con-left">
    <div class="blu">问</div>
  </div>
  <div class="con-head clear">
    <div class="right-ti">${questionVO.questionTitle}</div>
    <div class="add-p question-pic clear">
      <c:forEach items="${questionVO.questionPicList}" var="questionPic">
        <a href="${questionPic.picUrl}" title="" rel="lightbox-${questionVO.questionId}"><img src="${questionPic.picUrl}"></a>
      </c:forEach>
    </div>
 <%--   <div class="qus-bt clear">
      <a href="/user/220" class="mar-rig">qhrking1</a>
      <span class="mar-ri">的提问</span><span>2016-10-11</span>
      <span class="ect" data-qid="32">已收藏</span>

    </div>--%>

    <div class="qus-bt clear">
      <a href="/user/${questionVO.user.userId}" class="mar-rig">${questionVO.user.platformUserName}</a><span class="mar-ri">的提问</span><span>${z:dateFormat(questionVO.createTime)}</span>
        <c:if test="${isCollection}">
          <span class="ect" data-qid="${questionVO.questionId}">已收藏</span>
        </c:if>
        <c:if test="${!isCollection}">
          <span class="coll" data-qid="${questionVO.questionId}">收藏</span>
        </c:if>
    </div>

  </div>

</div>
<div class="con-bottom">全部回答(${questionVO.answerVoPage.totalCount})</div>
<div class="ans-wrap">
<c:forEach items="${questionVO.answerVoPage.content}" var="answerVo">
  <div class="ans-list clear">
    <div class="con-left">
      <div class="ora">答</div>
    </div>
    <div class="con-right">
      <p class="ans-user clear"><a href="/user/${answerVo.user.userId}">${answerVo.user.platformUserName}</a><span>${z:dateFormat(answerVo.createTime)}</span></p>
      <p class="ans-co clear">
        <a class="answer-c"> ${answerVo.answerContent} </a>
        <a class="agree clear"><span class="up" data-aid="${answerVo.answerId}"></span><span class="up-count">${answerVo.approvalCount}</span></a>
        <div class="add-p question-pic clear">
        <c:forEach items="${answerVo.answerPicList}" var="answerPic">
          <a href="${answerPic.picUrl}" title="" rel="lightbox-${answerVo.answerId}"><img src="${answerPic.picUrl}"></a>
        </c:forEach>
        </div>
      </p>
    </div>
  </div>
</c:forEach>
<%--<c:forEach items="${questionVO.answerVoPage.content}" var="answerVo">
  <div class="ans-list clear">
    <div class="con-left">
      <span class="ora">答</span>
    </div>
    <div class="con-right">
      <p class="ans-user clear"><a href="#">${answerVo.user.platformUserName}</a><span><fmt:formatDate value="${answerVo.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></p>
      <p class="ans-co">
        <a class="answer-c" href="#">${answerVo.answerContent}</a>
        <a class="agree clear" href="#"><span></span><span>${answerVo.approvalCount}</span></a>
      </p>
    </div>
  </div>
</c:forEach>--%>
</div>
<c:if test="${questionVO.answerVoPage.pageSize >10}">
  <div class="Load">
    <p class="load-more" data-id="${questionVO.questionId}" page="${questionVO.answerVoPage.pageIndex+1}" onclick="ask.answer.more()">加载更多</p>
  </div>
</c:if>
<div class="Blank"></div>
<!--我要提问 start-->
<div class="ask">
  <a  href="${g.domain}/question/${questionVO.questionId}/answer">回答</a>
</div>
<!--我要提问 end-->

<!--中间内容 end-->


<jsp:include page="../common/footer.jsp" flush="false" />
<script type="text/javascript" src="${g.domain}/resource/jquery-fancybox-1.3.1/js/jquery.fancybox-1.3.1.pack.js"></script>
<script type="text/javascript" src="${g.domain}/resource/js/ask.question.js"></script>
<script type="text/javascript" src="${g.domain}/resource/js/wap/ask.loadmore.js"></script>
<script type="text/javascript" src="${g.domain}/resource/js/date.ext.js"></script>
<script type="text/javascript" src="http://m.eduwo.com/r/cms/jiathis/js/jiathis.js"></script>
<script>
  //问题图片
  $(".question-pic a").fancybox(
          {'transitionIn':'elastic',
            'transitionOut'	:'elastic',
            'titlePosition':'inside'
          }
  );
  //回答图片*/
  $(".answer-pic a").fancybox(
          {'transitionIn':'elastic',
            'transitionOut'	:'elastic',
            'titlePosition':'inside'
          }
  );
</script>

<%--百度自动推送--%>
<script>
  (function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
      bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
    }
    else {
      bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
  })();
</script>

</body>
</html>
