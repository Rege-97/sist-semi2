<%@page import="com.plick.playlist.mylist.PlaylistMylistDao"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	function showAlertAndGoLoginPage(message) {
		window.alert(message);
		window.location.href = "/semi2/member/signin.jsp";
	}
	function showAlertAndGoBack(message) {
		window.alert(message);
		history.back();
	}
</script>
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

String playlistName = request.getParameter("playlistName");
if (playlistName == null || playlistName.isEmpty()) {
playlistName = "default name";
}

PlaylistMylistDao playlistMylistDao = new PlaylistMylistDao();
if (!playlistMylistDao.addPlaylistWithLikeCount(loggedinUserId, playlistName)) {
%>
<script>
	showAlertAndGoBack('오류가 발생했습니다');
</script>
<%
return;
}
String referer = request.getHeader("referer");
response.sendRedirect(referer == null ? "/semi2/playlist/mylist/main.jsp" : referer);
%>

