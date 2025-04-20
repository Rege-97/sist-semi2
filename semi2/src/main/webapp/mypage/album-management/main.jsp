<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.plick.mypage.AlbumDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@ page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.mypage-album-main-table {
	border-collapse: separate;
	border-spacing: 20px;
}
</style>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/mypage/mypage-header.jsp"%>
	<%
	ArrayList<AlbumDto> albums = mdao.findMeberAlbums(signedinDto.getMemberId());
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy년 MM월 dd일");
	%>
		<div class=profile-change-card>
	<div class="subtitle">
			<h2>앨범목록</h2>
		</div>
	<div>
		<input type="button" value="신규 앨범 등록"
			onclick="location.href = 'album-form.jsp'" class="bt">
			<div class="blank"></div>
		<table class="album-list">
		<colgroup>
					<col style="width: 250px;">
					<col style="width: 250px;">
					<col style="width: 250px;">
					<col style="width: 250px;">
				</colgroup>
			<thead>
				<tr class="album-list-head">
					<th>앨범번호</th>
					<th>앨범커버</th>
					<th>앨범명</th>
					<th>발매일</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (int i = 0; i < albums.size(); i++) {
					String releasedAt = formatter.format(albums.get(i).getReleased_at());
				%>

					<tr class="album-list-body">
					<td><a href="song.jsp?albumId=<%=albums.get(i).getId()%>"><%=albums.get(i).getId()%></a></td>
					<td><a href="song.jsp?albumId=<%=albums.get(i).getId()%>"><img
							src="/semi2/resources/images/album/<%=albums.get(i).getId()%>/cover.jpg"
							onerror="this.src='/semi2/resources/images/album/default-cover.jpg';"
							class="song-list-album-image"></a></td>
					<td><a href="song.jsp?albumId=<%=albums.get(i).getId()%>"><%=albums.get(i).getName()%></a></td>
					<td><%=releasedAt%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<div class="blank2"></div>
	</div>
	</div>
	<%@ include file="/footer.jsp"%>
</body>
</html>