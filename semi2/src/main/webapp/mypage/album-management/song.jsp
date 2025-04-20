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
			<div class=profile-change-card>
	<div class="subtitle">
			<h2>앨범수정</h2>
		</div>
	<div>
	<div>
		<input type="button" value="신곡 추가하기"
			onclick="location.href = 'song-form.jsp?albumId=<%=albumId%>'" class="bt"> <input
			type="button" value="앨범 정보 수정"
			onclick="location.href = 'album-form.jsp?albumId=<%=albumId%>'" class="bt">
</div>
<div class="blank"></div>
			<img src="/semi2/resources/images/album/<%=albumId%>/cover.jpg"
						onerror="this.src='/semi2/resources/images/album/default-cover.jpg';"
						class="detail-card-image">

			<div class="detail-card-info-name">
			<h2><%=aDto.getName()%></h2>
			</div>
			<div class="album-card-info-date">
			<%=aDto.getId()%>
			</div>
			<div class="album-card-info-date">
						<%=releasedAt%>
					</div>

	</div>
	<div class="blank"></div>
	<div>
		<table class="album-list">
		<colgroup>
					<col style="width: 200px;">
					<col style="width: 200px;">
					<col style="width: 200px;">
					<col style="width: 200px;">
					<col style="width: 200px;">
		</colgroup>
			<thead>
				<tr class="album-list-head">

					<th>곡번호</th>
					<th>곡명</th>
					<th>작사</th>
					<th>작곡</th>
					<th>수정</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (songs == null || songs.size() == 0) {
				%>
				<tr class="album-list-body">
					<td colspan="5">등록된 수록곡이 없습니다</td>
				</tr>
				<%
				} else {
				for (int i = 0; i < songs.size(); i++) {
				%>
				<tr class="album-list-body">

					<td><%=songs.get(i).getId()%></td>
					<td><%=songs.get(i).getName()%></td>
					<td><%=songs.get(i).getComposer()%></td>
					<td><%=songs.get(i).getLyricist()%></td>
					<td><img id="edit-icon"
								src="/semi2/resources/images/design/playlist-edit.png"
								width="25" height="25" onclick="location.href = 'song-form.jsp?songId=<%=songs.get(i).getId()%>&albumId=<%=albumId%>'"/>
					
					
					</td>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>
	</div>
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
