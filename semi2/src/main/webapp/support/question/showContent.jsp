<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.support.*" %>    
<jsp:useBean id="questionDao" class="com.plick.support.QuestionDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
	%>
<section>
	<article>
		<table>
			<tr>
			<th><label>제목</label>
			<td><%=dto.getTitle() %>
			<tr>
			<td colspan="2"><%=dto.getContent() %>
			
			<%
			String accessType=signedinDto.getMemberAccessType();
			if(accessType==null){
				accessType="";
			}
			if(accessType.equals("admin")&&swAnswer.equals("false")){
				%>
				<tr>
				<td>
				<form action="/semi2/support/question/answer.jsp" method="post">
				<input type="hidden" name="title" value="<%=dto.getTitle() %>">
				<input type="hidden" name="id" value="<%=dto.getParentId() %>">
				<input type="submit" value="답글">
				
				</form>
				<%
			}
			%>
			<td>
		</table>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>