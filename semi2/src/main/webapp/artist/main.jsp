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
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
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
	<iframe name="hiddenFrame" style="display: none;"></iframe>
	<%@ include file="/header.jsp"%>
	<div class="search-gallery">
		<div class="artist-card">
			<div
				style="align-items: center; display: flex; flex-direction: column;">
				<img
					src="/semi2/resources/images/member/<%=artistDto.getId()%>/profile.jpg"
					onerror="this.src='/semi2/resources/images/member/default-profile.jpg';"
					class="artist-main-image" />

				<div style="margin-top: 20px; font-size: 15px; color: #ccc;">
					<label>누적 리스너 <%=formattedTotalViewCount%>명
					</label>
				</div>
			</div>
			<div class="artist-card-info">
				<h1 style="font-size: 50px"><%=nickname%></h1>
				<div class="artist-description-background">
				<div class="artist-description">
					<%=artistDto.getDescription() == null ? "" : artistDto.getDescription().replace("\r\n", "<br/>")+"<br/><br/><br/>"%>
				</div>
				</div>

			</div>
		</div>
	</div>
	<%
	if (isArtist) {
	%>

	<section>

		<div class="categorey-name">
			<h2>인기곡</h2>
		</div>
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
				for (int i = 0; i < Math.min(sortedSongs.size(), MAX_SONGS_LENGTH); i++) {
					String viewCount = formatter.format(sortedSongs.get(i).getViewCount());
				%>
				<tr class="song-list-body">
					<td>
						<div class="song-list-row"><%=i + 1%></div>
					</td>
					<td>
						<div class="song-list-album-image">
							<a
								href="/semi2/chart/album-details.jsp?albumid=<%=sortedSongs.get(i).getAlbumId()%>"><img
								src="/semi2/resources/images/album/<%=sortedSongs.get(i).getAlbumId()%>/cover.jpg"
								class="song-list-album-image"></a>
						</div>
					</td>
					<td>
						<div class="song-list-song-name">
							<a
								href="/semi2/chart/song-details.jsp?songid=<%=sortedSongs.get(i).getId()%>"><%=sortedSongs.get(i).getName()%></a>
						</div>
						<div class="song-list-album-name">
							<a>누적 조회수 : <%=viewCount%></a>
						</div>
					</td>
					<td>
						<div class="song-list-artist-name">
							<a href="/semi2/artist/main.jsp?memberid=<%=memberId%>"><%=nickname%></a>
						</div>
					</td>
					<td>
						<div class="icon-group">
							<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?songid=<%=sortedSongs.get(i).getId()%>'); return false;"> <img src="/semi2/resources/images/design/play-icon.png" class="icon-default"> <img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
							</a>
						</div>
					</td>
					<td>
						<div class="icon-group">
							<a href="#"
								onclick="openModal('songid',<%=sortedSongs.get(i).getId()%>); return false;">
								<img src="/semi2/resources/images/design/add-list-icon.png"
								class="icon-default"> <img
								src="/semi2/resources/images/design/add-list-icon-hover.png"
								class="icon-hover">
							</a>
						</div>
					</td>
					<td>
						<div class="icon-group">
							<a
								href="/semi2/chart/download-song.jsp?songid=<%=sortedSongs.get(i).getId()%>&songname=<%=sortedSongs.get(i).getName()%>&albumid=<%=sortedSongs.get(i).getAlbumId()%>&artist=<%=nickname%>"
								target="hiddenFrame"> <img
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
	</section>

	<%
	}
	%>

	<section>
		<div class="blank2"></div>
		<div class="categorey-name">
			<h2><%=isArtist ? "아티스트 픽" : "리스너 픽"%></h2>
		</div>
		<div class="gallery">
			<%
			// 플레이리스트 하나씩 나열
			for (PlaylistPreviewDto playlistPreview : playlistPreviews) {
			%>
			<div class="gallery-card">
				<div class="gallery-card-album-image-group">
					<a
						href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>">
						<img
						src="/semi2/resources/images/<%=playlistPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg"
		: "album/" + playlistPreview.getFirstAlbumId() + "/cover.jpg"%>"
						class="gallery-card-album-image">
					</a>
					<div class="gallery-card-album-image-play">

						<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>'); return false;"> <img src="/semi2/resources/images/design/album-play.png" class="play-default"> <img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
						</a>
					</div>
				</div>
				<div class="gallery-card-album-name">
					<a
						href="/semi2/playlist/details.jsp?playlistid=<%=playlistPreview.getPlaylistId()%>"><%=playlistPreview.getPlaylistName()%></a>
				</div>
				<div class="gallery-card-artist-name-myplaylist">
					<div>
						<img src="/semi2/resources/images/design/likes-icon.png"
							width="15">&nbsp;<%=playlistPreview.getLikeCount()>=1000?playlistPreview.getLikeCount()/1000+"K":playlistPreview.getLikeCount()%>
						|
						<%=playlistPreview.getSongCount()%>곡 |
						<%=playlistPreview.getCreatedAt().toString().substring(0, 10)%>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</section>

	<%
	if (isArtist) {
	%>

	<section>
		<div class="blank"></div>
		<div class="categorey-name">
			<h2>이 아티스트의 최신 앨범</h2>
		</div>
		<div class="gallery">
			<%
			// 플레이리스트 하나씩 나열
			for (int i = 0; i < Math.min(sortedAlbums.size(), MAX_ALBUMS_LENGTH); i++) {
				StringBuffer genre = new StringBuffer();
				Album albumDto = sortedAlbums.get(i).getAlbumDto();
				genre.append(albumDto.getGenre1() == null ? "" : albumDto.getGenre1());
				genre.append(" ");
				genre.append(albumDto.getGenre2() == null ? "" : albumDto.getGenre2());
				genre.append(" ");
				genre.append(albumDto.getGenre3() == null ? "" : albumDto.getGenre3());
			%>
			<div class="gallery-card">
				<div class="gallery-card-album-image-group">
				<a href="/semi2/chart/album-details.jsp?albumid=<%=sortedAlbums.get(i).getAlbumDto().getId() %>"> <img src="/semi2/resources/images/album/<%=sortedAlbums.get(i).getAlbumDto().getId()%>/cover.jpg"  class="gallery-card-album-image" /></a>
					<div class="gallery-card-album-image-play">
						<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?albumid=<%=sortedAlbums.get(i).getAlbumDto().getId()%>'); return false;"> 
						<img src="/semi2/resources/images/design/album-play.png" class="play-default"> <img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
						</a>
					</div>
				</div>
				<div class="gallery-card-album-name">
					<a href="/semi2/chart/album-details.jsp?albumid=<%=sortedAlbums.get(i).getAlbumDto().getId()%>"> <%=sortedAlbums.get(i).getAlbumDto().getName()%></a>
				</div>

				<div class="gallery-card-artist-name-myplaylist">
					<div>
						<%=genre.toString().trim()%>
						<br>
						<%=sortedAlbums.get(i).getAlbumDto().getCreatedAt().toString().substring(0, 10)%>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</section>
	<%
	}
	%>
	<%@ include file="/footer.jsp"%>
</body>
</html>