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
<%@include file="/header.jsp" %>
<div class="subtitle"><h2>"<%=search %>" 검색결과</h2></div>
<section>
	<article>
	<iframe name="hiddenFrame" style="display: none;"></iframe>
	<div class="submenu-box">
		<input type="button" value="전체" class="bt" onclick="location.href='/semi2/search/main.jsp?search=<%=search%>'">
		<input type="button" value="곡" class="bt_clicked" onclick="location.href='/semi2/search/searchSong.jsp?search=<%=search%>'">
		<input type="button" value="앨범" class="bt" onclick="location.href='/semi2/search/searchAlbum.jsp?search=<%=search%>'">
		<input type="button" value="아티스트" class="bt" onclick="location.href='/semi2/search/searchArtist.jsp?search=<%=search%>'">
		<input type="button" value="플레이리스트" class="bt" onclick="location.href='/semi2/search/searchPlaylist.jsp?search=<%=search%>'">
	</div>
	</article>
	
	<article>
	<div class="footer-line"></div>
		<div class="search-title">
		곡 검색결과
		</div>
			<table class="song-list">
				<colgroup>
					<col style="width: 40px;">
					<!-- 순위 -->
					<col style="width: 50px;">
					<!-- 앨범 이미지 -->
					<col style="width: 270px;">
					<!-- 곡/앨범 -->
					<col style="width: 120px;">
					<!-- 아티스트 -->
					<col style="width: 40px;">
					<!-- 듣기 -->
					<col style="width: 40px;">
					<!-- 리스트 -->
					<col style="width: 40px;">
					<!-- 다운로드 -->
				</colgroup>
				<thead>
					<tr class="song-list-head">
						<th>순번</th>
						<th colspan="2">곡/앨범</th>
						<th>아티스트</th>
						<th>듣기</th>
						<th>내 리스트</th>
						<th>다운로드</th>
					</tr>
				</thead>
				<tbody>
					<%
					int searchCount = 10;
					ArrayList<SearchSongDto> songArr = searchDao.searchSongs(search, searchCount);

					if (songArr == null || songArr.size() == 0) {
					%>
					<tr>
						<td colspan="6">보여줄 정보가 없습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < songArr.size(); i++) {
					%>
					<tr class="song-list-body">
					<td>
							<div class="song-list-row"><%=i+1 %></div>
						</td>
						
						<td>
							<div class="song-list-album-image">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=songArr.get(i).getAlbumId()%>"><img src="/semi2/resources/images/album/<%=songArr.get(i).getAlbumId()%>/cover.jpg" class="song-list-album-image"></a>
							</div>
						</td>
						<td>
							<div class="song-list-song-name">
								<a href="/semi2/chart/song-details.jsp?songid=<%=songArr.get(i).getSongId()%>"><%=songArr.get(i).getSongName()%></a>
							</div>
							<div class="song-list-album-name">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=songArr.get(i).getAlbumId()%>"><%=songArr.get(i).getAlbumName()%></a>
							</div>
						</td>
						<td>
							<div class="song-list-artist-name">
								<a href="/semi2/artist/main.jsp?memberid=<%=songArr.get(i).getMemberId()%>"><%=songArr.get(i).getNickname()%></a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#"> 
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#">
								<img src="/semi2/resources/images/design/add-list-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/add-list-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
									<a href="/semi2/chart/download-song.jsp?songid=<%=songArr.get(i).getSongId()%>&songname=<%=songArr.get(i).getSongName() %>&albumid=<%=songArr.get(i).getAlbumId()%>&artist=<%=songArr.get(i).getNickname()%>" target="hiddenFrame">
								<img src="/semi2/resources/images/design/download-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/download-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
					</tr>

					<%
					}

					}
					%>
				</tbody>
			</table>
	</article>
	
</section>
<%@include file="/footer.jsp" %>
</body>
</html>