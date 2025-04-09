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
<div class="subtitle"><h2>"<%=search %>" 검색결과</h2></div>
	<section>
		<article>
				<div class="submenu-box">
		<input type="button" value="전체" class="bt" onclick="location.href='/semi2/search/main.jsp?search=<%=search%>'">
		<input type="button" value="곡" class="bt" onclick="location.href='/semi2/search/searchSong.jsp?search=<%=search%>'">
		<input type="button" value="앨범" class="bt" onclick="location.href='/semi2/search/searchAlbum.jsp?search=<%=search%>'">
		<input type="button" value="아티스트" class="bt" onclick="location.href='/semi2/search/searchArtist.jsp?search=<%=search%>'">
		<input type="button" value="플레이리스트" class="bt_clicked" onclick="location.href='/semi2/search/searchPlaylist.jsp?search=<%=search%>'">
	</div>
		</article>
		<article>
	<div class="footer-line"></div>
	<div class="search-title">
		<a href="/semi2/search/searchPlaylist.jsp?search=<%=search%>">플레이리스트 &gt;</a>
		</div>
		<%
			int searchCount = 10;
			ArrayList<SearchPlaylistDto> playlsitArr = searchDao.searchPlaylists(search, searchCount);
			%>
			<div class="gallery">
				<%
				if (playlsitArr == null || playlsitArr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < playlsitArr.size(); i++) {
				%>
				<div class="gallery-card">
					<div class="gallery-card-album-image-group">
				<a href="/semi2/playlist/details.jsp?playlistid=<%=playlsitArr.get(i).getPlaylistId()%>">
						<!-- <img src="/semi2/resources/images/playlist/<%=playlsitArr.get(i).getPlaylistId()%>/cover.jpg" class="gallery-card-album-image"> -->
				<img src="/semi2/resources/images/album/1/cover.jpg" class="gallery-card-album-image">
				</a>
				<div class="gallery-card-album-image-play">
				<a href="#">
					<img src="/semi2/resources/images/design/album-play.png" class="play-default">
					<img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
				</a>
				</div>
				</div>
				<div class="gallery-card-playlist-name">
				<label><a href="/semi2/playlist/details.jsp?playlistid=<%=playlsitArr.get(i).getPlaylistId()%>"><%=playlsitArr.get(i).getPlaylistName() %></a></label>
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