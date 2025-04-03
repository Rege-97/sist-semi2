<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.dto.PlaylistDto"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="java.util.Comparator"%>
<%@page import="com.plick.dto.SongDto"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.plick.artist.AlbumDto"%>
<%@page import="java.util.List"%>
<%@page import="com.plick.artist.ArtistDto"%>
<%@page import="com.plick.artist.ArtistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!final int MAX_SONGS_LENGTH = 10;
	final int MAX_ALBUMS_LENGTH = 5;
	final int MAX_PLAYLISTS_LENGTH = 5;%>

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
String memberId = request.getParameter("memberid");
if (memberId == null || memberId.isEmpty()) {
%>
<script>
	showAlertAndGoBack("아티스트 번호를 request에 전달해주세요.");
</script>
<%
return;
}
ArtistDao artistDao = new ArtistDao();
ArtistDto artistDto = artistDao.findArtistDetailsByMemberId(Integer.parseInt(memberId));
if (artistDto == null) {
%>
<script>
	showAlertAndGoBack("등록된 아티스트가 없습니다.");
</script>
<%
return;
}
String nickname = artistDto.getNickname();
// 아티스트의 앨범을 최신순으로 정렬해 리스트화
List<AlbumDto> sortedAlbums = artistDto.getAlbums() != null ? artistDto.getAlbums().stream()
		.sorted((a1, a2) -> a2.getAlbumDto().getCreatedAt().compareTo(a1.getAlbumDto().getCreatedAt()))
		.collect(Collectors.toList()) : new ArrayList<>();

// 아티스트의 플레이리스트를 최신순으로 정렬해 리스트화
List<PlaylistDto> sortedPlaylists = artistDto.getPlaylistDtos() != null
		? artistDto.getPlaylistDtos().stream().sorted((p1, p2) -> p2.getCreatedAt().compareTo(p1.getCreatedAt()))
		.collect(Collectors.toList())
		: new ArrayList<>();

// 아티스트의 모든 노래를 조회수로 내림차순 정렬해 리스트화
List<SongDto> sortedSongs = sortedAlbums.stream().flatMap(album -> album.getSongDtos().stream())
		.sorted((s1, s2) -> Integer.compare(s2.getViewCount(), s1.getViewCount())).collect(Collectors.toList());
// 총 조회수 합산
long totalViewCount = sortedSongs.stream().mapToLong(song -> song.getViewCount()).sum();
// 총 조회수 세자리마다 콤마 들어가는 스트링타입으로 변경
NumberFormat formatter = NumberFormat.getNumberInstance();
String formattedTotalViewCount = formatter.format(totalViewCount);
%>
<body>
	<%@ include file="/header.jsp"%>
	<img
		src="/semi2/resources/images/member/<%=artistDto.getId()%>/banner.png"
		width=100% />
	<h1><%=nickname%></h1>
	<label>누적 리스너: <%=formattedTotalViewCount%></label>
	<h2>인기</h2>
	<table>
		<%
		for (int i = 0; i < Math.min(sortedSongs.size(), MAX_SONGS_LENGTH); i++) {
		%>
		<tr>
			<td><%=i + 1%></td>
			<td><a href="#"> <img
					src="/semi2/resources/images/album/<%=sortedSongs.get(i).getAlbumId()%>/cover.png"
					width="100" />
			</a></td>
			<td><a
				href="/semi2/chartchart/song-details.jsp?songid=<%=sortedSongs.get(i).getId()%>"><%=sortedSongs.get(i).getName()%></a></td>
			<td><%=sortedSongs.get(i).getViewCount()%></td>
			<td><a href="#">플리추가</a></td>
			<td><a href="#">재생</a></td>
		</tr>
		<%
		}
		%>

	</table>
	<h2>아티스트 픽</h2>
	<table>
		<tr>
			<%
			for (int i = 0; i < Math.min(sortedPlaylists.size(), MAX_PLAYLISTS_LENGTH); i++) {
			%>
			<td>
				<table>
					<tr>
						<td><a href="#"> <img
								src="/semi2/resources/images/playlist/<%=sortedPlaylists.get(i).getId()%>/cover.png"
								width="200" />
						</a></td>
					</tr>
					<tr>
						<td><a href="#"><%=sortedPlaylists.get(i).getName()%></a></td>
					</tr>
					<tr>
						<td><%=sortedPlaylists.get(i).getMood1() + " " + sortedPlaylists.get(i).getMood2()%></td>
					</tr>
				</table>
			</td>
			<%
			}
			%>
		</tr>
	</table>
	<h2>이 아티스트의 최신 앨범</h2>
	<table>
		<tr>

			<%
			for (int i = 0; i < Math.min(sortedAlbums.size(), MAX_ALBUMS_LENGTH); i++) {
			%>
			<td>
				<table>
					<tr>
						<td><a href="#"> <img
								src="/semi2/resources/images/album/<%=sortedAlbums.get(i).getAlbumDto().getId()%>/cover.png"
								width="200" />
						</a></td>
					</tr>
					<tr>
						<td><a href="#"><%=sortedAlbums.get(i).getAlbumDto().getName()%></a>
							• <%=sortedAlbums.get(i).getAlbumDto().getCreatedAt().toString().substring(0, 7)%></td>
					</tr>
					<tr>
						<td><%=sortedAlbums.get(i).getAlbumDto().getGenre1() + " " + sortedAlbums.get(i).getAlbumDto().getGenre2() + " "
		+ sortedAlbums.get(i).getAlbumDto().getGenre3()%></td>
					</tr>
				</table>
			</td>
			<%
			}
			%>
		</tr>
	</table>
	<h2>아티스트 소개</h2>
	<img name="artistprofilemain">
	<label>누적리스너: <%=formattedTotalViewCount%>명
	</label>
	<div>
		<%=artistDto.getDescription()%>
	</div>
	<%@ include file="/footer.jsp"%>
</body>
</html>