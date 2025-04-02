<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
<%@ include file="/header.jsp" %>
<fieldset>
	<form action = "form_ok.jsp">
		<h2>회원가입</h2>
		<input type = "hidden" name = "name" value = "<%=request.getParameter("name") %>">
		<input type = "hidden" name = "tel" value = "<%=request.getParameter("tel") %>"> 
		이름:<%=request.getParameter("name") %> 전화번호:<%=request.getParameter("tel") %>
<%
ArrayList<String> emailformlist = new ArrayList<String>();
emailformlist.add("gmail.com");
emailformlist.add("naver.com");
emailformlist.add("nate.com");
emailformlist.add("daum.net");
%>
		<input type="text" placeholder="이메일">@
		<select>
		<option disabled selected>선택</option>
<%
for (int i = 0; i < emailformlist.size(); i++) {
%>
		<option><%=emailformlist.get(i) %></option>
<%
}
%>
		<option>직접입력</option>
		</select>
		<br>
		<input type="text" name = "pwd" placeholder="비밀번호">
		<input type="text" name = "pwdcheck" placeholder="비밀번호 확인">
		<br>
		<input type="submit" value="가입하기">
	</form>
</fieldset>
<%@ include file="/footer.jsp" %>
</body>
</html>