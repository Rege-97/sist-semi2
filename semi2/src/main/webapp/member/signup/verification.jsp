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
	<form action = "form.jsp" method = "post">
		<div class="signup-title">본인인증</div>
	<div class="signup-check">
		<input type="text" name = "name" placeholder="이름" class="login-text">
		<input type="text" name = "tel" placeholder="전화번호" class="login-text">
		</div>

		<input type="submit" value="다음" class="bt">
	</form>
	</div>
<%@ include file="/footer.jsp" %>
</body>
</html>