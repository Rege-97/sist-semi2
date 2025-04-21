<%@page import="com.plick.playlist.PlaylistPreviewDto"%>
<%@page import="java.util.List"%>
<%@page import="com.plick.playlist.mylist.PlaylistMylistDao"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
<script>
	function showAlertAndGoLoginPage(message) {
		window.alert(message);
		window.location.href = "/semi2/member/signin.jsp";
	}
	function confirmAction(message) {
		return confirm(message);
	}
</script>
</head>
<%
SignedinDto loggedinUser = (SignedinDto) session.getAttribute("signedinDto");

if (loggedinUser == null || loggedinUser.getMemberId() == 0) {
%>
<script>
	showAlertAndGoLoginPage("로그인이 필요합니다");
</script>
<%
return;
}
int loggedinUserId = loggedinUser.getMemberId();
PlaylistMylistDao playlistMylistDao = new PlaylistMylistDao();
List<PlaylistPreviewDto> likedPlaylists = playlistMylistDao
		.findLikedPlaylistsOrderByLikesCreatedAtByMemberId(loggedinUserId);
%>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@include file="/header.jsp"%>
	<div class="body-content">
	<br/>
	<input type="button" value="내 플레이리스트" class="bt"
		onclick="location.href='/semi2/playlist/mylist/main.jsp'">
		<input type="button" value="좋아요" class="bt_clicked"
		onclick="location.href='/semi2/playlist/mylist/liked_list.jsp'">
	<div class="categorey-name">
			<label>좋아요 한 플레이리스트</label>
		</div>
	
	<div class="gallery">
	<%
	// 플레이리스트 하나씩 나열
	for (PlaylistPreviewDto playlistPreview : likedPlaylists) {
	%>
	<div class="gallery-card">
	<div class="gallery-card-album-image-group">
		<a href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>"> <img src="/semi2/resources/images/<%=playlistPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg"
		: "album/" + playlistPreview.getFirstAlbumId() + "/cover.jpg"%>"  class="gallery-card-album-image">
		</a>
		<div class="gallery-card-album-image-play">
			<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>'); return false;"> 
				<img src="/semi2/resources/images/design/album-play.png" class="play-default">
				<img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
			</a>
		</div>
	</div>
		<div class ="gallery-card-album-name">
			<a href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>"><%=playlistPreview.getPlaylistName()%></a>
		</div>
		
	<div class="gallery-card-artist-name-myplaylist">
		<div><%=playlistPreview.getMemberNickname()%>
			|
			<%=playlistPreview.getSongCount()%>곡
		</div>
		<div>
			<a href="/semi2/playlist/mylist/delete_ok.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>" onclick="return confirmAction('정말 삭제하시겠습니까?');">
			<div class="myplaylist-icon-group">
			<img src="/semi2/resources/images/design/playlist-delete.png" class="playlist-delete">
			<img src="/semi2/resources/images/design/playlist-delete-hover.png" class="playlist-delete-hover">
			</div>
			</a>
		</div>
	</div>
	</div>
	<%
	}
	%>
</div>
	<%@include file="/footer.jsp"%>
</div>
</body>
</html>