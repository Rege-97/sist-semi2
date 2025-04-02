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
function changeDirectInput(selectelement){
	if (selectelement.value == "direct"){
		selectelement.style.display = "none";
		var inputfield = document.createElement("input");
		inputfield.type = "text";
		inputfield.id = "emailtaildirect";
		document.getElementById("directinput").appendChild(inputfield);
	}
}

function assembleEmail() {
	var emailhead = document.getElementById("emailhead").value;
	var emailtail = document.getElementById("emailtaildirect") == null ?
			document.getElementById("emailtail").value : 
			document.getElementById("emailtaildirect").value;
			
	document.getElementById("assembleemail").value = emailhead+"@"+emailtail;
	window.alert(document.getElementById("assembleemail").value);
}
function testPassword() {
	var pwd = document.getElementById("pwd").value;
	var pwd2 = document.getElementById("pwdtest").value;
	document.getElementById("pwdcheck").innerText =
		pwd == pwd2 ? "입력하신 비밀번호가 같습니다" : "입력한 비밀번호가 다릅니다";
	
}

</script>
</head>
<body>
<%@ include file="/header.jsp" %>
<fieldset>
	<form action = "form_ok.jsp" method = "post">
		<h2>회원가입</h2>
		<input type = "hidden" name = "name" value = "<%=request.getParameter("name") %>">
		<input type = "hidden" name = "tel" value = "<%=request.getParameter("tel") %>"> 
		<input type = "hidden" name = "access_type" value = "listener">
		
		이름:<%=request.getParameter("name") %> 전화번호:<%=request.getParameter("tel") %>
		
		<input type="text" id = "emailhead" placeholder="이메일">@
		<select id = "emailtail" onchange="changeDirectInput(this);" >
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
		<input type = "email" id = "assembleemail" name = "email" value = ""> 
		<input type="text" name = "nickname" placeholder="닉네임">
		<br>
		<input type="text" id = "pwd" name = "password" placeholder="비밀번호">
		<input type="text" id = "pwdtest" placeholder="비밀번호 확인" onchange="testPassword();">
		<label id = "pwdcheck"></label>
		<br>
		<input type="submit" value="가입하기" onclick="assembleEmail();">
	</form>
</fieldset>
<%@ include file="/footer.jsp" %>
</body>
</html>