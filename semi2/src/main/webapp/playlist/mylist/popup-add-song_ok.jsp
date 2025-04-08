<%@page import="com.plick.playlist.PlaylistPreviewDto"%>
<%@page import="java.util.List"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@page import="com.plick.playlist.mylist.PlaylistMylistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	function showAlertAndGoLoginPage(message) {
		window.alert(message);
		window.location.href = "/semi2/member/signin.jsp";
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
String playlistIdParam = request.getParameter("playlistid");
int songId = -1;
int playlistId = -1;
if (songIdParam == null || playlistIdParam == null || songIdParam.isEmpty() || playlistIdParam.isEmpty()) {
%>
<script>
	showAlertAndGoBack("파라미터가 유효하지 않습니다.");
</script>
<%
return;
}
try {
songId = Integer.parseInt(songIdParam);
playlistId = Integer.parseInt(playlistIdParam);
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
if (!playlistMylistDao.addSongIntoPlaylist(songId, playlistId)) {
%>
<script>
	showAlertAndGoBack("플레이리스트에 노래 넣기를 실패했습니다.");
</script>
<%
return;
}

String referer = request.getHeader("referer");
response.sendRedirect(referer == null ? "/semi2/playlist/mylist/main.jsp" : referer);
%>