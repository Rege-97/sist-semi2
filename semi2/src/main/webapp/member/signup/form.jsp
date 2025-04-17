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


ArrayList<String> emailForms = new ArrayList<String>();
emailForms.add("gmail.com");
emailForms.add("naver.com");
emailForms.add("nate.com");
emailForms.add("daum.net");
%>
<script>
// select에서 직접 입력 선택시 입력 메뉴 보여주는 함수 (셀렉트 박스 숨길 때 style.display 사용했음)
var pwdsame = false;

function changeDirectInput(selectelement){
	if(selectelement.value == "직접입력") {
		document.getElementById("emailTail").value = "";
		document.getElementById("emailTail").removeAttribute("readonly");
	}else{
		document.getElementById("emailTail").value = selectelement.value;
		document.getElementById("emailTail").setAttribute("readonly", true);
	} 
	assembleEmail();
}
function assembleEmail() {
	var emailHead = document.getElementById("emailHead").value;
	var emailTail = document.getElementById("emailTail").value;
	var email = emailHead+"@"+emailTail;
	document.getElementById("assembleEmail").value = email;
	document.getElementById("form_hidden").src = "form_hidden.jsp?email="+email;
}
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
function testNickname() {
	var nickname = document.getElementById("nickname").value;
	document.getElementById("form_hidden").src = "form_hidden.jsp?nickname="+nickname;
}
// 제약사항 확인
// id
function formCheck(event) {
	var a = true;
	if (pwdsame == false){ 	
		event.preventDefault();
		a = false;
	}
	if (document.getElementById("nickname").value == null || document.getElementById("nickname").value == ""){
		event.preventDefault();
		a = false;
	}
	if (!a) window.alert("form에 잘못된 부분 있음 확인바람");
}

</script>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="signin-box">
	<form action = "form_ok.jsp" method = "post" onsubmit="formCheck(event);">
		<div class="signup-title">회원가입</div>
		<div class="blank"></div>
		<input type = "hidden" name = "name" value = "<%=request.getParameter("name") %>">
		<input type = "hidden" name = "tel" value = "<%=request.getParameter("tel") %>"> 
		<input type = "hidden" name = "access_type" value = "listener">
		<div class="signup-text-name">성함 : <%=request.getParameter("name") %> 님</div>
		<div class="signup-text-name">전화번호 : <%=request.getParameter("tel") %></div>
		<input type="text" id = "emailHead" placeholder="이메일" class="signup-text-email">@
		<input type="text" id = "emailTail" value = "선택" readonly class="signup-text-email">
		<select class="signup-select" onchange="changeDirectInput(this);">
		<option disabled selected>선택</option>
<%
for (int i = 0; i < emailForms.size(); i++) {
%>
		<option value = "<%=emailForms.get(i) %>"> <%=emailForms.get(i) %></option>
<%
}
%>
		<option>직접입력</option>
		</select>
		<div class="signin-hidden">
		<label id = "checkEmailDuplicate"></label>
		</div>
		<input type = "email" id = "assembleEmail" name = "email" style = "display: none;"> 
		<div>
		<input type="text" id = "nickname" name = "nickname" class="signup-text"placeholder="닉네임" onchange = "testNickname();">
		</div>
		<div class="signin-hidden">
		<label id = "checkNicknameDuplicate"></label>
		</div>
		<div>
		<input type="password" id = "pwd" name = "password" class="signup-text" placeholder="비밀번호" onchange="testPassword();">
		</div>
		<div>
		<input type="password" id = "pwdTest" class="signup-text" placeholder="비밀번호 확인" onchange="testPassword();">
		</div>
		<div class="signin-hidden">
		<label id = "pwdCheck"></label>
		</div>
		<div>
		<div class="blank"></div>
		<input type="submit" value="가입하기" class="bt">
		</div>
	</form>
</div>
<iframe id = "form_hidden" style = "display: none;"></iframe>
<%@ include file="/footer.jsp" %>
</body>
</html>