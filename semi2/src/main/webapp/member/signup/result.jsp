<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="body-content">
<div class="login-box">
<div class="blank1"></div>
<div class="signup-title">회원가입 성공!</div>
<div class="signup-title">환영해요 <%=request.getParameter("name") %>님!</div>
<input type = "button" value = "로그인 하러가기" class="bt" onclick = "location.href = '/semi2/member/signin.jsp'">
<div class="blank"></div>
</div>
<%@ include file="/footer.jsp" %>
</div>
</body>
</html>