<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="deleteDao" class="com.plick.support.DeleteDao"></jsp:useBean>
<%
SignedinDto loggedinUser = (SignedinDto) session.getAttribute("signedinDto");
if (loggedinUser == null || loggedinUser.getMemberId() == 0 || !loggedinUser.getMemberAccessType().equals("admin")) {
%>
<script>
	window.alert('권한이 없습니다.');
	location.href = '/semi2/support/main.jsp';
</script>
<%
return;
}
String id_str = request.getParameter("id");
if (id_str == null || id_str.equals("")) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	location.href = '/semi2/support/main.jsp';
</script>
<%
}
int id = Integer.parseInt(id_str);
if (deleteDao.delete(id, "notice") <= 0) {
%>
<script>
	window.alert('삭제에 실패했습니다.');
	window.location.href = document.referrer;
</script>
<%
return;
}
%>
<script>
	window.alert('삭제 성공');
	window.location.href = '/semi2/support/main.jsp';
</script>