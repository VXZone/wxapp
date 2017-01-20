<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>我要回答_问答社区|留学e网</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="keywords" content="留学问答社区，留学热门问题，留学常见问题">
  <meta name="description" content="留学e网问答社区为您解答所有留学相关的热门问题及常见问题" >
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
  <link href="${g.domain}/resource/css/wap/answer.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../common/conmon.jsp"/>
<!--固定头部-->
<div id="header">
  <div id="arr" onclick="javascript:history.back(-1);"></div>
  <div id="School">我要回答</div>
</div>
<!--中间内容 start-->

<!--我要回答 start-->
<div class="Response">
  <input type="hidden" name="questionId" value="${questionId}">
  <textarea class="my-res" placeholder="我来帮TA回答" style="outline:none;resize:none;" name="answerContent" id="answerContent"></textarea>
  <%--<a href="#" class="transfer-p"></a>--%>
  <a class="submit" onclick="ask.answer.add();">提交回答</a>
</div>
<!--我要回答 end-->

<jsp:include page="../common/footer.jsp" flush="false" />
<script src="${g.domain}/resource/js/ask.answer.js"></script>
</body>

</html>
