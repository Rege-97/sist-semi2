<%@page import="com.plick.playlist.PlaylistPreviewDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.plick.playlist.main.PlaylistMainDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!// 각 리스트(최신순, 인기순)에 최대 몇개를 가져올지 설정
	static final int PREVIEW_MAX_COUNT = 10;%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<%
PlaylistMainDao playlistMainDao = new PlaylistMainDao();
// 최신순 인기순 리스트를 한번에 받아오는 메서드, 결과가 없을시 map 객체에는 빈 Arraylist들이 들어가 있음. 예외발생시 빈 map 객체를 반환함. 
Map<String, List<PlaylistPreviewDto>> previews = playlistMainDao.findRecommendedPlaylistsByLimit(PREVIEW_MAX_COUNT);
// 최신순 리스트가 최대 PREVIEW_MAX_COUNT 만큼 들어있음, 없으면 빈 리스트임.
List<PlaylistPreviewDto> latestPreviews = previews.get("latest");
// 최신순 리스트가 최대 PREVIEW_MAX_COUNT 만큼 들어있음, 없으면 빈 리스트임.
List<PlaylistPreviewDto> popularPreviews = previews.get("popular");
%>
<body>
	<%@include file="/header.jsp"%>
	<input type="button" value="내 플레이리스트" class="bt" onclick="location.href='/semi2/playlist/mylist/main.jsp'">
	<article>
		<div class="categorey-name">
			<label> 인기 플레이리스트 </label>
		</div>
		<div class="gallery">
			<%
			if (popularPreviews == null || popularPreviews.size() == 0) {
			%>
			불러올 정보가 없습니다.
			<%
			} else {

			for (PlaylistPreviewDto popularPreview : popularPreviews) {
			%>
			<div class="gallery-card">
				<div class="gallery-card-album-image-group">
					<a
						href="/semi2/playlist/details.jsp?playlistid=<%=popularPreview.getPlaylistId()%>">
						<img src="/semi2/resources/images/<%=popularPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg" : "album/" + popularPreview.getFirstAlbumId() + "/cover.jpg"%>" class="gallery-card-album-image" />
					</a>
					<div class="gallery-card-album-image-play">
					<a href="#">
					<img src="/semi2/resources/images/design/album-play.png" class="play-default">
					<img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
					</a>
					</div>
				</div>
				<div class ="gallery-card-album-name">
					<label><a href="/semi2/playlist/details.jsp?playlistid=<%=popularPreview.getPlaylistId()%>"><%=popularPreview.getPlaylistName()%></a></label>
				</div>
				<div class="gallery-card-artist-name">
					<%=popularPreview.getMemberNickname()%>
					|
					<%=popularPreview.getSongCount()%>곡
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</article>

	<article>
		<div class="categorey-name">
			<label> 최신 플레이리스트 </label>
		</div>
		<div class="gallery">
			<%
			if (latestPreviews == null || latestPreviews.size() == 0) {
			%>
			불러올 정보가 없습니다.
			<%
			} else {

			for (PlaylistPreviewDto latestPreview : latestPreviews) {
			%>
			<div class="gallery-card">
				<div class="gallery-card-album-image-group">
					<a href="/semi2/playlist/details.jsp?playlistid=<%=latestPreview.getPlaylistId()%>">
						<img src="/semi2/resources/images/<%=latestPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg" : "album/" + latestPreview.getFirstAlbumId() + "/cover.jpg"%>"  class="gallery-card-album-image" />
					</a>
					<div class="gallery-card-album-image-play">
					<a href="#">
					<img src="/semi2/resources/images/design/album-play.png" class="play-default">
					<img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
					</a>
					</div>
				</div>
				<div class ="gallery-card-album-name">
					<label><a
						href="/semi2/playlist/details.jsp?playlistid=<%=latestPreview.getPlaylistId()%>"><%=latestPreview.getPlaylistName()%></a></label>
				</div>
				<div class="gallery-card-artist-name">
					<%=latestPreview.getMemberNickname()%>
					|
					<%=latestPreview.getSongCount()%>곡
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</article>
	<%@include file="/footer.jsp"%>
</body>
</html>