<%@page import="com.plick.dto.Playlist"%>
<%@page import="com.plick.playlist.MemDto"%>
<%@page import="com.plick.playlist.PlaylistSongDto"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.plick.dto.Song"%>
<%@page import="com.plick.playlist.PlaylistCommentDto"%>
<%@page import="com.plick.playlist.PlaylistDto"%>
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
PlaylistDto playlistDto = playlistDetailDto.getPlaylistDto();
// 플리 생성자 정보
MemDto author = playlistDto.getMemberDto();
// 플리 정보
Playlist playlist = playlistDto.getPlaylist();
// 플레이리스트 순서대로 정렬한 플리 노래 리스트
List<PlaylistSongDto> sortedSongs = playlistDto.getPlaylistSongDtos().stream()
		.sorted((s1, s2) -> Long.compare(s1.getTurn(), s2.getTurn())).collect(Collectors.toList());
//
long likeCount = playlistDto.getLikeCount();
// 생성일자
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
String formattedCreatedAt = simpleDateFormat.format(playlistDto.getPlaylist().getCreatedAt());
// 무드 한줄 문자열로
StringBuffer mood = new StringBuffer();
mood.append(playlist.getMood1() == null ? "" : playlist.getMood1());
mood.append(" ");
mood.append(playlist.getMood2() == null ? "" : playlist.getMood2());
// 플레이리스트 사진을 위한 첫번째 곡 앨범아이디, 없으면 0
int firstAlbumId = sortedSongs.stream().map(s -> s.getAlbumId()).findFirst().orElse(0);
%>

<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<table>
				<tr>
					<td rowspan="4"><img
						src="/semi2/resources/images/<%=firstAlbumId != 0 ? "album/" + firstAlbumId + "/cover.jpg" : "playlist/default-cover.jpg"%>"
						width="200"></td>
					<td colspan="2"><%=playlist.getName()%></td>
					<td rowspan="2"><%=likeCount%> likes</td>
				</tr>
				<tr>
					<td colspan="2"><a
						href="/semi2/artist/main.jsp?memberid=<%=author.getId()%>"><%=author.getNickname()%></a></td>
				</tr>
				<tr>
					<td colspan="3"><%=mood.toString().trim()%></td>
				</tr>
				<tr>
					<td><a href="#">모두재생</a></td>
					<td><a href="#">담기</a></td>
					<td><a href="#">다운로드</a></td>
				</tr>
			</table>
		</article>
		<article>
			<h1>수록곡</h1>
			<table width="600">
				<thead align="left">
					<tr>
						<th>번호</th>
						<th colspan="2">곡/앨범</th>
						<th>아티스트</th>
						<th>듣기</th>
						<th>내 리스트</th>
						<th>다운로드</th>
					</tr>
					<tr>
						<td colspan="7"><hr></td>
					</tr>
				</thead>
				<tbody>
					<%
					if (sortedSongs == null || sortedSongs.size() == 0) {
					%>
					<tr>
						<td colspan="7">수록곡이 존재하지 않습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < sortedSongs.size(); i++) {
					%>
					<tr>
						<td rowspan="2"><%=i + 1%></td>
						<td rowspan="2"><a href="#"><img
								src="/semi2/resources/images/album/<%=sortedSongs.get(i).getSong().getAlbumId()%>/cover.jpg"
								width="50"></a></td>
						<td><a
							href="/semi2/chart/song-details.jsp?songid=<%=sortedSongs.get(i).getSong().getId()%>"><%=sortedSongs.get(i).getSong().getName()%></a></td>
						<td rowspan="2"><a
							href="/semi2/artist/main.jsp?memberid=<%=sortedSongs.get(i).getMemberId()%>"><%=sortedSongs.get(i).getMemberNickname()%></a></td>
						<td rowspan="2"><a href="#">듣기</a></td>
						<td rowspan="2"><a href="#">담기</a></td>
						<td rowspan="2"><a href="#">다운로드</a></td>
					</tr>
					<tr>
						<td><a
							href="/semi2/chart/album-details.jsp?albumid=<%=sortedSongs.get(i).getAlbumId()%>"><%=sortedSongs.get(i).getAlbumName()%></a></td>
					</tr>
					<tr>
						<td colspan="7"><hr></td>
					</tr>

					<%
					}

					}
					%>
				</tbody>
			</table>
		</article>
		<article>
			<table>
				<tr>
					<td>플리 생성일</td>
				</tr>
				<tr>
					<td><%=formattedCreatedAt%></td>
				</tr>
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