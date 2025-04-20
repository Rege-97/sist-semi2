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
	<form action = "form.jsp" method = "post" onsubmit = "formCheck(event)">
		<div class="signup-title">본인인증</div>
	<div class="signup-check">
		<input type="text" name = "name" id = "name" placeholder="이름" class="login-text">
		<input type="tel" name = "tel" id = "tel" placeholder="전화번호(숫자만 입력)" class="login-text" oninput="numCheck(this);">
		</div>
		<input type="submit" value="다음" class="bt">
	</form>
	</div>
<%@ include file="/footer.jsp" %>
<script>
var inputTel; 
// 숫자 외의 입력 차단
function numCheck(ip) {
	inputTel = ip;
	ip.value = ip.value.replace(/[^0-9]/g, "");
}
function formCheck(e) {
	// 40자 이해, 한글과 영문만 허용
	var name = document.getElementById("name");
	
	if(name.value.length > 40){
		window.alert("이름이 입력 범위를 초과하였습니다.");
		e.preventDefault();
		return;
	}
	if (name.value == null || name.value == ""){
		window.alert("이름이 비어있습니다.");
		e.preventDefault();
		return;
	}
	for (var i = 0; i < name.value.length; i++){
		var charidx = name.value.charCodeAt(i);

		if ((((charidx < 65 || (charidx >= 91 && charidx <= 96)) || (charidx >= 123 && charidx <= 126))) || !(charidx >= 44032 && charidx <= 55203)){
			if (b){
				window.alert("이름의 값이 형식과 맞지 않습니다");
				e.preventDefault();
				return;
			}
			break;
		}
	}
	
	// 숫자만 허용 11자리 고정
	var tel = document.getElementById("tel");
	if (!(tel.value.length == 11)){
		window.alert("유효하지 않은 전화번호 입니다.");
		e.preventDefault();
		return;
	}
	
	
}
</script>
</body>
</html>