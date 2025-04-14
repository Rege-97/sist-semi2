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
	<div class="subtitle"><h2>"<%=moodSearch %>" 검색결과</h2></div>
	<section>
		<article>
			<h2>플레이리스트 &gt;</h2>
			<%
			int searchCount = 50;
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
				<a href="#">
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
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>