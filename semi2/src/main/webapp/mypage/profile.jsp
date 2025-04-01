<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/header.jsp" %>
<h2>마이페이지</h2>
<label>이용권 정보:</label><img src = "">
<input type = "button" value = "이용권구매" onclick = "location.href = '/semi2/membership/main.jsp'">
<input type = "button" value = "이용권변경" onclick = "location.href = '/semi2/membership/main.jsp'">
<br>
<input type = "button" value = "비밀번호 변경" onclick = "location.href = '/semi2/member/find/password-reset.jsp'"> 
<input type = "button" value = "프로필 변경" onclick = "location.href = '/semi2/mypage/profile.jsp'"> 
<input type = "button" value = "앨범 등록" onclick = "location.href = '/semi2/mypage/album-management/main.jsp'"> 
<fieldset>
	<img src = "">
	<br>
	<input type = "text" name = "name" placeholder="닉네임">
	<input type = "text" name = "tel" placeholder="휴대폰번호">
	<input type = "button" value = "프로필 수정">
</fieldset>
<input type = "button" value = "아티스트 등록">
<%@ include file="/footer.jsp" %>
</body>
</html>