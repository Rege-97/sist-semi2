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
int totalResults = searchDao.showTotalResults("members", "nickname", search);
int pageSize = 6;
int totalPage = (totalResults-1)/pageSize+1;
int pageGroupSize = 5;
int pageGroupCount = (totalPage-1)/pageGroupSize+1;
int currentGroup = (currentPage-1)/pageGroupSize+1;
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
				<div class="submenu-box">
		<input type="button" value="전체" class="bt" onclick="location.href='/semi2/search/main.jsp?search=<%=search%>'">
		<input type="button" value="곡" class="bt" onclick="location.href='/semi2/search/searchSong.jsp?search=<%=search%>'">
		<input type="button" value="앨범" class="bt" onclick="location.href='/semi2/search/searchAlbum.jsp?search=<%=search%>'">
		<input type="button" value="아티스트" class="bt_clicked" onclick="location.href='/semi2/search/searchArtist.jsp?search=<%=search%>'">
		<input type="button" value="플레이리스트" class="bt" onclick="location.href='/semi2/search/searchPlaylist.jsp?search=<%=search%>'">
	</div>
		</article>
<article>
		<div class="footer-line"></div>
	<div class="search-title">
		아티스트 검색결과
		</div>
		<%
			int searchCount = pageSize;
			ArrayList<SearchArtistDto> aritstArr = searchDao.searchAritists(search,currentPage, searchCount);
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
			<div class="paging">
				<%
				String lt = currentGroup == 1 ? "" : "&lt;&lt;";
				%>
				<%
				String gt = currentGroup == pageGroupCount ? "" : "&gt;&gt;";
				%>
				<div class="left-page">
				<a href="/semi2/search/searchArtist.jsp?search=<%=search %>&page=<%=(currentGroup - 1) * 5%>"><%=lt%></a>
				</div>
				<%
				int startPageNum = (currentGroup - 1) * 5 + 1;
				int endPageNum = currentGroup == pageGroupCount ? totalPage : (currentGroup - 1) * 5 + 5;
				for (int i = startPageNum; i <= endPageNum; i++) {
				%>
				<div class="<%=currentPage==i?"page-number-bold":"page-number" %>">
				<a href="/semi2/search/searchArtist.jsp?search=<%=search %>&page=<%=i%>"><%=i%></a>
				</div>
				<%
				}
				%>
				<div class="right-page">
				<a href="/semi2/search/searchArtist.jsp?search=<%=search %>&page=<%=currentGroup * 5 + 1%>"><%=gt%></a>
				</div>
			</div>
	</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>