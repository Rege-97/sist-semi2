<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<script>
	function undisabled(){	
		var b = document.getElementById("termsAgree");
		var bvalue = b.disabled;
		b.disabled = bvalue == true ? false : true;
	}
</script>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<div class="login-box">
		<div class="signup-title">이용약관</div>
		<iframe src="useterms.jsp"  class="terms"></iframe>
		<div class= "terms-checkbox">
		<div class="terms-checkbox-in">
		<input type="checkbox" onchange="undisabled();"> <div class="id-remember">약관에 동의합니다.</div> 
		</div>
		</div>
		<input type="button" id = "termsAgree" value="다음" class="bt"disabled  onclick="location.href = 'verification.jsp'">
		</div>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>