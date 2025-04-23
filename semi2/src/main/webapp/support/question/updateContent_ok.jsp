<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>     
<jsp:useBean id="questionDao" class="com.plick.support.QuestionDao"></jsp:useBean>
<jsp:useBean id="questionDto" class="com.plick.support.QuestionDto"></jsp:useBean>
<jsp:setProperty property="*" name="questionDto"/>
<%
String swAnswer = request.getParameter("swAnswer");
String page_str = request.getParameter("page");
if (page_str == null || page_str.equals("")) {
	page_str="1";
}
int previousPage = Integer.parseInt(page_str);
int result = questionDao.updateQuestion(questionDto);
String msg = result>0? "수정 성공":"수정 실패";
%>    
<script>
window.alert('<%=msg%>');
location.href="/semi2/support/question/showContent.jsp?id=<%=questionDto.getId()%>&page=<%=previousPage%>&answer=<%=swAnswer%>";
</script>