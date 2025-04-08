<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.search.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="searchDao" class="com.plick.search.SearchDao"></jsp:useBean>
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
	<%@include file="/header.jsp"%>
	<h1>
		"<%=search%>" 검색결과
	</h1>
	<section>
		<article>
			<ul>
				<li>전체
				<li><a href="/semi2/search/searchSong.jsp?search=<%=search%>">곡</a>
				<li><a href="/semi2/search/searchAlbum.jsp?search=<%=search%>">앨범</a>
				<li><a href="/semi2/search/searchArtist.jsp?search=<%=search%>">아티스트</a>
				<li><a
					href="/semi2/search/searchPlaylist.jsp?search=<%=search%>">플레이리스트</a>
			</ul>
		</article>
		<article>
			<h2>아티스트 &gt;</h2>
			<%
			int searchCount = 10;
			ArrayList<SearchArtistDto> arr = searchDao.searchAritists(search, searchCount);
			%>
			<div>
				<%
				if (arr == null || arr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < arr.size(); i++) {
				%>
				<div>
					<div>
						<img src="/semi2/resources/images/member/<%=arr.get(i).getMemberId()%>/profile.jpg">
						<a><%=arr.get(i).getNickname()%></a>

					</div>
					<%
					}
					}
					%>

				</div>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>