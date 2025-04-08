<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.search.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="searchDao" class="com.plick.search.SearchDao"></jsp:useBean>
<%
String search = request.getParameter("search");

//아래 id는 앨범디테일의 수록곡 관련 코드를 가져와서 임시로 복붙한 코드임.. 
//검색결과에 따라 결과 보이도록 새로운 dao 작성 필요 + 검색한 단어를 파라미터로 받아야 함  
String id_s = request.getParameter("albumid");
if (id_s == null || id_s.equals("")) {
	id_s = "0";
}
int id = Integer.parseInt(id_s);
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
		<h2><a href="/semi2/search/searchAlbum.jsp?search=<%=search%>">앨범 &gt;</a></h2>
		<%
			int searchCount = 10;
			ArrayList<SearchAlbumDto> albumArr = searchDao.searchAlbums(search, searchCount);
			%>
			<div>
				<%
				if (albumArr == null || albumArr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < albumArr.size(); i++) {
				%>
				<div>
					<img
						src="/semi2/resources/images/album/<%=albumArr.get(i).getAlbumId()%>/cover.jpg">
					<a><%=albumArr.get(i).getName()%></a> <a><%=albumArr.get(i).getNickname()%></a>
					<a><%=albumArr.get(i).getGenre1()%></a> <a><%=albumArr.get(i).getGenre2()%></a>
					<a><%=albumArr.get(i).getGenre3()%></a> <label><%=albumArr.get(i).getReleasedAt()%></label>
					<img>추가이미지 <img>재생이미지
				</div>
				<%
				}
				}
				%>
			</div>
	</article>
	<article>
		<h2 class="categorey-name"><a href="/semi2/search/searchSong.jsp?search=<%=search%>">곡 &gt;</a></h2>
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
						<td colspan="6">수록곡이 존재하지 않습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < songArr.size(); i++) {
					%>
					<tr class="song-list-body">
						
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
		<h2><a href="/semi2/search/searchPlaylist.jsp?search=<%=search%>">플레이리스트 &gt;</a></h2>
		<%
			searchCount = 10;
			ArrayList<SearchPlaylistDto> playlsitArr = searchDao.searchPlaylists(search, searchCount);
			%>
			<div>
				<%
				if (playlsitArr == null || playlsitArr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < playlsitArr.size(); i++) {
				%>

				<div>
					<img src="/semi2/resources/images/album/<%=playlsitArr.get(i).getFirstAlbumId() %>/cover.jpg"> 
					<a><%=playlsitArr.get(i).getPlaylistName() %></a>
					<a><%=playlsitArr.get(i).getNickname() %></a>
					<label>(<%=playlsitArr.get(i).getSongCount() %>)</label>
				</div>
				<%
				}
				}
				%>
			</div>
	</article>
	<article>
		<h2><a href="/semi2/search/searchArtist.jsp?search=<%=search%>">아티스트 &gt;</a></h2>
		<%
			searchCount = 10;
			ArrayList<SearchArtistDto> aritstArr = searchDao.searchAritists(search, searchCount);
			%>
			<div>
				<%
				if (aritstArr == null || aritstArr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < aritstArr.size(); i++) {
				%>
				<div>
					<div>
						<img src="/semi2/resources/images/member/<%=aritstArr.get(i).getMemberId()%>/profile.jpg">
						<a><%=aritstArr.get(i).getNickname()%></a>

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