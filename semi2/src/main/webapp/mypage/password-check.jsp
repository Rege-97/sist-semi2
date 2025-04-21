<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.plick.mypage.MypageDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@ include file="/header.jsp"%>
	<div class="body-content">
	<%@ include file="/mypage/mypage-header.jsp"%>
	<div class=profile-change-card>
		<div class="subtitle">
			<h2>비밀번호 확인</h2>
		</div>
		<form action="password-reset.jsp" method="post">
			<div class="profile-change-card-input">
				<input type="password" name="password" placeholder="비밀번호" class="login-text">
				<input type="submit" value="다음" class="bt">
			</div>
		</form>
	</div>
	<%@ include file="/footer.jsp"%>
	</div>
</body>
</html>