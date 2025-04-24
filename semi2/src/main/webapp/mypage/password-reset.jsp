<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@page import="com.plick.signedin.SignedinDao"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
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
<div class="body-content">
<%
SignedinDao sDao = new SignedinDao();
String pwd = request.getParameter("password");
int result = sDao.verifyPasswordReset(signedinDto, pwd);
boolean pwdCheck = (result == 0 ? false : true);
if (!pwdCheck){
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
	<%@ include file="/mypage/mypage-header.jsp"%>
	<div class=profile-change-card>
		<div class="subtitle">
			<h2>비밀번호 찾기</h2>
		</div>
	<form action = "password-reset_ok.jsp" method = "post" onsubmit = "formCheck(event)">
		<input type="password" id = "pwd" name = "password" placeholder="새 비밀번호" oninput = "testPassword()" class="login-text">
		<br>
		<input type="password" id = "pwdTest" placeholder="새 비밀번호 확인" oninput = "testPassword()" class="login-text">
		<div class="signin-hidden">
		<label id = pwdCheck></label>
		</div>
		<input type="submit" value="비밀번호 변경" class="bt">
	</form>
</div>
<%@ include file="/footer.jsp" %>
</div>
<%
}else{
%>
<script>
	window.alert("입력하신 비밀번호가 잘못되었습니다.");
	history.back();

</script>
<%
}
%>
</body>
</html>

