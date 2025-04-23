<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.search.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="searchDao" class="com.plick.search.SearchDao"></jsp:useBean>
<%
String currentPage_str = request.getParameter("page");
if(currentPage_str==null||currentPage_str.equals("")){
	currentPage_str="1";
}
int currentPage = Integer.parseInt(currentPage_str);

int totalResults = searchDao.showTotalAlbumCounts();

int pageSize = 20;
int totalPage = (totalResults - 1) / pageSize + 1;
int pageGroupSize = 5;
int pageGroupCount = (totalPage - 1) / pageGroupSize + 1;
int currentGroup = (currentPage - 1) / pageGroupSize + 1;

%>
<%
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
	<%@include file="/header.jsp"%>
	<div class="body-content">
	<div class="subtitle"><h2>최신발매앨범</h2></div>
	<section>
		<article>
			<%
			int searchCount = pageSize;
			ArrayList<SearchAlbumDto> recentAlbumArr = searchDao.showRecentAlbums(currentPage,  searchCount);
			%>
			
			<div class="gallery">
				<%
				if (recentAlbumArr == null || recentAlbumArr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
					for (int i=0;i<recentAlbumArr.size();i++){
						%>
					<div class="gallery-card">
						<div class="gallery-card-album-image-group">
							<a href="/semi2/chart/album-details.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>"> <img src="/semi2/resources/images/album/<%=recentAlbumArr.get(i).getAlbumId()%>/cover.jpg" class="gallery-card-album-image"  onerror="this.src='/semi2/resources/images/playlist/default-cover.jpg';">
							</a>
							<div class="gallery-card-album-image-play">
								<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>'); return false;">
	 <img src="/semi2/resources/images/design/album-play.png" class="play-default"> <img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
								</a>
							</div>
						</div>
						<div class="gallery-card-album-name">
							<label><a href="/semi2/chart/album-details.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>"><%=recentAlbumArr.get(i).getName() %></a></label>
						</div>
						<div class="gallery-card-artist-name">
							<label><a href="/semi2/artist/main.jsp?memberid=<%=recentAlbumArr.get(i).getMemberId()%>"><%=recentAlbumArr.get(i).getNickname() %></a></label>
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
				<a href="/semi2/search/showRecentAlbums.jsp?page=<%=(currentGroup - 1) * 5%>"><%=lt%></a>
				</div>
				<%
				int startPageNum = (currentGroup - 1) * 5 + 1;
				int endPageNum = currentGroup == pageGroupCount ? totalPage : (currentGroup - 1) * 5 + 5;
				for (int i = startPageNum; i <= endPageNum; i++) {
				%>
				<div class="<%=currentPage==i?"page-number-bold":"page-number" %>">
					<a href="/semi2/search/showRecentAlbums.jsp?page=<%=i%>"><%=i%></a>
				</div>
				<%
				}
				%>
				<div class="right-page">
				<a href="/semi2/search/showRecentAlbums.jsp?page=<%=currentGroup * 5 + 1%>"><%=gt%></a>
				</div>
			</div>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
	</div>
</body>
</html>