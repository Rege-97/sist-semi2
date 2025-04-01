<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<fieldset>
		<h2>이용약관</h2>
		<iframe src="useterms.jsp"></iframe>
		<input type="checkbox"> 약관동의 <input type="button" value="다음"
			onclick="location.href = 'verification.jsp'">
	</fieldset>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>