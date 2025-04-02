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
var pwdsame = false;

function changeDirectInput(selectelement){
	document.getElementById("emailtail").value = selectelement.value;
	assembleEmail()
	
}
function assembleEmail() {
	var emailhead = document.getElementById("emailhead").value;
	var emailtail = document.getElementById("emailtail").value;
	var email = emailhead+"@"+emailtail;
	document.getElementById("assembleemail").value = email;
	
	document.getElementById("form_hidden").src = "form_hidden.jsp?email="+email;
}
function testPassword() {
	var pwd = document.getElementById("pwd").value;
	var pwd2 = document.getElementById("pwdtest").value;
	if (pwd == pwd2){
		document.getElementById("pwdcheck").innerText = "입력하신 비밀번호가 같습니다";
		pwdsame = true;
	}else{
		document.getElementById("pwdcheck").innerText = "입력하신 비밀번호가 다릅니다";
		pwdsame = false;
	}
}
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
<body>
<%@ include file="/header.jsp" %>
<fieldset>
	<form action = "form_ok.jsp" method = "post" onsubmit="formCheck(event);">
		<h2>회원가입</h2>
		<input type = "hidden" name = "name" value = "<%=request.getParameter("name") %>">
		<input type = "hidden" name = "tel" value = "<%=request.getParameter("tel") %>"> 
		<input type = "hidden" name = "access_type" value = "listener">
		
		이름:<%=request.getParameter("name") %> 전화번호:<%=request.getParameter("tel") %>
		
		<input type="text" id = "emailhead" placeholder="이메일">@
		<input type="text" id = "emailtail" value = "선택">
		<select onchange="changeDirectInput(this);">
		<option disabled selected>선택</option>
<%
for (int i = 0; i < emailformlist.size(); i++) {
%>
		<option value = "<%=emailformlist.get(i) %>"> <%=emailformlist.get(i) %></option>
<%
}
%>
		<option value = "">직접입력</option>
		</select>
		<label id = "checkemailduplicate">나 여기 있다옹</label>
		<input type = "email" id = "assembleemail" name = "email"> 
		<input type="text" id = "nickname" name = "nickname" placeholder="닉네임">
		<br>
		<input type="text" id = "pwd" name = "password" placeholder="비밀번호">
		<input type="text" id = "pwdtest" placeholder="비밀번호 확인" onchange="testPassword();">
		<label id = "pwdcheck"></label>
		<br>
		<input type="submit" value="가입하기" onclick="assembleEmail();">
	</form>
</fieldset>
<iframe id = "form_hidden"></iframe>
<%@ include file="/footer.jsp" %>
</body>
</html>