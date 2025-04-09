<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.support.*" %>    
<%@page import="java.text.*"%>
<jsp:useBean id="noticeDao" class="com.plick.support.NoticeDao"></jsp:useBean>
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
		NoticeDto dto = noticeDao.showContent(id);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String createAt = sdf.format(dto.getCreatedAt());
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
<div class="support-view-box">
<div class="support-view-title"><%=dto.getTitle() %></div>
<div class="support-view-content"><%=dto.getContent().replaceAll("\n", "<br>") %></div>
<div class="support-view-date">작성일자 : <%=createAt%></div>
</div>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>