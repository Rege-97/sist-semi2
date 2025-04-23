<%@page import="com.plick.playlist.PlaylistDao"%>
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

// 좋아요 누를 대상 플레이리스트id
String playlistIdParam = request.getParameter("playlistid");

int playlistId = -1;
if (playlistIdParam == null || playlistIdParam.isEmpty()) {
%>
<script>
	showAlertAndGoBack("파라미터가 유효하지 않습니다.");
</script>
<%
return;
}
try {
playlistId = Integer.parseInt(playlistIdParam);
} catch (NumberFormatException e) {
%>
<script>
	showAlertAndGoBack("<%=e.getMessage()%>
	");
</script>
<%
return;
}

PlaylistDao playlistDao = new PlaylistDao();
if (!playlistDao.updateLikeByPlaylistIdAndMemberId(playlistId, loggedinUserId)) {
%>
<script>
	showAlertAndGoBack('좋아요 누르기가 실패했습니다.');
</script>
<%
return;
}

String referer = request.getHeader("referer");
response.sendRedirect(referer == null ? "/semi2/playlist/details.jsp?playlistid=" + playlistId : referer);
%>

