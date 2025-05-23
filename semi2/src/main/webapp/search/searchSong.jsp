<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.search.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="searchDao" class="com.plick.search.SearchDao"></jsp:useBean>
<%
String search = request.getParameter("search");
String currentPage_str = request.getParameter("page");
if(currentPage_str==null||currentPage_str.equals("")){
	currentPage_str="1";
}
int currentPage = Integer.parseInt(currentPage_str);
int totalResults = searchDao.showTotalResults("songs", "name", search);
int pageSize = 10;
int totalPage = (totalResults-1)/pageSize+1;
int pageGroupSize = 5;
int pageGroupCount = (totalPage-1)/pageGroupSize+1;
int currentGroup = (currentPage-1)/pageGroupSize+1;

 

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@include file="/header.jsp" %>
<div class="body-content">
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
					int searchCount = pageSize;
					ArrayList<SearchSongDto> songArr = searchDao.searchSongs(search,currentPage,  searchCount);

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
							<div class="song-list-row"><%=(currentPage-1)*10+i+1 %></div>
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
								<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?songid=<%=songArr.get(i).getSongId()%>'); return false;">
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openModal('songid',<%=songArr.get(i).getSongId()%>); return false;">
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
			<div class="paging">
				<%
				String lt = currentGroup == 1 ? "" : "&lt;&lt;";
				%>
				<%
				String gt = currentGroup == pageGroupCount ? "" : "&gt;&gt;";
				%>
				<div class="left-page">
				<a href="/semi2/search/searchSong.jsp?search=<%=search %>&page=<%=(currentGroup - 1) * 5%>"><%=lt%></a>
				</div>
				<%
				int startPageNum = (currentGroup - 1) * 5 + 1;
				int endPageNum = currentGroup == pageGroupCount ? totalPage : (currentGroup - 1) * 5 + 5;
				for (int i = startPageNum; i <= endPageNum; i++) {
				%>
				<div class="<%=currentPage==i?"page-number-bold":"page-number" %>">
				<a href="/semi2/search/searchSong.jsp?search=<%=search %>&page=<%=i%>"><%=i%></a>
				</div>
				<%
				}
				%>
				<div class="right-page">
				<a href="/semi2/search/searchSong.jsp?search=<%=search %>&page=<%=currentGroup * 5 + 1%>"><%=gt%></a>
				</div>
			</div>
	</article>
	
</section>
<%@include file="/footer.jsp" %>
</div>
</body>
</html>