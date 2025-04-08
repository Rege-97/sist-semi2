<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.member.MemberDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
MemberDao memberDao = new MemberDao();

boolean access = memberDao.findPassword(request.getParameter("email"), request.getParameter("name"), request.getParameter("tel"));

if(!access){
%>
<script>
window.alert("잘못 입력하셨습니다");
history.back();
</script>	
<%
}else{
%>
<script>
var pwdsame = true;
function testPassword() {
	var pwd = document.getElementById("pwd").value;
	var pwd2 = document.getElementById("pwdTest").value;
	if (pwd == pwd2){
		document.getElementById("pwdCheck").innerText = "입력하신 비밀번호가 같습니다";
		pwdsame = true;
	}else{
		document.getElementById("pwdCheck").innerText = "입력하신 비밀번호가 다릅니다";
		pwdsame = false;
	}
}
function formCheck(event) {
	var a = true;
	if (pwdsame == false){ 
		event.preventDefault();
		a = false;
	}
	if (!a) window.alert("form에 잘못된 부분 있음 확인바람");
}
</script>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="login-box">
	<form action = "password-reset_ok.jsp?email=<%=request.getParameter("email") %>" method = "post" onsubmit = "formCheck(event)">
		<div class="blank"></div>
		<div class="signup-title">비밀번호 찾기</div>
		<div class="blank3"></div>
		<input type="password" id = "pwd" name = "password" class="login-text" placeholder="새 비밀번호" onchange = "testPassword()">
		<input type="password" id = "pwdTest" class="login-text" placeholder="새 비밀번호 확인" onchange = "testPassword()">
		<div>
		<label id = pwdCheck></label>
		</div class="signin-hidden">
		<div class="blank3"></div>
		<input type="submit" value="비밀번호 변경" class="bt">
	</form>
</div>
<%@ include file="/footer.jsp" %>
</body>
<%
}
%>
</html>