<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
<%
//
request.setCharacterEncoding("UTF-8");


ArrayList<String> emailForms = new ArrayList<String>();
emailForms.add("gmail.com");
emailForms.add("naver.com");
emailForms.add("nate.com");
emailForms.add("daum.net");
%>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="body-content">
<div class="signin-box">
	<form action = "form_ok.jsp" method = "post" onsubmit="formCheck(event);">
		<div class="signup-title">회원가입</div>
		<div class="blank"></div>
		<input type = "hidden" name = "name" value = "<%=request.getParameter("name") %>">
		<input type = "hidden" name = "tel" value = "<%=request.getParameter("tel").substring(0, 3)+"-"+request.getParameter("tel").substring(3, 7)+"-"+request.getParameter("tel").substring(7) %>"> 
		<input type = "hidden" name = "access_type" value = "listener">
		<div class="signup-text-name">성함 : <%=request.getParameter("name") %> 님</div>
		<div class="signup-text-name">전화번호 : <%=request.getParameter("tel") %></div>
		<input type="text" maxlength="10" id = "emailHead" placeholder="이메일" class="signup-text-email">@
		<input type="text" maxlength="15" id = "emailTail" value = "선택" readonly oninput="assembleEmailF();" class="signup-text-email">
		<select class="signup-select" oninput="changeDirectInput(this);">
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
		<input type = "text" id = "assembleEmail" name = "email" style = "display: none;"> 
		<div>
		<input type="text" maxlength = "15" id = "nickname" name = "nickname" class="signup-text"placeholder="닉네임" oninput = "testNickname();">
		</div>
		<div class="signin-hidden">
		<label id = "checkNicknameDuplicate"></label>
		</div>
		<div>
		<input type="password" maxlength = "12" id = "pwd" name = "password" class="signup-text" placeholder="비밀번호" oninput="testPassword();">
		</div>
		<div>
		<input type="password" maxlength = "12" id = "pwdTest" class="signup-text" placeholder="비밀번호 확인" oninput="testPassword();">
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
<script>
// select에서 직접 입력 선택시 입력 메뉴 보여주는 함수 (셀렉트 박스 숨길 때 style.display 사용했음)
function changeDirectInput(selectelement){
	if(selectelement.value == "직접입력") {
		document.getElementById("emailTail").value = "";
		document.getElementById("emailTail").removeAttribute("readonly");
	}else{
		document.getElementById("emailTail").value = selectelement.value;
		document.getElementById("emailTail").setAttribute("readonly", true);
	} 
	assembleEmailF();
}
function assembleEmailF() {
	var emailHead = document.getElementById("emailHead").value;
	var emailTail = document.getElementById("emailTail").value;
	
	var email = emailHead+"@"+emailTail;
	
	var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if(regex.test(email)) {
		document.getElementById("checkEmailDuplicate").innerText = "사용가능한 이메일입니다.";
	}else{
		document.getElementById("checkEmailDuplicate").innerText = "형식과 맞지 않는 이메일입니다.";
	}
		
	document.getElementById("assembleEmail").value = email;
	document.getElementById("form_hidden").src = "form_hidden.jsp?email="+email;
}
function testPassword() {
	var pwdstr = document.getElementById("pwdCheck");
	var pwd = document.getElementById("pwd").value;
	var pwd2 = document.getElementById("pwdTest").value;
	var regex = /[!@#$%^&*]/;
	if (!regex.test(pwd)){
		pwdstr.innerText = "비밀번호에는 !, @, #, $, %, ^, &, * 중 한 개의 특수문자가 포함되어야 합니다.";
	}else{
		if (pwd == pwd2){
			pwdstr.innerText = "입력하신 비밀번호가 같습니다.";
		}else{
			pwdstr.innerText = "입력하신 비밀번호가 다릅니다.";
		}
		
	
	}
	
	
	 
}
function testNickname() {
	var nickname = document.getElementById("nickname").value;
	document.getElementById("form_hidden").src = "form_hidden.jsp?nickname="+nickname;
	var checknick = document.getElementById("checkNicknameDuplicate");
	if (checknick.value == "사용가능한 닉네임이에요."){
	}else{
	}
	if(nickname == "" || nickname == null){
		checknick.innerText = "닉네임을 입력하지 않았습니다.";
	}
}
// 제약사항 확인
// 이메일 형식 검사 / 중복 검사 / 직접입력 시 형식 검사
// 비밀번호 빈값 검사 / 비밀번호 확인과 일치 검사 
// 닉네임 빈값 검사 / 중복 검사
function formCheck(event) {
	if (document.getElementById("checkEmailDuplicate").innerText != "사용가능한 이메일입니다."){
		event.preventDefault();
		window.alert("이메일을 확인해주세요.");
		return;
	}
	if (document.getElementById("checkNicknameDuplicate").innerText != "사용가능한 닉네임입니다."){
		event.preventDefault();
		window.alert("닉네임을 확인해주세요.");
		return;
	}
	if (document.getElementById("nickname").value == null || document.getElementById("nickname").value == ""){
		event.preventDefault();
		window.alert("닉네임을 입력하지 않았습니다.");
		return;
	}
	if (document.getElementById("pwdCheck").innerText != "입력하신 비밀번호가 같습니다."){ 
		event.preventDefault();
		window.alert("비밀번호를 확인하세요.");
		return;
	}
}

</script>
</div>
</body>
</html>