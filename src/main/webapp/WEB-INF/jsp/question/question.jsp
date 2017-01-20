<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/function.tld" prefix="z"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${questionVO.questionTitle}_留学e网问答社区</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="keywords" content="${questionVO.questionTitle}">
  <meta name="description" content="${questionVO.questionTitle} ${questionVO.questionContent}" >
  <meta name="360-site-verification" content="2a51660781fbbbac8f3fd39db453a7c3">
  <link rel="stylesheet" type="text/css" href="${g.domain}/resource/css/ask-question.css">
  <link rel="stylesheet" href="${g.domain}/resource/jquery-fancybox-1.3.1/css/jquery.fancybox.css">
<body>
<jsp:include page="../common/header.jsp" flush="false" />

<!-- 问答详情 start-->
<div class="details-nav">
  <a href="/" class="nav-a"><span>问答></span><span></span></a>
  <span class="nav-s">回答详情</span>
</div>
<div class="main-content">
  <div class="wrap-left">
    <div class="problem">
<%--      <div class="pro-ti">${questionVO.questionTitle}</div>--%>
      <div class="pro-ti clear">
        <h2 class="pro-ti1">${questionVO.questionTitle}</h2>
        <!-- JiaThis Button BEGIN -->
        <p class="pro-ti3">
          <a href="http://www.jiathis.com/share" class="jiathis" target="_blank"><span class="share">分享</span></a>
        </p>
        <script type="text/javascript" >
          var jiathis_config={
            summary:"",
            shortUrl:false,
            hideMore:false
          }
        </script>
        <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
        <!-- JiaThis Button END -->

        <p class="pro-ti2">
          <c:if test="${isCollection}">
            <span class="ect" data-qid="${questionVO.questionId}">已收藏</span>
          </c:if>
          <c:if test="${!isCollection}">
            <span class="coll" data-qid="${questionVO.questionId}">收藏</span>
          </c:if>
        </p>
      </div>
      <div class="pro-ab">
        <div class="right-h">
          <a href="/user/${questionVO.user.userId}" target="_blank" class="user-n">${questionVO.user.platformUserName}
            <%--<div class="User-W">
              <div class="toparr"></div>
              <div class="botblock">
                <ul class="user-p">
                  <li><a href="#"><img ></a></li>
                  <li><a href="#">${questionVO.user.platformUserName}</a></li>
                  <li><a href="#">简介：留学e网、澳洲留学顾问</a></li>
                </ul>
                <div class="i-w">
                  <ul class="user-i clear">
                    <li><a href="#"><span>回答</span><span>214</span></a><span>|</span></li>
                    <li><a href="#"><span>提问</span><span>47</span></a><span>|</span></li>
                    <li><a href="#"><span>获赞</span><span>12</span></a></li>
                  </ul>
                  <div class="user-a"><a href="#">向TA提问</a></div>
                </div>
              </div>
            </div>--%>
          </a>
          <c:if test="${null!=answerUser}" >
            向<a href="/user/${answerUser.userId}" target="_blank" class="user-answer">${answerUser.platformUserName}</a>
          </c:if>
        </div>
        <span class="pro-wo">
            的提问
        </span>
        <span class="pro-wo">${z:dateFormat(questionVO.createTime)}</span>
        <c:forEach items="${questionVO.tagList}" var="tag">
          <span class="pro-wow"><a href="/tag/${tag.tagId}">${tag.tagName}</a></span>
         </c:forEach>
      </div>
      <p class="supply">${questionVO.questionContent}</p>
	  <ul class="qus-pic question-pic clear">
      <c:forEach items="${questionVO.questionPicList}" var="questionPic">
        <li><a href="${questionPic.picUrl}" title="" rel="lightbox-${questionVO.questionId}"><img src="${questionPic.picUrl}" title="${questionVO.questionTitle}"></a></li>
      </c:forEach>
      </ul>
      <div class="ans-ti">全部回答(${questionVO.answerVoPage.totalCount})</div>
    </div>
    <ul class="answer clear">

      <c:forEach items="${questionVO.answerVoPage.content}" var="answerVo">
      <li class="ans-co  ans-top clear">
        <div class="ans-left">
          <div class="right-h2">
            <a href="#" class="ans-head">
              <img src="${answerVo.user.avatarUrl!=null?answerVo.user.avatarUrl:'/resource/images/no_avatar.jpg'}" onerror="this.src='/resource/images/no_avatar.jpg'" rel="nofollow">
            </a>
            <%--<div class="User-W2">
              <div class="toparr"></div>
              <div class="botblock">
                <ul class="user-p">
                  <li><a href="#" class="pe1"><img ></a></li>
                  <li><a href="#" class="pe2">那片海yaya</a></li>
                  <li><a href="#" class="pe3">简介：留学e网、澳洲留学顾问</a></li>
                </ul>
                <div class="i-w">
                  <ul class="user-i clear">
                    <li><a href="#" class="pe4"><span>回答</span><span>214</span></a><span>|</span></li>
                    <li><a href="#" class="pe4"><span>提问</span><span>47</span></a><span>|</span></li>
                    <li><a href="#" class="pe4"><span>获赞</span><span>12</span></a></li>
                  </ul>
                  <div class="user-a"><a href="#" class="pe7">向TA提问</a></div>
                </div>
              </div>
            </div>--%>

          </div>
          <%--<a href="#" class="groom">推荐回答</a>--%>
        </div>
        <ul class="ans-right">
          <li class=" clear">
            <div class="right-h">
              <a href="/user/${answerVo.user.userId}" target="_blank" >${answerVo.user.platformUserName}
                <%--<div class="User-W">
                  <div class="toparr"></div>
                  <div class="botblock">
                    <ul class="user-p">
                      <li><a href="#"><img ></a></li>
                      <li><a href="#">那片海yaya</a></li>
                      <li><a href="#">简介：留学e网、澳洲留学顾问</a></li>
                    </ul>
                    <div class="i-w">
                      <ul class="user-i clear">
                        <li><a href="#"><span>回答</span><span>214</span></a><span>|</span></li>
                        <li><a href="#"><span>提问</span><span>47</span></a><span>|</span></li>
                        <li><a href="#"><span>获赞</span><span>12</span></a></li>
                      </ul>
                      <div class="user-a"><a href="#">向TA提问</a></div>
                    </div>
                  </div>
                </div>--%>
              </a>
            </div>
            <span class="answer-tn">${answerVo.user.userProfile} </span><span class="answer-t">${z:dateFormat(answerVo.createTime)}</span>
          </li>
          <li>${answerVo.answerContent}</li>
          <li class="add-pic answer-pic" >
            <div class="ans-pic clear">
              <c:forEach items="${answerVo.answerPicList}" var="answerPic">
                <a href="${answerPic.picUrl}" title="" rel="lightbox-${answerVo.answerId}"><img src="${answerPic.picUrl}"></a>
              </c:forEach>
            </div>
          </li>
          <li class="agree"><div><span class="up" data-aid="${answerVo.answerId}" ></span><span class="up-count">${answerVo.approvalCount}</span></div></li>
        </ul>
      </li>
      </c:forEach>
    </ul>

    <jsp:include page="../common/pagination.jsp" flush="false" />

    <div class="my_answer">
      <form id="answerFrom">
        <div class="my-ti">我来回答</div>
        <div class="area-wrap">
          <input type="hidden" name="questionId"  value="${questionVO.questionId}" >
          <textarea placeholder="我来帮TA回答" class="my-co" name="answerContent" id="answerContent"></textarea>
        </div>
        <div id="uploader">
          <i>（图片限制4张以内）</i>
          <div id="filePicker">选择图片</div>
          <!--用来存放item-->
          <div id="fileList" class="uploader-list"></div>
        </div>
        <input type="button" value="提交回答" class="submit" onclick="ask.answer.add();">
      </form>
    </div>
  </div>

  <div class="wrap-right">
    <jsp:include page="../common/subject.jsp" flush="false" />
    <jsp:include page="../common/apply.jsp" flush="false" />
    <jsp:include page="../common/related.jsp" flush="false" />
  </div>
</div>

<!-- 问答内容 end-->
<!-- 底部 footer-->
<jsp:include page="../common/footer.jsp" flush="false" />
<!--底部 end-->
<script type="text/javascript" src="${g.domain}/resource/webuploader-0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${g.domain}/resource/jquery-fancybox-1.3.1/js/jquery.fancybox-1.3.1.pack.js"></script>
<script type="text/javascript" src="${g.domain}/resource/js/ask.answer.js"></script>
<script type="text/javascript" src="${g.domain}/resource/js/ask.question.js"></script>
<script type="text/javascript" src="${g.domain}/resource/js/ask.upload.js"></script>
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


