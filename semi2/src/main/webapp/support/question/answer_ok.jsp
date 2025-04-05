<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>    
<jsp:useBean id="questionDto" class="com.plick.support.QuestionDto"></jsp:useBean>
<jsp:setProperty property="*" name="questionDto"/>    
<jsp:useBean id="questionDao" class="com.plick.support.QuestionDao"></jsp:useBean>
<%
System.out.println("부모키:"+questionDto.getParentId());
System.out.println("멤버번호:"+questionDto.getMemberId());
int result = questionDao.addAnswer(questionDto);
String msg = result>0? "답변 올리기 성공!":"답변 올리기 실패요";
%>   
<script>
window.alert('<%=msg%>');
location.href='/semi2/support/question.jsp';
</script>