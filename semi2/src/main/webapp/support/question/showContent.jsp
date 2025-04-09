<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.support.*" %>    
<%@page import="java.text.*"%>
<jsp:useBean id="questionDao" class="com.plick.support.QuestionDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@include file="/header.jsp" %>
<%
String swAnswer = request.getParameter("answer");
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
	QuestionDto dto = questionDao.showContent(id);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String createAt = sdf.format(dto.getCreatedAt());
	%>
<section>
	<article>
	<div class="support-view-box-answer">
<div class="support-view-title"><%=dto.getTitle() %></div>
<div class="support-view-content"><%=dto.getContent().replaceAll("\n", "<br>") %></div>
<div class="support-view-date-box">
<div class="support-view-date">작성일자 : <%=createAt%></div>
			<%
			String accessType=signedinDto.getMemberAccessType();
			if(accessType==null){
				accessType="";
			}
			if(accessType.equals("admin")&&swAnswer.equals("false")){
				%>
				<form action="/semi2/support/question/answer.jsp" method="post">
				<input type="hidden" name="title" value="<%=dto.getTitle() %>">
				<input type="hidden" name="id" value="<%=dto.getParentId() %>">
				<div class="bt-answer"><input type="submit" value="답글" class="bt"></div>
				
				</form>
				<%
			}
			%>
			</div>
</div>

	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>