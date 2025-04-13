<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@ page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp"%>
	<%@ include file="/mypage/mypage-header.jsp"%>
<h2>앨범등록</h2>
<iframe src = "album-form.jsp"></iframe>
<%@ include file="/footer.jsp" %>
</body>
</html>