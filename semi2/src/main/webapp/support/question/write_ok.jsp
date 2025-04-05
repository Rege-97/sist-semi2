<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>    
<jsp:useBean id="questionDto" class="com.plick.support.QuestionDto"></jsp:useBean>
<jsp:setProperty property="*" name="questionDto"/>    
<jsp:useBean id="questionDao" class="com.plick.support.QuestionDao"></jsp:useBean>
<%

response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");
int result = questionDao.addQuestion(questionDto);
String msg = result>0? "공지사항 올리기 성공!":"글 올리기 실패요";
%>   
<script>
window.alert('<%=msg%>');
location.href='/semi2/support/question.jsp';
</script>