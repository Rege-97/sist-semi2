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
	<form>
		<input type="email" placeholder="아이디(이메일)">
		<br>
		<input type="password" placeholder="비밀번호">
		<br>
		<input type="checkbox">아이디 저장
		<br>
		<input type="submit" value = "로그인">
		<br>
		<label onclick="location.href = '/semi2/member/find/id.jsp'">아이디 찾기</label>|
		<label onclick="location.href = '/semi2/member/find/password.jsp'">비밀번호 찾기</label>
		<label onclick="location.href = '/semi2/member/signup/terms.jsp'">회원가입</label>
	</form>
</fieldset>
<%@ include file="/footer.jsp" %>
</body>
</html>