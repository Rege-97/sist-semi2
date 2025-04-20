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
String pwd = ((SignedinDto) session.getAttribute("signedinDto")).getMemberPassword();
boolean access = memberDao.findPassword(request.getParameter("email"), request.getParameter("name"), request.getParameter("tel").substring(0, 3)+"-"+request.getParameter("tel").substring(3, 7)+"-"+request.getParameter("tel").substring(7));

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
function testPassword() {
	var pwd = document.getElementById("pwd").value;
	var pwd2 = document.getElementById("pwdTest").value;
	var regex = /[!@#$%^&*]/;
	if (!regex.test(pwd)){
		document.getElementById("pwdCheck").innerText = "비밀번호에는 !, @, #, $, %, ^, &, * 중 한 개의 특수문자가 포함되어야 합니다.";
	}else{
		if (pwd == pwd2){
			document.getElementById("pwdCheck").innerText = "입력하신 비밀번호가 같습니다";
		if (pwd == "<%=pwd %>"){
			document.getElementById("pwdCheck").innerText = "이전과 동일한 비밀번호는 사용하실 수 없습니다";
		}
	}else{
			document.getElementById("pwdCheck").innerText = "입력하신 비밀번호가 다릅니다";
	}
	}
}
function formCheck(event) {
	if (document.getElementById("pwdCheck").innerText != "입력하신 비밀번호가 같습니다"){ 
		window.alert("비밀번호 확인바람");
		event.preventDefault();
		return;
	}
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
		<input type="password" id = "pwd" name = "password" class="login-text" placeholder="새 비밀번호" oninput = "testPassword()">
		<input type="password" id = "pwdTest" class="login-text" placeholder="새 비밀번호 확인" oninput = "testPassword()">
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