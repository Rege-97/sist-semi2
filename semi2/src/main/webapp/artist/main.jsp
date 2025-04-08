<%@page import="com.plick.playlist.PlaylistPreviewDto"%>
<%@page import="com.plick.dto.Album"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.dto.Playlist"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="java.util.Comparator"%>
<%@page import="com.plick.dto.Song"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.plick.artist.ArtistAlbumDto"%>
<%@page import="java.util.List"%>
<%@page import="com.plick.artist.ArtistDto"%>
<%@page import="com.plick.artist.ArtistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!final int MAX_SONGS_LENGTH = 10;
	final int MAX_ALBUMS_LENGTH = 5;%>

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
String memberIdParam = request.getParameter("memberid");
int memberId = -1;
if (memberIdParam == null || memberIdParam.isEmpty()) {
%>
<script>
	showAlertAndGoBack("파라미터가 유효하지 않습니다.");
</script>
<%
return;
}

try {
memberId = Integer.parseInt(memberIdParam);
} catch (NumberFormatException e) {
%>
<script>
	showAlertAndGoBack("<%=e.getMessage()%>
	");
</script>
<%
}

ArtistDao artistDao = new ArtistDao();
ArtistDto artistDto = artistDao.findArtistDetailsByMemberId(memberId);
if (artistDto == null) {
%>
<script>
	showAlertAndGoBack("등록된 회원이 없습니다.");
</script>
<%
return;
}
String nickname = artistDto.getNickname();
// 아티스트의 앨범을 최신순으로 정렬해 리스트화
List<ArtistAlbumDto> sortedAlbums = artistDto.getAlbums() != null ? artistDto.getAlbums().stream()
		.sorted((a1, a2) -> a2.getAlbumDto().getCreatedAt().compareTo(a1.getAlbumDto().getCreatedAt()))
		.collect(Collectors.toList()) : new ArrayList<>();

// 아티스트의 플레이리스트를 최신순으로 정렬해 리스트화
List<PlaylistPreviewDto> playlistPreviews = artistDto.getPlaylists();

// 아티스트의 모든 노래를 조회수로 내림차순 정렬해 리스트화
List<Song> sortedSongs = sortedAlbums.stream().flatMap(album -> album.getSongDtos().stream())
		.sorted((s1, s2) -> Integer.compare(s2.getViewCount(), s1.getViewCount())).collect(Collectors.toList());
// 총 조회수 합산
long totalViewCount = sortedSongs.stream().mapToLong(song -> song.getViewCount()).sum();
// 총 조회수 세자리마다 콤마 들어가는 스트링타입으로 변경
NumberFormat formatter = NumberFormat.getNumberInstance();
String formattedTotalViewCount = formatter.format(totalViewCount);

boolean isArtist = "artist".equals(artistDto.getAccessType());
%>
<body>
	<%@ include file="/header.jsp"%>

	<img
		src="/semi2/resources/images/member/<%=artistDto.getId()%>/banner.jpg"
		onerror="this.src='/semi2/resources/images/member/default-banner.jpg';"
		width=100% height="400px" />
	<h1><%=nickname%></h1>

	<%
	if (isArtist) {
	%>

	<section>
		<label>누적 리스너: <%=formattedTotalViewCount%></label>

		<h2>인기곡</h2>
		<table>
			<%
			for (int i = 0; i < Math.min(sortedSongs.size(), MAX_SONGS_LENGTH); i++) {
			%>
			<tr>
				<td><%=i + 1%></td>
				<td><a
					href="/semi2/chartchart/album-details.jsp?albumid=<%=sortedSongs.get(i).getId()%>">
						<img
						src="/semi2/resources/images/album/<%=sortedSongs.get(i).getAlbumId()%>/cover.jpg"
						width="100" />
				</a></td>
				<td><a
					href="/semi2/chartchart/song-details.jsp?songid=<%=sortedSongs.get(i).getId()%>"><%=sortedSongs.get(i).getName()%></a></td>
				<td><%=sortedSongs.get(i).getViewCount()%></td>
				<td><a href="#">플리추가</a></td>
				<td><a href="#">재생</a></td>
				<td><a href="#">다운로드</a></td>
			</tr>
			<%
			}
			%>

		</table>
	</section>

	<%
	}
	%>

	<section>
		<h2><%=isArtist ? "아티스트 픽" : "리스너 픽"%></h2>
		<table>
			<tr>
				<%
				if (playlistPreviews.size() == 0) {
				%>
				<td colspan="4">플레이리스트가 없습니다.</td>
				<%
				}
				for (PlaylistPreviewDto playlistPreview : playlistPreviews) {
				%>
				<td>
					<table>
						<tr>
							<td><a
								href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>">
									<img
									src="/semi2/resources/images/<%=playlistPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg"
		: "album/" + playlistPreview.getFirstAlbumId() + "/cover.jpg"%>"
									class="gallery-card-album-image" width="200" />
							</a></td>
						</tr>
						<tr>
							<td><a
								href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>"><%=playlistPreview.getPlaylistName()%></a></td>
						</tr>
						<tr>
							<td>좋아요:<%=playlistPreview.getLikeCount()%> | <%=playlistPreview.getSongCount()%>곡
								| 생성일:<%=playlistPreview.getCreatedAt().toString().substring(0, 10)%></td>
						</tr>
					</table>
				</td>
				<%
				}
				%>
			</tr>
		</table>
	</section>

	<%
	if (isArtist) {
	%>

	<section>
		<h2>이 아티스트의 최신 앨범</h2>
		<table>
			<tr>
				<%
				for (int i = 0; i < Math.min(sortedAlbums.size(), MAX_ALBUMS_LENGTH); i++) {
					StringBuffer genre = new StringBuffer();
					Album albumDto = sortedAlbums.get(i).getAlbumDto();
					genre.append(albumDto.getGenre1() == null ? "" : albumDto.getGenre1());
					genre.append(" ");
					genre.append(albumDto.getGenre2() == null ? "" : albumDto.getGenre2());
					genre.append(" ");
					genre.append(albumDto.getGenre3() == null ? "" : albumDto.getGenre3());
				%>
				<td>
					<table>
						<tr>
							<td><a
								href="/semi2/chartchart/album-details.jsp?albumid=<%=sortedSongs.get(i).getId()%>">
									<img
									src="/semi2/resources/images/album/<%=sortedAlbums.get(i).getAlbumDto().getId()%>/cover.jpg"
									width="200" />
							</a></td>
						</tr>
						<tr>
							<td><a
								href="/semi2/chartchart/album-details.jsp?albumid=<%=sortedSongs.get(i).getId()%>">
									<%=sortedAlbums.get(i).getAlbumDto().getName()%></a> • <%=sortedAlbums.get(i).getAlbumDto().getCreatedAt().toString().substring(0, 10)%></td>
						</tr>
						<tr>
							<td><%=genre.toString().trim()%></td>
						</tr>
					</table>
				</td>
				<%
				}
				%>
			</tr>
		</table>
	</section>
	<%
	}
	%>

	<section>
		<h2><%=isArtist ? "아티스트 소개" : "리스너 소개"%></h2>
		<img
			src="/semi2/resources/images/member/<%=artistDto.getId()%>/banner.jpg"
			onerror="this.src='/semi2/resources/images/member/default-profile.jpg';"
			width="300px" height="300px" />
		<div>
			<%=artistDto.getDescription() == null ? "" : artistDto.getDescription().replace("\r\n", "<br/>")%>
		</div>
	</section>
	<%@ include file="/footer.jsp"%>
</body>
</html>