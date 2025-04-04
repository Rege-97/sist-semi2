<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>    
<jsp:useBean id="noticeDto" class="com.plick.support.NoticeDto"></jsp:useBean>
<jsp:setProperty property="*" name="noticeDto"/>    
<jsp:useBean id="noticeDao" class="com.plick.support.NoticeDao"></jsp:useBean>
<%

response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");
int result = noticeDao.addNotice(noticeDto);
String msg = result>0? "공지사항 올리기 성공!":"글 올리기 실패요";
%>   
<script>
window.alert('<%=msg%>');
location.href='/semi2/support/main.jsp';
</script>