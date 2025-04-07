<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.root.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="rdao" class="com.plick.root.RootDao"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/header.jsp"%>
	<!-- 배너 -->
	<section>
		<article>
			<a>&lt;&lt;</a> <img>배너이미지 <a>&gt;&gt;</a>
		</article>
	</section>
	<!-- 첫 번째 메뉴 + 컨텐츠 -->
	<section>
		<article>
			<label> 최신발매앨범 </label>
			<ul>
				<%
			ArrayList<RecentAlbumDto> recentAlbumArr = new ArrayList<RecentAlbumDto>();
				recentAlbumArr = rdao.showRecentAlbums();
			if(recentAlbumArr==null){
				%>
				<li>불러올 정보가 없습니다. <%
			}else{
				
				for (int i=0;i<recentAlbumArr.size();i++){
					%>
				<li><a
					href="/semi2/chart/album-details.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>">
						<img
						src="/semi2/resources/images/album/<%=recentAlbumArr.get(i).getAlbumId()%>/cover.jpg">
				</a> <label><a
						href="/semi2/chart/album-details.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>"><%=recentAlbumArr.get(i).getAlbumName() %></a></label>
					<label><a
						href="/semi2/artist/main.jsp?memberid=<%=recentAlbumArr.get(i).getMemberId()%>"><%=recentAlbumArr.get(i).getMemberNickname() %></a></label>
					<%
					
				}
			}
			%>
			</ul>
		</article>
		<article>
			<label> 인기음악 </label>
			<ul>
				<%
				ArrayList<PopularSongDto> arrPopularSong = new ArrayList<PopularSongDto>();
				arrPopularSong = rdao.showPopularSongs();
			if(arrPopularSong==null){
				%>
				<li>불러올 정보가 없습니다. <%
			}else{
				
				for (int i=0;i<arrPopularSong.size();i++){
					%>
				<li><a
					href="/semi2/chart/album-details.jsp?albumid=<%=arrPopularSong.get(i).getAlbumId()%>">
						<img
						src="/semi2/resources/images/album/<%=arrPopularSong.get(i).getAlbumId()%>/cover.jpg">
				</a> <label><a
						href="/semi2/chart/song-details.jsp?songid=<%=arrPopularSong.get(i).getSongId()%>"><%=arrPopularSong.get(i).getSongName() %></a></label>
					<label><a
						href="/semi2/artist/main.jsp?memberid=<%=arrPopularSong.get(i).getMemberId() %>"><%=arrPopularSong.get(i).getMemberNickname() %></a></label>
			</ul>
			<%} %>
			<%} %>
		</article>
		<article>
			<labe l> 인기 플레이리스트 </label>
			<ul>
				<%
				ArrayList<PopularPlaylistDto> arrPopularPlaylist = new ArrayList<PopularPlaylistDto>();
				arrPopularPlaylist = rdao.showPopularPlaylists();
			if(arrPopularPlaylist==null){
				%>
				<li>불러올 정보가 없습니다. <%
			}else{
				
				for (int i=0;i<arrPopularPlaylist.size();i++){
					%>
				<li><a
					href="/semi2/playlist/details.jsp?playlistid=<%=arrPopularPlaylist.get(i).getPlaylistId()%>">
						<img
						src="/semi2/resources/images/playlist/<%=arrPopularPlaylist.get(i).getPlaylistId()%>/cover.jpg">
				</a> <label><a
						href="/semi2/playlist/details.jsp?playlistid=<%=arrPopularPlaylist.get(i).getPlaylistId()%>"><%=arrPopularPlaylist.get(i).getPlaylistName() %></a></label>
					<%
					
				}
			}
			%>
			</ul>
		</article>
		<article>
			<label> 분위기에 따른 플레이리스트 </label>
			<ul>
				<li><a href="#"><img>신나는</a>
				<li><a href="#"><img>잔잔한</a>
				<li><a href="#"><img>감성적인</a>
				<li><a href="#"><img>슬플 때</a>
				<li><a href="#"><img>달달한</a>
				<li><a href="#"><img>상쾌한</a>
				<li><a href="#"><img>몽환적인</a>
			</ul>
		</article>
		<article>
			<label> 장르 콜렉션 </label>
			<ul>
				<li><a href="#"><img>1번 장르</a>
				<li><a href="#"><img>2번 장르</a>
				<li><a href="#"><img>3번 장르</a>
				<li><a href="#"><img>4번 장르</a>
				<li><a href="#"><img>5번 장르</a>
				<li><a href="#"><img>6번 장르</a>
				<li><a href="#"><img>7번 장르</a>
				<li><a href="#"><img>8번 장르</a>
				<li><a href="#"><img>9번 장르</a>
				<li><a href="#"><img>10번 장르</a>
			</ul>
		</article>
	</section>
	<%@ include file="/footer.jsp"%>
</body>
</html>