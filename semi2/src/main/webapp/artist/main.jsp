<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "/header.jsp"%>
<img name = "artistprofile">
<h1>아티스트명</h1>
<lebel>월간 리스너</lebel>
<h2>인기</h2>
<table>
	<tr>
		<td>순위</td>
		<td><img name = "albumart"></td>
		<td>곡명</td>
		<td>재생 수</td>
		<td>바로듣기</td>
	</tr>
</table>
<h2>아티스트 픽</h2>
<table>
	<tr>
		<td><img name = "albumart"></td>
		<td>
		<label>앨범명</label>
		<label>인기감상평</label>
		</td>
	</tr>
</table>
<h2>이 아티스트의 최신 앨범</h2>
<table>
	<tr>
		<td><img name = "albumart"></td>
		<td>앨범명</td>
		<td>발매년도</td>
	</tr>
</table>
<h2>아티스트 소개</h2>
<img name = "artistprofilemain">
<label>누적리스너: 0명</label>
소개 문구
<%@ include file = "/footer.jsp"%>
</body>
</html>