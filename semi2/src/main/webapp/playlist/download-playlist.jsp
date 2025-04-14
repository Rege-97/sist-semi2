<%@page import="com.plick.playlist.PlaylistSongDto"%>
<%@page import="com.plick.playlist.PlaylistDao"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plick.chart.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
//로그인 검증
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

String playlistIdParam = request.getParameter("playlistid");
String content = request.getParameter("content");
int playlistId = -1;
if (playlistIdParam == null || playlistIdParam.isEmpty()) {
%>
<script>
	showAlertAndGoBack("잘못된 접근 : 파라미터가 유효하지 않습니다.");
</script>
<%
return;
}
try {
playlistId = Integer.parseInt(playlistIdParam);
} catch (NumberFormatException e) {
%>
<script>
	showAlertAndGoBack("잘못된 접근 : 파라미터에 정수만 전달가능합니다");
</script>
<%
return;
}

PlaylistDao playlistDao = new PlaylistDao();
List<PlaylistSongDto> playlistDownloadDtos = playlistDao.findPlaylistInfoForDownloadByPlaylistId(loggedinUserId,
		playlistId);

if (playlistDownloadDtos == null) {
%>
<script>
	window.alert('이용권이 없습니다. 이용권을 구매해주세요.');
	window.parent.location.href = "/semi2/membership/main.jsp";
</script>
<%
return;
}
%>
<script>
	function downloadSong() {
		var download = document.querySelectorAll("a");

		for (var i = 0; i < download.length; i++) {
			delayedClick(download, i);
		}
	}

	function delayedClick(list, index) {
		setTimeout(function() {
			list[index].click();
		}, index * 100); // 0.1초 간격
	}
</script>
</head>
<body onload="downloadSong()">
	<%
	for (PlaylistSongDto playlistDownloadDto : playlistDownloadDtos) {
	%>
	<a
		href="/semi2/resources/songs/<%=playlistDownloadDto.getAlbumId()%>/<%=playlistDownloadDto.getId()%>.mp3"
		download="<%=playlistDownloadDto.getSongName() + "-" + playlistDownloadDto.getArtistNickname()%>.mp3"></a>
	<%
	}
	%>
</body>
</html>