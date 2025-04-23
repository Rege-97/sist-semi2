<%@page import="com.plick.chart.SongDetailDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.plick.dto.*"%>
<jsp:useBean id="sdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">

<%
String id_s = request.getParameter("songid");

if (id_s == null || id_s.equals("")) {
	id_s = "0";
}

int id = Integer.parseInt(id_s);

SongDetailDto dto = sdao.findSong(id);
%>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<div class="body-content">
	<section>
		<article>
		<iframe name="hiddenFrame" style="display: none;"></iframe>
			<div class="detail-card">
				<img src="/semi2/resources/images/album/<%=dto.getAlbumId()%>/cover.jpg" class="detail-card-image">
				<div class="detail-card-info">
					<div class="detail-card-info-name">
						<h2><%=dto.getName()%></h2>
					</div>
					<div class="detail-card-info-song-artist-name">
						<a href="/semi2/artist/main.jsp?memberid=<%=dto.getMemberId()%>"><%=dto.getArtist()%></a>
					</div>
					<div class="detail-card-info-album"><a href="/semi2/chart/album-details.jsp?albumid=<%=dto.getAlbumId()%>"><%=dto.getAlbumName() %> ></a></div>
					<div class="detail-card-info-icon">
						<div class="icon-group">
							<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?songid=<%=dto.getId()%>'); return false;">
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
							</a>
						</div>
						<div class="icon-group">
							<a href="#" onclick="openModal('songid',<%=dto.getId()%>); return false;">
								<img src="/semi2/resources/images/design/add-list-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/add-list-icon-hover.png" class="icon-hover">						
							</a>
						</div>
						<div class="icon-group">
							<a href="/semi2/chart/download-song.jsp?songid=<%=dto.getId()%>&songname=<%=dto.getName() %>&albumid=<%=dto.getAlbumId()%>&artist=<%=dto.getArtist()%>" target="hiddenFrame">
								<img src="/semi2/resources/images/design/download-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/download-icon-hover.png" class="icon-hover">
							</a>
						</div>
					</div>
				</div>
			</div>
		</article>
		<article>
			<table class="song-detail-table">
				<tr>
					<th>곡명</th>
					<td><%=dto.getName() %></td>
				</tr>
				<tr>
					<th>작곡</th>
					<td><%=dto.getComposer()==null?"":dto.getComposer() %></td>
				</tr>
				<tr>
					<th>작사</th>
					<td><%=dto.getLyricist()==null?"":dto.getLyricist() %></td>
				</tr>
				<tr class="lyrics">
					<td colspan="2"><br><%=dto.getLyrics().replaceAll("\n", "<br>")%></td>
				</tr>
			</table>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
	</div>
</body>
</html>