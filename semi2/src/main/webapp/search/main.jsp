<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.search.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<h2>"<%=search %>" 검색결과</h2>
<section>
	<article>
	<div>
		<input type="button" value="전체" class="bt_clicked" onclick="location.href='/semi2/search/main.jsp?search=<%=search%>'">
		<input type="button" value="곡" class="bt" onclick="location.href='/semi2/search/searchSong.jsp?search=<%=search%>'">
		<input type="button" value="앨범" class="bt" onclick="location.href='/semi2/search/searchAlbum.jsp?search=<%=search%>'">
		<input type="button" value="아티스트" class="bt" onclick="location.href='/semi2/search/searchArtist.jsp?search=<%=search%>'">
		<input type="button" value="플레이리스트" class="bt" onclick="location.href='/semi2/search/searchPlaylist.jsp?search=<%=search%>'">
	</div>

	</article>
	<article>
	<div class="footer-line"></div>
	<div class="search-title">
		<a href="/semi2/search/searchAlbum.jsp?search=<%=search%>">앨범 &gt;</a>
		</div>
		<%
			int searchCount = 6;
			ArrayList<SearchAlbumDto> albumArr = searchDao.searchAlbums(search, searchCount);
			%>
			<div class="search-gallery">
				<%
				if (albumArr == null || albumArr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < albumArr.size(); i++) {
					String genres[] = {albumArr.get(i).getGenre1(), albumArr.get(i).getGenre2(), albumArr.get(i).getGenre3()};
					StringBuffer genre = new StringBuffer();

					for (int j = 0; j < 3; j++) {
						if (genres[j] != null) {
							if (!genres[j].equals("")) {
						if (j == 0) {
							genre.append(genres[j]);
						} else {
							genre.append(" | " + genres[j]);
						}
							}
						}
					}

					SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
					String releasedAt = sdf.format(albumArr.get(i).getReleasedAt());
		
				%>
				<div class="search-card">
				<a href="/semi2/chart/album-details.jsp?albumid=<%=albumArr.get(i).getAlbumId()%>">
				<img src="/semi2/resources/images/album/<%=albumArr.get(i).getAlbumId()%>/cover.jpg" class="search-card-image">
				</a>
				<div class="search-card-info">
					<div class="search-card-info-name">
					<a href="/semi2/chart/album-details.jsp?albumid=<%=albumArr.get(i).getAlbumId()%>">
						<h2><%=albumArr.get(i).getName()%></h2>
						</a>
					</div>
					<div class="search-card-info-artist-name">
						<a href="/semi2/artist/main.jsp?memberid=<%=albumArr.get(i).getMemberId()%>"><%=albumArr.get(i).getNickname()%></a>
					</div>
					<div class="search-card-info-genre"><%=genre%></div>
					<div class="search-card-info-date">
						<%=releasedAt%>
					</div>
					<div class="detail-card-info-icon">
						<div class="icon-group">
							<a href="#">
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
							</a>
						</div>
						<div class="icon-group">
							<a href="#">
								<img src="/semi2/resources/images/design/add-list-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/add-list-icon-hover.png" class="icon-hover">						
							</a>
						</div>
						<div class="icon-group">
							<a href="#">
								<img src="/semi2/resources/images/design/download-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/download-icon-hover.png" class="icon-hover">
							</a>
						</div>
					</div>
				</div>
			</div>
		
				<%
				}
				}
				%>
			</div>
	</article>
	<article>
	<div class="footer-line"></div>
		<div class="search-title">
		<a href="/semi2/search/searchSong.jsp?search=<%=search%>">곡 &gt;</a>
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
					searchCount = 10;
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
								<a href="#">
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
	<article>
	<div class="footer-line"></div>
	<div class="search-title">
		<a href="/semi2/search/searchPlaylist.jsp?search=<%=search%>">플레이리스트 &gt;</a>
		</div>
		<%
			searchCount = 10;
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
	<article>
		<div class="footer-line"></div>
	<div class="search-title">
		<a href="/semi2/search/searchArtist.jsp?search=<%=search%>">아티스트 &gt;</a>
		</div>
		<%
			searchCount = 6;
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
<%@include file="/footer.jsp" %>
</body>
</html>