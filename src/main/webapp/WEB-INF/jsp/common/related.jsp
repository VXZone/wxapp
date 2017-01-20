<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${fn:length(relatedQuestionList)>0}" >
    <div class="related">
      <div>相关问题</div>
      <ul class="related-list clear">
        <c:forEach var="relatedQuestion" items="${relatedQuestionList}" varStatus="status">
          <li><a href="${g.domain}/question/${relatedQuestion.questionId}">${relatedQuestion.questionTitle}</a></li>
        </c:forEach>
      </ul>
    </div>
</c:if>