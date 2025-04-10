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
<body>
	<%@include file="/header.jsp"%>
	<h1>
		"<%=moodSearch %>" 검색결과
	</h1>
	<section>
		<article>
			<ul>
				<li>전체
				<li><a href="/semi2/search/searchSong.jsp?search=<%=moodSearch%>">곡</a>
				<li><a href="/semi2/search/searchAlbum.jsp?search=<%=moodSearch%>">앨범</a>
				<li><a href="/semi2/search/searchArtist.jsp?search=<%=moodSearch%>">아티스트</a>
				<li><a
					href="/semi2/search/searchPlaylist.jsp?search=<%=moodSearch%>">플레이리스트</a>
			</ul>
		</article>
		<article>
			<h2>플레이리스트 &gt;</h2>
			<%
			int searchCount = 10;
			ArrayList<SearchMoodDto> arr = searchDao.searchMood(moodSearch,currentPage,  searchCount);
			%>
			<div>
				<%
				if (arr == null || arr.size() == 0) {
				%>
				<div>보여줄 정보가 없습니다</div>
				<%
				} else {
				for (int i = 0; i < arr.size(); i++) {
				%>

				<div>
					<img src="/semi2/resources/images/album/<%=arr.get(i).getFirstAlbumId() %>/cover.jpg"> 
					<a><%=arr.get(i).getPlaylistName() %></a>
					<a><%=arr.get(i).getNickname() %></a>
					<label>(<%=arr.get(i).getSongCount() %>)</label>
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