<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="com.plick.mypage.MypageDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<script>
	function undisabled() {
		var b = document.getElementById("termsAgree");
		var bvalue = b.disabled;
		b.disabled = bvalue == true ? false : true;
	}
	function requestArtist() {
		window.alert("정말 신청하시겠습니까?\n불필요한 신청 시 서비스 이용이 제한될 수 있습니다.");
		location.href = '/semi2/mypage/request/artist-request_ok.jsp';
	}
</script>
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/mypage/mypage-header.jsp"%>
	<div class="login-box">
		<div class="signup-title">이용약관</div>
		<iframe src="useterms.jsp" class="terms"></iframe>
		<div class="terms-checkbox">
			<div class="terms-checkbox-in">
				<input type="checkbox" onchange="undisabled();">
				<div class="id-remember">약관에 동의합니다.</div>
			</div>
		</div>
		<input type="button" id="termsAgree" value="아티스트 신청하기" class="bt"
			disabled onclick="requestArtist();">
	</div>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>