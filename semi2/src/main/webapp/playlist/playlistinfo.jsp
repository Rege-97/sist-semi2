<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page = "/header.jsp"></jsp:include>
<table>
	<thead>
	<tr>
		<td>수록곡</td>
	</tr>
	</thead>
	<tr>
		<td><img src = "../img/mincat.png" width="120px" height="120px"></td>
		<td><label>제목</label><label>앨범명</label></td>
		<td>아티스트</td>
		<td>재생목록에 추가</td>
		<td>바로듣기</td>
		<td>다운로드</td>
	</tr>
</table>

<h2>플리 소개</h2>
앨범 소개글

<jsp:include page = "comentplus.jsp"></jsp:include>
<jsp:include page = "playlistcoment.jsp"></jsp:include>
<br>
<jsp:include page = "/footer.jsp"></jsp:include>
</body>
</html>