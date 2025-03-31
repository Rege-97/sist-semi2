<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page = "/header.jsp"></jsp:include>
<fieldset>
	<form>
		<h2>아이디 찾기</h2>
		<h3>아이디는 <%="" %>입니다</h3>
		<br>
		<input type="button" value="로그인하러 가기" onclick="location.href = '/musicismylife/member/signin.jsp'">
	</form>
</fieldset>
<jsp:include page = "/footer.jsp"></jsp:include>
</body>
</html>