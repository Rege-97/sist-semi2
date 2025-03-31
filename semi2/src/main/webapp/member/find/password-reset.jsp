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
<fieldset>
	<form action = "#">
		<h2>비밀번호 찾기</h2>
		<input type="text" placeholder="새 비밀번호">
		<br>
		<input type="text" placeholder="새 비밀번호 확인">
		<br>
		<input type="submit" value="비밀번호 변경">
	</form>
</fieldset>
<%@ include file="/footer.jsp" %>
</body>
</html>