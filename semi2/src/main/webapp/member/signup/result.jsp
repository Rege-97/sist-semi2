<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>환영해요 <%=request.getParameter("name") %>님!</h1>

<input type = "button" value = "로그인 하러가기" onclick = "location.href = '/member/signin.jsp'">
</body>
</html>