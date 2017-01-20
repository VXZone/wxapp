<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>我要提问_留学问答平台|留学e网</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="keywords" content="留学问答社区，留学热门问题，留学常见问题">
  <meta name="description" content="留学e网问答社区为您解答所有留学相关的热门问题及常见问题" >
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
  <link href="${g.domain}/resource/css/wap/ask.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../common/conmon.jsp"/>
<!--固定头部-->
<div id="header">
  <div id="arr" onclick="javascript:history.back(-1);"></div>
  <div id="School">我要提问</div>
</div>
<!--中间内容 start-->

<!--我要提问 start-->
<div class="quiz">
  <div class="quiz-ti">
    <p>提问5分钟后就有回答</p>
    <p>清晰描述您的提问,可以获得更加准确的回答</p>
  </div>
</div>
<div class="quiz-co">
  <form id="askForm">
  <input type="text" name="questionTitle" class="my-qu" placeholder="在这里简要描述您的问题" >
  <div class="supply">补充说明（选填）</div>
    <textarea class="su-qu" name="questionContent" id="questionContent" placeholder="在这里可以详细描述您的问题，详细全面的问题有助于得到更专业的回答哦"></textarea>

    <div class="leftsideBar  clear" style="margin-bottom:0.25rem;">
      <p style="margin-top:0.25rem;">已选择标签：</p>
      <p class="p-tag tag-selected"><i>标签限制6个以内</i></p>
    </div>
    <div class="leftsideBar  clear">
      <p style="margin-top:0.25rem;">可选择标签：</p>
      <p class="p-tag tag-selectable"></p>
    </div>

  <c:if test="${msg != null }">
    <p class="leftsideBar error-tip" >*${msg}</p>
  </c:if>

  <input type="button" value="提交问题" class="submit" onclick="ask.question.add();">
  </form>
</div>
<!--我要提问 end-->
<jsp:include page="../common/footer.jsp" flush="false" />
<script type="text/javascript" src="${g.domain}/resource/js/ask.ask.js"></script>
</body>

</html>
