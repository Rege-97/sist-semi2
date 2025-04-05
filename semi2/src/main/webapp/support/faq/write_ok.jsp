<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>    
<jsp:useBean id="faqDto" class="com.plick.support.FaqDto"></jsp:useBean>
<jsp:setProperty property="*" name="faqDto"/>    
<jsp:useBean id="faqDao" class="com.plick.support.FaqDao"></jsp:useBean>
<%

response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");
int result = faqDao.addFaq(faqDto);
String msg = result>0? "자주묻는질문 올리기 성공!":"자주묻는질문 올리기 실패요";
%>   
<script>
window.alert('<%=msg%>');
location.href='/semi2/support/faq.jsp';
</script>