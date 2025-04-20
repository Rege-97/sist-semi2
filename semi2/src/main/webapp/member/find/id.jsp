<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="login-box">
	<form action = "id-result.jsp" method = "post" onsubmit = "formCheck(event);">
	<div class="blank2"></div>
		<div class="signup-title">아이디 찾기</div>
		<input type="text" name = "name" id = "name" class="login-text" placeholder="이름">
		<br>
		<input type="text" name = "tel" id = "tel" class="login-text" oninput = "numCheck(this)" placeholder="전화번호">
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
//숫자만 허용 11자리 고정
function formCheck(e){
	var tel = document.getElementById("tel");
	var name = document.getElementById("name").value;
	if (name == "" || name == null){
		window.alert("빈값이 있습니다");
		e.preventDefault();
		return;
	}
	if (!(tel.value.length == 11)){
		window.alert("전화번호를 확인해주세요");
		e.preventDefault();
		return;
	}

}
</script>
</body>
</html>