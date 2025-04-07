<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.support.*" %>    
<jsp:useBean id="faqDao" class="com.plick.support.FaqDao"></jsp:useBean>
<%

String id_str = request.getParameter("id"); 
if(id_str==null||id_str.equals("")){
	%>
	<script>
	window.alert('잘못된 접근입니다.');
	location.href='/semi2/support/main.jsp';
	</script>
	<%
}
int	id = Integer.parseInt(id_str);
FaqDto dto = faqDao.showContent(id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<table>
			<tr>
			<th><label>제목</label>
			<td><%=dto.getTitle() %>
			<tr>
			<td colspan="2"><%=dto.getContent().replaceAll("\n", "<br>") %>
		</table>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>