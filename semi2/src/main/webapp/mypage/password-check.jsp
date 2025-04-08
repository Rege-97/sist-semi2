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
<legend>비밀번호 확인</legend>
<form action = "password-reset.jsp" method = "post">
<input type = "password" name = "password" placeholder="비밀번호">
<input type = "submit" value = "다음">
</form>
</fieldset>
<%@ include file="/footer.jsp" %>
</body>
</html>