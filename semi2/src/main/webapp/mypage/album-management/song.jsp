<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.plick.mypage.SongDto"%>
<%@page import="com.plick.mypage.AlbumDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">

<%
if (session.getAttribute("signedinDto") == null) {
	response.sendRedirect("/semi2/member/signin.jsp");
	return;
} else if (((SignedinDto) session.getAttribute("signedinDto")).getMemberId() == 0) {
	response.sendRedirect("/semi2/member/signin.jsp");
	return;
}

%>
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/mypage/mypage-header.jsp"%>
	<%
if(request.getParameter("albumId")!=null){
	int albumId = (Integer.parseInt(request.getParameter("albumId")));

	AlbumDto aDto = mdao.findInfoAlbums(albumId);
	ArrayList<SongDto> songs = mdao.findAlbumSongs(albumId);
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy년 MM월 dd일");
	String releasedAt = formatter.format(aDto.getReleased_at());
	%>
	<h2>앨범수정</h2>
	<div>
		<input type="button" value="신곡 추가하기"
			onclick="location.href = 'song-form.jsp'"> <input
			type="button" value="앨범 정보 수정"
			onclick="location.href = 'album-form.jsp?albumId=<%=albumId%>'">
		<table class="mypage-album-table">
			<thead>
				<tr>
					<td></td>
					<td>앨범번호</td>
					<td>앨범명</td>
					<td>발매일</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><img
						src="/semi2/resources/images/album/<%=albumId%>/cover.jpg"
						onerror="this.src='/semi2/resources/images/album/default-cover.jpg';"
						class="detail-card-image"></td>
					<td><%=aDto.getId()%></td>
					<td><%=aDto.getName()%></td>
					<td><%=releasedAt%></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div>
		<table>
			<thead>
				<tr>

					<td>곡번호</td>
					<td>곡명</td>
					<td>작사</td>
					<td>작곡</td>
				</tr>
			</thead>
			<tbody>
				<%
				if (songs == null || songs.size() == 0) {
				%>
				<tr>
					<td colspan="4">등록된 수록곡이 없습니다</td>
				</tr>
				<%
				} else {
				for (int i = 0; i < songs.size(); i++) {
				%>
				<tr>

					<td><%=songs.get(i).getId()%></td>
					<td><%=songs.get(i).getName()%></td>
					<td><%=songs.get(i).getComposer()%></td>
					<td><%=songs.get(i).getLyricist()%></td>
					<td><input type="button" value="연필모양"
						onclick="location.href = 'song-form.jsp?songId=<%=songs.get(i).getId()%>&albumId=<%=albumId%>'">
					</td>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>
	</div>
	<%@ include file="/footer.jsp"%>
<%
}else{
%>
<script>
window.alert("잘못된 접근입니다. 메인페이지로 돌아갑니다.");
parent.location.href = "/semi2/main.jsp";
</script>
<%	
}
%>
</body>
</html>
