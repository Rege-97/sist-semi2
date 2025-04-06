<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>      
<jsp:useBean id="signedinDto" class="com.plick.signedin.signedinDto" scope="session"></jsp:useBean>
<%
String accessType=signedinDto.getMemberAccessType();
String title = request.getParameter("title");
if(!accessType.equals("admin")){
	%>
	<script>
	window.alert('잘못된 접근입니다.');
	location.href='/semi2/support/main.jsp';
	</script>
	<%
	
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/header.jsp" %>
<h1>질문 답글쓰기</h1>
<form name="writeForm" action="/semi2/support/question/answer_ok.jsp" method="post">
<label>제목</label><input name="title" type="text" value="re:<%=title%>"><br>
<textarea name="content"></textarea>
<input type="hidden" name="memberId" value="<%=signedinDto.getMemberId()%>">
<input type="hidden" name="parentId" value="<%=request.getParameter("id") %>">
<script>
window.alert('<%=signedinDto.getMemberId() %>')
window.alert('parentId:<%=request.getParameter("id") %>')
</script>
<input type="submit" value="글쓰기">
</form>


<%@ include file="/footer.jsp" %>
</body>
</html>