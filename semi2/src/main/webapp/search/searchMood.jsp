<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.search.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="searchDao" class="com.plick.search.SearchDao"></jsp:useBean>
<%
String moodSearch = request.getParameter("mood");
String currentPage_str = request.getParameter("page");
if(currentPage_str==null||currentPage_str.equals("")){
	currentPage_str="1";
}
int currentPage = Integer.parseInt(currentPage_str);

int totalResults = searchDao.showPlaylistCounts(moodSearch);

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
	<div class="subtitle"><h2>"<%=moodSearch %>" 검색결과</h2></div>
	<section>
		<article>
			<h2>플레이리스트 &gt;</h2>
			<%
			int searchCount = pageSize;
			ArrayList<SearchMoodDto> arr = searchDao.searchMood(moodSearch,currentPage,  searchCount);
			%>
			
			<div class="gallery">
				<%
				if (arr == null || arr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < arr.size(); i++) {
				%>
				<div class="gallery-card">
					<div class="gallery-card-album-image-group">
				<a href="/semi2/playlist/details.jsp?playlistid=<%=arr.get(i).getPlaylistId()%>">
				<img src="/semi2/resources/images/album/<%=arr.get(i).getFirstAlbumId() %>/cover.jpg" class="gallery-card-album-image" onerror="this.src='/semi2/resources/images/playlist/default-cover.jpg';"> 
				</a>
				<div class="gallery-card-album-image-play">
				<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?playlistid=<%=arr.get(i).getPlaylistId()%>'); return false;"> 

					<img src="/semi2/resources/images/design/album-play.png" class="play-default">
					<img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
				</a>
				</div>
				</div>
				<div class="gallery-card-playlist-name">
				<label><a href="/semi2/playlist/details.jsp?playlistid=<%=arr.get(i).getPlaylistId()%>"><%=arr.get(i).getPlaylistName() %></a></label>
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
				<a href="/semi2/search/searchMood.jsp?mood=<%=moodSearch %>&page=<%=(currentGroup - 1) * 5%>"><%=lt%></a>
				</div>
				<%
				int startPageNum = (currentGroup - 1) * 5 + 1;
				int endPageNum = currentGroup == pageGroupCount ? totalPage : (currentGroup - 1) * 5 + 5;
				for (int i = startPageNum; i <= endPageNum; i++) {
				%>
				<div class="<%=currentPage==i?"page-number-bold":"page-number" %>">
					<a href="/semi2/search/searchMood.jsp?mood=<%=moodSearch %>&page=<%=i%>"><%=i%></a>
				</div>
				<%
				}
				%>
				<div class="right-page">
				<a href="/semi2/search/searchMood.jsp?mood=<%=moodSearch %>&page=<%=currentGroup * 5 + 1%>"><%=gt%></a>
				</div>
			</div>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
	</div>
</body>
</html>