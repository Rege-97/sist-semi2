<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<ul>
			<li><a href="#">전체차트</a></li>
			<li><a href="#">발라드</a></li>
			<li><a href="#">알앤비</a></li>
			<li><a href="#">힙합</a></li>
			<li><a href="#">아이돌</a></li>
			<li><a href="#">재즈</a></li>
			<li><a href="#">팝</a></li>
			<li><a href="#">클래식</a></li>
			<li><a href="#">댄스</a></li>
			<li><a href="#">인디</a></li>
			<li><a href="#">락</a></li>
		</ul>
	</article>
	<article>
		<label>인기 차트</label>
		<table>
			<tr>
			<td><label>순위</label>
			<td><a href="/semi2/chart/album-details.jsp"><img>앨범아트</a>
			<td><a href="/semi2/chart/song-details.jsp">제목</a>
			<a href="/semi2/chart/album-details.jsp">앨범명</a>
			<td><label>아티스트</label>
			<td><img>+
			<td><img>재생
			<td><img>다운로드
			<tr>
			<td><label>순위</label>
			<td><a href="/semi2/chart/album-details.jsp"><img>앨범아트</a>
			<td><a href="/semi2/chart/song-details.jsp">제목</a>
			<a href="/semi2/chart/album-details.jsp">앨범명</a>
			<td><label>아티스트</label>
			<td><img>+
			<td><img>재생
			<td><img>다운로드
		</table>
	</article>
</section>


<%@include file="/footer.jsp" %>
</body>
</html>