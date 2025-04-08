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
List<PlaylistPreviewDto> playlistPreviews = playlistMylistDao
		.findPlaylistPreviewsOrderByCreatedAtByMemberId(loggedinUserId);
%>
<body>
	<%@include file="/header.jsp"%>
	<h1>내 플레이리스트</h1>
	<div>
		<a
			href="/semi2/playlist/mylist/add_ok.jsp?playlistName=<%=playlistPreviews.size() + 1%>번 플레이리스트"><img
			src="/semi2/resources/images/playlist/add-playlist.jpg" width="100" /></a>

		<a
			href="/semi2/playlist/mylist/add_ok.jsp?playlistName=<%=playlistPreviews.size() + 1%>번 플레이리스트">새로운
			플레이리스트 만들기</a>
	</div>
	<%
	// 플레이리스트 하나씩 나열
	for (PlaylistPreviewDto playlistPreview : playlistPreviews) {
	%>
	<div>
		<a
			href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>">
			<img
			src="/semi2/resources/images/<%=playlistPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg"
		: "album/" + playlistPreview.getFirstAlbumId() + "/cover.jpg"%>"
			width="100">
		</a>

		<h3>
			<a
				href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>"><%=playlistPreview.getPlaylistName()%></a>
		</h3>
		<div>
			<a
				href="/semi2/playlist/mylist/delete_ok.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>"
				onclick="return confirmAction('정말 삭제하시겠습니까?');">조그맣고귀엽게생긴삭제기능사진넣어주세요</a>
		</div>

		<h3><%=playlistPreview.getMemberNickname()%>
			|
			<%=playlistPreview.getSongCount()%>곡
		</h3>

	</div>
	<%
	}
	%>

	<%@include file="/footer.jsp"%>

</body>
</html>