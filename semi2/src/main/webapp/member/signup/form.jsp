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
	<form action = "result.jsp">
		<h2>회원가입</h2>
		<input type = "hidden" name = "name" value = "<%=request.getParameter("name") %>"> 
		이름:<%=request.getParameter("name") %> 전화번호:<%=request.getParameter("tel") %>
		<input type="text" placeholder="이메일">@
		<select>
		<option>naver.com</option>
		<option>gmail.com</option>
		</select>
		<br>
		<input type="text" name = "pwd" placeholder="비밀번호">
		<input type="text" name = "pwdcheck" placeholder="비밀번호 확인">
		<br>
		<input type="submit" value="가입하기">
	</form>
</fieldset>
<jsp:include page = "/footer.jsp"></jsp:include>
</body>
</html>