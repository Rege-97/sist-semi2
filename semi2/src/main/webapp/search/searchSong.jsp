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
		<h2 class="categorey-name">곡 &gt;</h2>
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
					int searchCount = 10;
					ArrayList<SearchSongDto> arr = searchDao.searchSongs(search, searchCount);

					if (arr == null || arr.size() == 0) {
					%>
					<tr>
						<td colspan="6">수록곡이 존재하지 않습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < arr.size(); i++) {
					%>
					<tr class="song-list-body">
						
						<td>
							<div class="song-list-album-image">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(i).getAlbumId()%>"><img src="/semi2/resources/images/album/<%=arr.get(i).getAlbumId()%>/cover.jpg" class="song-list-album-image"></a>
							</div>
						</td>
						<td>
							<div class="song-list-song-name">
								<a href="/semi2/chart/song-details.jsp?songid=<%=arr.get(i).getSongId()%>"><%=arr.get(i).getSongName()%></a>
							</div>
							<div class="song-list-album-name">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(i).getAlbumId()%>"><%=arr.get(i).getAlbumName()%></a>
							</div>
						</td>
						<td>
							<div class="song-list-artist-name">
								<a href="/semi2/artist/main.jsp?memberid=<%=arr.get(i).getMemberId()%>"><%=arr.get(i).getNickname()%></a>
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
	
</section>
<%@include file="/footer.jsp" %>
</body>
</html>