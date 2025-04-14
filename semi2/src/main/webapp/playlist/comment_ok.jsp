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
		window.location.href = document.referrer + '#comment';
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

String playlistIdParam = request.getParameter("playlistid");
String content = request.getParameter("content");
int playlistId = -1;
if (playlistIdParam == null || content == null || playlistIdParam.isEmpty() || content.isEmpty()) {
%>
<script>
	showAlertAndGoBack("잘못된 접근 : 파라미터가 유효하지 않습니다.");
</script>
<%
return;
}
String parentIdParam = request.getParameter("parentid");
int parentId = -1;
if (parentIdParam == null || parentIdParam.isEmpty()) {
parentIdParam = "0";
}
try {
playlistId = Integer.parseInt(playlistIdParam);
parentId = Integer.parseInt(parentIdParam);
} catch (NumberFormatException e) {
%>
<script>
	showAlertAndGoBack("잘못된 접근 : 파라미터에 정수만 전달가능합니다");
</script>
<%
return;
}

PlaylistDao playlistDao = new PlaylistDao();

if (!playlistDao.addComment(playlistId, loggedinUserId, content, parentId)) {
%>
<script>
	showAlertAndGoBack("댓글등록 실패");
</script>
<%
}

String referer = request.getHeader("referer");
response.sendRedirect(
		referer == null ? "/semi2/playlist/details.jsp?playlistid=" + playlistId + "#comment" : referer + "#comment");
%>