<%@page import="com.plick.playlist.PlaylistPreviewDto"%>
<%@page import="java.util.List"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@page import="com.plick.playlist.mylist.PlaylistMylistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	function showAlertAndGoLoginPage(message) {
		window.alert(message);
		if (window.parent && typeof window.parent.closeModal === 'function') {
			window.parent.closeModal();
		} else {
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
String type = request.getParameter("type");
String idParam = request.getParameter("id");
String playlistIdParam = request.getParameter("playlistid");
int playlistId = -1;
int id = -1;

if (type == null || idParam == null || playlistIdParam == null || type.isEmpty() || idParam.isEmpty()
		|| playlistIdParam.isEmpty()) {
%>
<script>
	showAlertAndGoBack("파라미터가 유효하지 않습니다.");
</script>
<%
return;
}

try {
id = Integer.parseInt(idParam);
playlistId = Integer.parseInt(playlistIdParam);
} catch (NumberFormatException e) {
%>
<script>
	showAlertAndGoBack("잘못된 접근: 파라미터에 정수만 전달가능합니다.");
</script>
<%
}

int loggedinUserId = loggedinUser.getMemberId();
PlaylistMylistDao playlistMylistDao = new PlaylistMylistDao();

boolean isAdded = false;

if (type.equals("song")) {
isAdded = playlistMylistDao.addSongIntoPlaylist(id, playlistId);
} // TODO 앨범 플리 추가 만들어야함.
else if (type.equals("album")) {
isAdded = playlistMylistDao.addAlbumIntoPlaylist(id, playlistId);
} else if (type.equals("playlist")) {
isAdded = playlistMylistDao.addAnoterPlaylistIntoMyPlaylist(id, playlistId);
}

if (!isAdded) {
%>
<script>
	showAlertAndGoBack("플레이리스트에 노래 넣기를 실패했습니다.");
</script>
<%
return;
}
%>
<script>
	if (window.parent && typeof window.parent.closeModal === 'function') {
		window.parent.closeModal();
	} else {
		window.close();
	}
</script>
