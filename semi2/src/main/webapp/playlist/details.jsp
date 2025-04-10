<%@page import="com.plick.dto.Playlist"%>
<%@page import="com.plick.playlist.PlaylistSongDto"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.plick.dto.Song"%>
<%@page import="com.plick.playlist.PlaylistCommentDto"%>
<%@page import="com.plick.playlist.PlaylistDao"%>
<%@page import="com.plick.playlist.PlaylistDetailDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.chart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function showAlertAndGoBack(message) {
		window.alert(message);
		window.history.back();
	}
</script>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<%
String playlistId = request.getParameter("playlistid");
if (playlistId == null || playlistId.isEmpty()) {
	playlistId = "0";
}
PlaylistDao playlistDao = new PlaylistDao();
PlaylistDetailDto playlistDetailDto = playlistDao.findPlaylistDetailByPlaylistId(Integer.parseInt(playlistId));

if (playlistDetailDto == null) {
%>
<script>
	showAlertAndGoBack("등록된 플레이리스트가 없습니다.");
</script>
<%
return;
}
// 댓글 리스트
List<PlaylistCommentDto> commentDtos = playlistDetailDto.getPlaylistCommentDtos();//갯수를 지정해서 가져와야함.

// 플레이리스트 순서대로 정렬한 플리 노래 리스트
List<PlaylistSongDto> sortedSongs = playlistDetailDto.getPlaylistSongDtos().stream()
		.sorted((s1, s2) -> Long.compare(s1.getTurn(), s2.getTurn())).collect(Collectors.toList());
//
long likeCount = playlistDetailDto.getLikeCount();
// 생성일자
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
String formattedCreatedAt = simpleDateFormat.format(playlistDetailDto.getCreatedAt());
// 무드 한줄 문자열로
StringBuffer mood = new StringBuffer();
mood.append(playlistDetailDto.getMood1() == null ? "" : playlistDetailDto.getMood1());
mood.append(" ");
mood.append(playlistDetailDto.getMood2() == null ? "" : playlistDetailDto.getMood2());
// 플레이리스트 사진을 위한 첫번째 곡 앨범아이디, 없으면 0
int firstAlbumId = sortedSongs.stream().map(s -> s.getAlbumId()).findFirst().orElse(0);
%>

<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<div class="detail-card">
				<img
					src="/semi2/resources/images/<%=firstAlbumId != 0 ? "album/" + firstAlbumId + "/cover.jpg" : "playlist/default-cover.jpg"%>"
					class="detail-card-image">
				<div class="detail-card-info">
					<div class="detail-card-info-name">
						<h2><%=playlistDetailDto.getPlaylistName()%></h2>
					</div>
					<div class="detail-card-info-artist-name">
						<a
							href="/semi2/artist/main.jsp?memberid=<%=playlistDetailDto.getMemberId()%>"><%=playlistDetailDto.getNickname()%></a>
					</div>
					<div class="detail-card-info-genre"><%=mood.toString().trim()%></div>
					<div class="detail-card-info-date">
						생성일 :
						<%=formattedCreatedAt%>
					</div>
					<div class="detail-card-info-icon">
						<div class="icon-group">
							<a href="#"> <img
								src="/semi2/resources/images/design/play-icon.png"
								class="icon-dafault"> <img
								src="/semi2/resources/images/design/play-icon-hover.png"
								class="icon-hover">
							</a>
						</div>
						<div class="icon-group">
							<a href="#"> <img
								src="/semi2/resources/images/design/add-list-icon.png"
								class="icon-dafault"> <img
								src="/semi2/resources/images/design/add-list-icon-hover.png"
								class="icon-hover">
							</a>
						</div>
						<div class="icon-group">
							<a href="#"> <img
								src="/semi2/resources/images/design/download-icon.png"
								class="icon-dafault"> <img
								src="/semi2/resources/images/design/download-icon-hover.png"
								class="icon-hover">
							</a>
						</div>
						<div class="icon-group-likes">
							<a href="#"> <img
								src="/semi2/resources/images/design/likes-icon.png"
								class="likes-icon">
							</a>
							<div class="likes-count">
								<%=likeCount%>
							</div>
						</div>
					</div>
				</div>

			</div>
		</article>
		<article>
			<div class="categorey-name">수록곡</div>
			<table class="song-list">
				<colgroup>
					<col style="width: 40px;">
					<!-- 순위 -->
					<col style="width: 50px;">
					<!-- 앨범 이미지 -->
					<col style="width: 270px;">
					<!-- 곡/앨범 -->
					<col style="width: 120px;">
					<!-- 아티스트 -->
					<col style="width: 40px;">
					<!-- 듣기 -->
					<col style="width: 40px;">
					<!-- 리스트 -->
					<col style="width: 40px;">
					<!-- 다운로드 -->
				</colgroup>
				<thead>
					<tr class="song-list-head">
						<th>순번</th>
						<th colspan="2">곡/앨범</th>
						<th>아티스트</th>
						<th>듣기</th>
						<th>내 리스트</th>
						<th>다운로드</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (sortedSongs == null || sortedSongs.size() == 0) {
					%>
					<tr>
						<td colspan="6">수록곡이 존재하지 않습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < sortedSongs.size(); i++) {
					%>
					<tr class="song-list-body">
						<td>
							<div class="song-list-row"><%=i + 1%></div>
						</td>
						<td>
							<div class="song-list-album-image">
								<a href="#"><img
									src="/semi2/resources/images/album/<%=sortedSongs.get(i).getAlbumId()%>/cover.jpg"
									class="song-list-album-image"></a>
							</div>
						</td>
						<td>
							<div class="song-list-song-name">
								<a
									href="/semi2/chart/song-details.jsp?songid=<%=sortedSongs.get(i).getId()%>"><%=sortedSongs.get(i).getSongName()%></a>
							</div>
							<div class="song-list-album-name">
								<a
									href="/semi2/chart/album-details.jsp?albumid=<%=sortedSongs.get(i).getAlbumId()%>"><%=sortedSongs.get(i).getAlbumName()%></a>
							</div>
						</td>
						<td>
							<div class="song-list-artist-name">
								<a
									href="/semi2/artist/main.jsp?memberid=<%=sortedSongs.get(i).getArtistId()%>"><%=sortedSongs.get(i).getArtistNickname()%></a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#"> <img
									src="/semi2/resources/images/design/play-icon.png"
									class="icon-default"> <img
									src="/semi2/resources/images/design/play-icon-hover.png"
									class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#"> <img
									src="/semi2/resources/images/design/add-list-icon.png"
									class="icon-default"> <img
									src="/semi2/resources/images/design/add-list-icon-hover.png"
									class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#"> <img
									src="/semi2/resources/images/design/download-icon.png"
									class="icon-default"> <img
									src="/semi2/resources/images/design/download-icon-hover.png"
									class="icon-hover">
								</a>
							</div>
						</td>
					</tr>

					<%
					}

					}
					%>
				</tbody>
			</table>
		</article>
		<article>
			<hr>
			<form>
				<img>사용자프로필이미지 <label>닉네임</label> <input type="text">
				<input type="submit" value="등록">
			</form>
			<table>
				<tr>
					<td><img>사용자프로필이미지
					<td><label>닉네임</label>
					<td><label>댓글컨텐츠</label> <input type="button" value="답글">
				<tr>
					<td><img>사용자프로필이미지
					<td><label>닉네임</label>
					<td><label>댓글컨텐츠</label> <input type="button" value="답글">
			</table>

		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>