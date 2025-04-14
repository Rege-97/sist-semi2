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
int id = -1;

if (type == null || idParam == null || type.isEmpty() || idParam.isEmpty()) {
%>
<script>
	showAlertAndGoBack("파라미터가 유효하지 않습니다.");
</script>
<%
return;
}

try {
id = Integer.parseInt(idParam);
} catch (NumberFormatException e) {
%>
<script>
	showAlertAndGoBack("잘못된 접근: 파라미터에 정수만 전달가능합니다.");
</script>
<%
}

int loggedinUserId = loggedinUser.getMemberId();
PlaylistMylistDao playlistMylistDao = new PlaylistMylistDao();
List<PlaylistPreviewDto> playlistPreviews = playlistMylistDao
		.findPlaylistPreviewsOrderByCreatedAtByMemberId(loggedinUserId);
%>
<body>
	<h1>내 플레이리스트</h1>
	<div>
		<form action="popup-list-form_ok.jsp" method="get">
			<input type="text" id="playlistNameText" name="playlistName"
				placeholder="플레이리스트 이름을 정해주세요."
				value="<%=playlistPreviews.size() + 1%>번 플레이리스트" /> <input
				type="button" value="X"
				onclick="document.getElementById('playlistNameText').value = '';" />
			<input type="hidden" id="id" name="id" value="<%=id%>" /> <input
				type="hidden" id="id" name="type" value="<%=type%>" /> <br /> <input
				type="button"
				onclick="window.location.href='popup-list.jsp?<%=type%>id=<%=id%>';"
				value="취소" /> <input type="submit" value="확인" />
		</form>
	</div>
	<%
	// 플레이리스트 하나씩 나열
	for (PlaylistPreviewDto playlistPreview : playlistPreviews) {
	%>
	<div>
		<a
			href="popup-add-song_ok.jsp?type=<%=type%>&id=<%=id%>&playlistid=<%=playlistPreview.getPlaylistId()%>">
			<img
			src="/semi2/resources/images/<%=playlistPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg"
		: "album/" + playlistPreview.getFirstAlbumId() + "/cover.jpg"%>"
			width="50">
		</a> <a
			href="popup-add-song_ok.jsp?type=<%=type%>&id=<%=id%>&playlistid=<%=playlistPreview.getPlaylistId()%>"><%=playlistPreview.getPlaylistName()%></a>



		<%=playlistPreview.getSongCount()%>곡


	</div>
	<%
	}
	%>

</body>
</html>