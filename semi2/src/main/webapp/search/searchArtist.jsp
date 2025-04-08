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
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@include file="/header.jsp"%>
<h2>"<%=search %>" 검색결과</h2>
	<section>
		<article>
				<div>
		<input type="button" value="전체" class="bt" onclick="location.href='/semi2/search/main.jsp?search=<%=search%>'">
		<input type="button" value="곡" class="bt" onclick="location.href='/semi2/search/searchSong.jsp?search=<%=search%>'">
		<input type="button" value="앨범" class="bt" onclick="location.href='/semi2/search/searchAlbum.jsp?search=<%=search%>'">
		<input type="button" value="아티스트" class="bt_clicked" onclick="location.href='/semi2/search/searchArtist.jsp?search=<%=search%>'">
		<input type="button" value="플레이리스트" class="bt" onclick="location.href='/semi2/search/searchPlaylist.jsp?search=<%=search%>'">
	</div>
		</article>
<article>
		<div class="footer-line"></div>
	<div class="search-title">
		아티스트 검색결과
		</div>
		<%
			int searchCount = 6;
			ArrayList<SearchArtistDto> aritstArr = searchDao.searchAritists(search, searchCount);
			%>
			<div class="gallery">
				<%
				if (aritstArr == null || aritstArr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < aritstArr.size(); i++) {
				%>
				<div class="gallery-card">
				<a href="/semi2/artist/main.jsp?memberid=<%=aritstArr.get(i).getMemberId()%>">
						<img src="/semi2/resources/images/member/<%=aritstArr.get(i).getMemberId()%>/profile.jpg" class="artist-image"  onerror="this.src='/semi2/resources/images/member/default-profile.jpg';">
				</a>
				<div class="artist-name">
						<a href="/semi2/artist/main.jsp?memberid=<%=aritstArr.get(i).getMemberId()%>"><%=aritstArr.get(i).getNickname()%></a>
					</div>
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