<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.chart.*" %>    
<%@ page import="java.util.*" %>    
<jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<%
String search = request.getParameter("search");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="/header.jsp" %>
<h1>"<%=search %>" 검색결과</h1>
<section>
	<article>
		<ul>
			<li>전체
			<li><a href="/semi2/search/searchSong.jsp?search=<%=search%>">곡</a>
			<li><a href="/semi2/search/searchAlbum.jsp?search=<%=search%>">앨범</a>
			<li><a href="/semi2/search/searchArtist.jsp?search=<%=search%>">아티스트</a>
			<li><a href="/semi2/search/searchPlaylist.jsp?search=<%=search%>">플레이리스트</a>
		</ul>
	</article>
	<article>
		<h2>플레이리스트 &gt;</h2>
		<div>
			<div>
			<img src="/semi2/resources/images/album//cover.jpg">
			<a>플레이리스트 이름</a>
			<a>만든사람</a>
			<label>몇곡</label>
			</div>
			<div>
			<img src="/semi2/resources/images/album//cover.jpg">
			<a>플레이리스트 이름</a>
			<a>만든사람</a>
			<label>몇곡</label>
			</div>
			<div>
			<img src="/semi2/resources/images/album//cover.jpg">
			<a>플레이리스트 이름</a>
			<a>만든사람</a>
			<label>몇곡</label>
			</div>
			<div>
			<img src="/semi2/resources/images/album//cover.jpg">
			<a>플레이리스트 이름</a>
			<a>만든사람</a>
			<label>몇곡</label>
			</div>
			<div>
			<img src="/semi2/resources/images/album//cover.jpg">
			<a>플레이리스트 이름</a>
			<a>만든사람</a>
			<label>몇곡</label>
			</div>
			<div>
			<img src="/semi2/resources/images/album//cover.jpg">
			<a>플레이리스트 이름</a>
			<a>만든사람</a>
			<label>몇곡</label>
			</div>
		</div>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>