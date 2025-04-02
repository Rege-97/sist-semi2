<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function undisabled(){	
		var b = document.getElementById("termsagree");
		var bvalue = b.disabled;
		b.disabled = bvalue == true ? false : true;
	}
</script>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<fieldset>
		<h2>이용약관</h2>
		<iframe src="useterms.jsp"></iframe>
		<input type="checkbox" onchange="undisabled();"> 약관동의 
		<input type="button" id = "termsagree" value="다음" disabled  onclick="location.href = 'verification.jsp'">
	</fieldset>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>