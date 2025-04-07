<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/header.jsp" %>
<%
String accessType=signedinDto.getMemberAccessType();
if(accessType==null){
	accessType="";
}
if(!accessType.equals("admin")){
	%>
	<script>
	window.alert('잘못된 접근입니다.');
	location.href='/semi2/support/main.jsp';
	</script>
	<%
}
%>
<h1>공지사항 글쓰기</h1>
<form name="writeForm" action="/semi2/support/faq/write_ok.jsp" method="post">
<label>제목</label><input name="title" type="text" placeholder="제목을 입력하세요."><br>
<textarea name="content"></textarea>
<input type="hidden" name="memberId" value="<%=signedinDto.getMemberId()%>">
<input type="submit" value="글쓰기">
</form>


<%@ include file="/footer.jsp" %>
</body>
</html>