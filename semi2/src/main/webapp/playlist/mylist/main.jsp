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
		window.location.href = "/semi2/member/signin.jsp";
	}
</script>
</head>
<%
SignedinDto loggedinUser = (SignedinDto) session.getAttribute("signedinDto");

if (loggedinUser == null || loggedinUser.getMemberId()==0) {
%>
<script>
	showAlertAndGoLoginPage("로그인이 필요합니다");
</script>
<%
return;
}
int loggedinUserId = loggedinUser.getMemberId();
PlaylistMylistDao playlistMylistDao = new PlaylistMylistDao();
List<PlaylistPreviewDto> playlistPreviews = playlistMylistDao
		.findPlaylistPreviewsOrderByCreatedAtByMemberId(loggedinUserId);
%>
<body>
	<%@include file="/header.jsp"%>
	<h1>내 플레이리스트</h1>
	<%
	for (PlaylistPreviewDto playlistPreview : playlistPreviews) {
	%>
	<div>
		<a
			href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>">
			<img
			src="/semi2/resources/images/<%=playlistPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg"
		: "album/" + playlistPreview.getFirstAlbumId() + "/cover.jpg"%>"
			onerror="this.style.backgroundColor='lightgray';" width="100">
		</a>
		<h3>
			<a
				href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>"><%=playlistPreview.getPlaylistName()%></a>
		</h3>
		<h3><%=playlistPreview.getMemberNickname()%>
			|
			<%=playlistPreview.getSongCount()%>곡
		</h3>

	</div>
	<%
	}
	%>
	<div>
	<a href="/semi2/playlist/mylist/add_ok.jsp"><img
			src="/semi2/resources/images/playlist/add-playlist.jpg" width="100"/></a>
	</div>

	<%@include file="/footer.jsp"%>
</body>
</html>