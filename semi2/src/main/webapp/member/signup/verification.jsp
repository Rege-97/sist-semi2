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
	<form action = "form.jsp" method = "post">
		<h2>본인인증</h2>
		<input type="text" name = "name" placeholder="이름">
		<br>
		<input type="text" name = "tel" placeholder="전화번호">
		<br>
		<input type="submit" value="다음">
	</form>
</fieldset>
<%@ include file="/footer.jsp" %>
</body>
</html>