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
// 로그인 검증
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

// get으로 지울 플레이리스트 가져옴
String playlistId = request.getParameter("playlistid");
if (playlistId == null || playlistId.isEmpty()) {
playlistId = "0";
}

if (!playlistMylistDao.deletePlaylistByPlaylistIdAndMemberId(Integer.parseInt(playlistId), loggedinUserId)) {
%>
<script>
	showAlertAndGoBack('잘못된 접근입니다');
</script>
<%
return;
}

String referer = request.getHeader("referer");
response.sendRedirect(referer == null ? "/semi2/playlist/mylist/main.jsp" : referer);
%>

