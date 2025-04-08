<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="login-box">
	<form action = "password-reset.jsp" method = "post">
		<div class="blank"></div>
		<div class="signup-title">비밀번호 찾기</div>
		<input type="text" name = "email" class="login-text" placeholder="아이디">
		<br>
		<input type="text" name = "name" class="login-text" placeholder="이름">
		<br>
		<input type="text" name = "tel" class="login-text" placeholder="전화번호">
		<br>
		<input type="submit" class="bt" value="다음">
	</form>
</div>
<%@ include file="/footer.jsp" %>
</body>
</html>