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


ArrayList<String> emailformlist = new ArrayList<String>();
emailformlist.add("gmail.com");
emailformlist.add("naver.com");
emailformlist.add("nate.com");
emailformlist.add("daum.net");
%>
<script>
// select에서 직접 입력 선택시 입력 메뉴 보여주는 함수 (셀렉트 박스 숨길 때 style.display 사용했음)
function changeDirectInput(se){
	if (se.value == "direct"){
		se.style.display = "none";
		var inputfield = document.createElement("input");
		inputfield.type = "text";
		inputfield.name = "emailtail";
		document.getElementById("directinput").appendChild(inputfield);
	}
}
</script>
</head>
<body>
<%@ include file="/header.jsp" %>
<fieldset>
	<form action = "form_ok.jsp">
		<h2>회원가입</h2>
		<input type = "hidden" name = "name" value = "<%=request.getParameter("name") %>">
		<input type = "hidden" name = "tel" value = "<%=request.getParameter("tel") %>"> 
		이름:<%=request.getParameter("name") %> 전화번호:<%=request.getParameter("tel") %>
		
		<input type="text" name = "emailhead" placeholder="이메일">@
		<select onchange="changeDirectInput(this);">
		<option disabled selected>선택</option>
<%
for (int i = 0; i < emailformlist.size(); i++) {
%>
		<option value = "<%=emailformlist.get(i) %>"> <%=emailformlist.get(i) %></option>
<%
}
%>
		<option value = "<%="direct" %>">직접입력</option>
		</select>
		<div id = "directinput">
		</div>
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