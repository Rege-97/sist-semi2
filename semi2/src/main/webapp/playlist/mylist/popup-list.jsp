<%@page import="com.plick.playlist.PlaylistPreviewDto"%>
<%@page import="java.util.List"%>
<%@page import="com.plick.playlist.mylist.PlaylistMylistDao"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function showAlertAndGoLoginPage(message) {
	window.alert(message);
	if (window.parent && typeof window.parent.closeModal === 'function') {
	  	window.parent.closeModal();
	}else{
		window.close();
	}
}
	function showAlertAndGoBack(message) {
		window.alert(message);
		window.history.back();
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
%>
<%
String songIdParam = request.getParameter("songid");
int songId = -1;
if (songIdParam == null || songIdParam.isEmpty()) {
%>
<script>
	showAlertAndGoBack("파라미터가 유효하지 않습니다.");
</script>
<%
return;
}

try {
songId = Integer.parseInt(songIdParam);
} catch (NumberFormatException e) {
%>
<script>
	showAlertAndGoBack("<%=e.getMessage()%>
	");
</script>
<%
}
%>
<%
int loggedinUserId = loggedinUser.getMemberId();
PlaylistMylistDao playlistMylistDao = new PlaylistMylistDao();
List<PlaylistPreviewDto> playlistPreviews = playlistMylistDao
		.findPlaylistPreviewsOrderByCreatedAtByMemberId(loggedinUserId);
%>
<body>
	<h1>내 플레이리스트</h1>
	<div>
		<a href="popup-list-form.jsp?songid=<%=songId%>"><img
			src="/semi2/resources/images/playlist/add-playlist.jpg" width="50" /></a>

		<a href="popup-list-form.jsp?songid=<%=songId%>">새로운 플레이리스트 만들기</a>
	</div>
	<%
	// 플레이리스트 하나씩 나열
	for (PlaylistPreviewDto playlistPreview : playlistPreviews) {
	%>
	<div>
		<a
			href="popup-add-song_ok.jsp?songid=<%=songId%>&playlistid=<%=playlistPreview.getPlaylistId()%>">
			<img
			src="/semi2/resources/images/<%=playlistPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg"
		: "album/" + playlistPreview.getFirstAlbumId() + "/cover.jpg"%>"
			width="50">
		</a> <a
			href="popup-add-song_ok.jsp?songid=<%=songId%>&playlistid=<%=playlistPreview.getPlaylistId()%>"><%=playlistPreview.getPlaylistName()%></a>



		<%=playlistPreview.getSongCount()%>곡


	</div>
	<%
	}
	%>

</body>
</html>