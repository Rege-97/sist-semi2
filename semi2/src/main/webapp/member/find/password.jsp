<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="body-content">
<div class="login-box">
	<form action = "password-reset.jsp" method = "post" onsubmit = "formCheck(event);">
		<div class="blank"></div>
		<div class="signup-title">비밀번호 찾기</div>
		<input type="text" name = "email" id = "email" class="login-text" placeholder="아이디">
		<br>
		<input type="text" name = "name" id = "name" class="login-text" placeholder="이름">
		<br>
		<input type="text" name = "tel" id = "tel" class="login-text" placeholder="전화번호" oninput = "numCheck(this)">
		<br>
		<input type="submit" class="bt" value="다음">
	</form>
</div>
<%@ include file="/footer.jsp" %>
<script>
//숫자 외 입력차단
function numCheck(ip) {
	inputTel = ip;
	ip.value = ip.value.replace(/[^0-9]/g, "");
}
// 숫자만 허용 11자리 고정
function formCheck(e){
	var tel = document.getElementById("tel");
	var name = document.getElementById("name").value;
	var email = document.getElementById("email").value;
	
	if (email == "" || email == null){
		window.alert("이메일이 비어있습니다");
		e.preventDefault();
		return;
	}
	if (name == "" || name == null){
		window.alert("이름이 비어있습니다");
		e.preventDefault();
		return;
	}
	var tel = document.getElementById("email").value;
	if (!(tel.value.length == 11)){
		window.alert("전화번호를 확인해주세요");
		e.preventDefault();
		return;
	}

}
</script>
</div>
</body>
</html>