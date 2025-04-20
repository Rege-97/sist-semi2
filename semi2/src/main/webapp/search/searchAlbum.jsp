<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.search.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="searchDao" class="com.plick.search.SearchDao"></jsp:useBean>
<%
String search = request.getParameter("search");
String currentPage_str = request.getParameter("page");
if (currentPage_str == null || currentPage_str.equals("")) {
	currentPage_str = "1";
}
int currentPage = Integer.parseInt(currentPage_str);
int totalResults = searchDao.showTotalResults("albums", "name", search);
int pageSize = 6;
int totalPage = (totalResults - 1) / pageSize + 1;
int pageGroupSize = 5;
int pageGroupCount = (totalPage - 1) / pageGroupSize + 1;
int currentGroup = (currentPage - 1) / pageGroupSize + 1;
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
		<iframe name="hiddenFrame" style="display: none;"></iframe>
			<div class="submenu-box">
		<input type="button" value="전체" class="bt" onclick="location.href='/semi2/search/main.jsp?search=<%=search%>'">
		<input type="button" value="곡" class="bt" onclick="location.href='/semi2/search/searchSong.jsp?search=<%=search%>'">
		<input type="button" value="앨범" class="bt_clicked" onclick="location.href='/semi2/search/searchAlbum.jsp?search=<%=search%>'">
		<input type="button" value="아티스트" class="bt" onclick="location.href='/semi2/search/searchArtist.jsp?search=<%=search%>'">
		<input type="button" value="플레이리스트" class="bt" onclick="location.href='/semi2/search/searchPlaylist.jsp?search=<%=search%>'">
	</div>

		</article>
		<article>
			<div class="footer-line"></div>
			<div class="search-title">앨범 검색결과</div>
			<%
			int searchCount = pageSize;
			ArrayList<SearchAlbumDto> albumArr = searchDao.searchAlbums(search, currentPage, searchCount);
			%>
			<div class="search-gallery">
				<%
				if (albumArr == null || albumArr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < albumArr.size(); i++) {
					String genres[] = { albumArr.get(i).getGenre1(), albumArr.get(i).getGenre2(), albumArr.get(i).getGenre3() };
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
					<a
						href="/semi2/chart/album-details.jsp?albumid=<%=albumArr.get(i).getAlbumId()%>">
						<img
						src="/semi2/resources/images/album/<%=albumArr.get(i).getAlbumId()%>/cover.jpg"
						class="search-card-image" onerror="this.src='/semi2/resources/images/playlist/default-cover.jpg';">
					</a>
					<div class="search-card-info">
						<div class="search-card-info-name">
							<a
								href="/semi2/chart/album-details.jsp?albumid=<%=albumArr.get(i).getAlbumId()%>">
								<h2><%=albumArr.get(i).getName()%></h2>
							</a>
						</div>
						<div class="search-card-info-artist-name">
							<a
								href="/semi2/artist/main.jsp?memberid=<%=albumArr.get(i).getMemberId()%>"><%=albumArr.get(i).getNickname()%></a>
						</div>
            
            <div class="search-card-info-genre"><%=genre%></div>
						<div class="search-card-info-date">
							<%=releasedAt%>
						</div>
						<div class="detail-card-info-icon">
							<div class="icon-group">
								<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?albumid=<%=albumArr.get(i).getAlbumId()%>'); return false;"> <img
									src="/semi2/resources/images/design/play-icon.png"
									class="icon-dafault"> <img
									src="/semi2/resources/images/design/play-icon-hover.png"
									class="icon-hover">
								</a>
							</div>
							<div class="icon-group">
								<a href="#" onclick="openModal('albumid',<%=albumArr.get(i).getAlbumId()%>); return false;"> <img
									src="/semi2/resources/images/design/add-list-icon.png"
									class="icon-dafault"> <img
									src="/semi2/resources/images/design/add-list-icon-hover.png"
									class="icon-hover">
								</a>
							</div>

						<div class="icon-group">
							<a href="/semi2/chart/download-album.jsp?albumid=<%=albumArr.get(i).getAlbumId()%>" target="hiddenFrame">
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
			<div class="paging">
				<%
				String lt = currentGroup == 1 ? "" : "&lt;&lt;";
				%>
				<%
				String gt = currentGroup == pageGroupCount ? "" : "&gt;&gt;";
				%>
				<div class="left-page">
				<a href="/semi2/search/searchAlbum.jsp?search=<%=search %>&page=<%=(currentGroup - 1) * 5%>"><%=lt%></a>
				</div>
				<%
				int startPageNum = (currentGroup - 1) * 5 + 1;
				int endPageNum = currentGroup == pageGroupCount ? totalPage : (currentGroup - 1) * 5 + 5;
				for (int i = startPageNum; i <= endPageNum; i++) {
				%>
				<div class="<%=currentPage==i?"page-number-bold":"page-number" %>">
				<a href="/semi2/search/searchAlbum.jsp?search=<%=search %>&page=<%=i%>"><%=i%></a>
				</div>
				<%
				}
				%>
				<div class="right-page">
				<a href="/semi2/search/searchAlbum.jsp?search=<%=search %>&page=<%=currentGroup * 5 + 1%>"><%=gt%></a>
				</div>
			</div>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>