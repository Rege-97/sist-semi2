<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@page import="com.plick.signedin.SignedinDao"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
	<%
	if(session.getAttribute("signedinDto")==null){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}else if(((SignedinDto) session.getAttribute("signedinDto")).getMemberId() == 0){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}
	%>
</head>
<%
request.setCharacterEncoding("UTF-8");
%>
<body>
<%@ include file="/header.jsp" %>
<%
SignedinDao sDao = new SignedinDao();
String pwd = request.getParameter("password");
int result = sDao.verifyPasswordReset(signedinDto, pwd);
boolean pwdCheck = result == 0 ? true : false;
%>
<script>
if (<%=pwdCheck %>){
}else{
	window.alert("입력하신 비밀번호가 잘못되었습니다.");
	history.back();
}

var pwdsame = true;
function testPassword() {
	var pwd = document.getElementById("pwd").value;
	var pwd2 = document.getElementById("pwdTest").value;
	if (pwd == pwd2){
		document.getElementById("pwdCheck").innerText = "입력하신 비밀번호가 같습니다";
		pwdsame = true;
		if (pwd == <%=pwd %>){
			document.getElementById("pwdCheck").innerText = "이전과 동일한 비밀번호는 사용하실 수 없습니다";
			pwdsame = false;
		}
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
	if (!a){
		window.alert("form에 잘못된 부분 있음 확인바람");
		event.preventDefault();
	}
}
</script>
	<%@ include file="/mypage/mypage-header.jsp"%>
	<div class=profile-change-card>
		<div class="subtitle">
			<h2>비밀번호 찾기</h2>
		</div>
	<form action = "password-reset_ok.jsp" method = "post" onsubmit = "formCheck(event)">
		<input type="password" id = "pwd" name = "password" placeholder="새 비밀번호" onchange = "testPassword()" class="login-text">
		<br>
		<input type="password" id = "pwdTest" placeholder="새 비밀번호 확인" onchange = "testPassword()" class="login-text">
		<div class="signin-hidden">
		<label id = pwdCheck></label>
		</div>
		<input type="submit" value="비밀번호 변경" class="bt">
	</form>
</div>
<%@ include file="/footer.jsp" %>
</body>
</body>
</html>