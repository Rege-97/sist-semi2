<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plick.chart.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
<%
String genre = request.getParameter("genre");

ArrayList<TrackDto> arr = null;
String title = null;

if (genre == null) {
	genre="전체";
	arr = cdao.allChartList();
	title = "인기차트 TOP 100";
} else {
	arr = cdao.genreChartList(genre);
	title = genre + " TOP 30";
}
%>
<script>
	function moreList() {
		const rows = document.querySelectorAll('.morelist2');

		for (var i = 0; i < rows.length; i++) {
			if (rows[i].style.display == 'none') {
				rows[i].style.display = 'table-row-group';
			} else {
				rows[i].style.display = 'none';
			}
		}

		const more = document.getElementById('more');

		if (more.value == '더보기') {
			more.value = '더보기 접기';
		} else {
			more.value = '더보기';
		}
	}
</script>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<div class="body-content">
	<section>
		<article>
			<ul class="detail-menu">
				<li><a href="/semi2/chart/main.jsp" class="<%= genre.equals("전체")?"detail-menu-active":"none"%>">전체차트</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=발라드" class="<%= genre.equals("발라드")?"detail-menu-active":"none"%>">발라드</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=알앤비" class="<%= genre.equals("알앤비")?"detail-menu-active":"none"%>">알앤비</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=힙합" class="<%= genre.equals("힙합")?"detail-menu-active":"none"%>">힙합</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=아이돌" class="<%= genre.equals("아이돌")?"detail-menu-active":"none"%>">아이돌</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=재즈" class="<%= genre.equals("재즈")?"detail-menu-active":"none"%>">재즈</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=팝" class="<%= genre.equals("팝")?"detail-menu-active":"none"%>">팝</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=클래식" class="<%= genre.equals("클래식")?"detail-menu-active":"none"%>">클래식</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=댄스" class="<%= genre.equals("댄스")?"detail-menu-active":"none"%>">댄스</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=인디" class="<%= genre.equals("인디")?"detail-menu-active":"none"%>">인디</a></li>
				<li><a href="/semi2/chart/main.jsp?genre=락" class="<%= genre.equals("락")?"detail-menu-active":"none"%>">락</a></li>
			</ul>
		</article>
		<article>
		<iframe name="hiddenFrame" style="display: none;"></iframe>
			<div class="all-play-bt-div">
			<h1 class="categorey-name"><%=title%></h1>
			<div class="all-play-bt">
			<input type="button" value="전체듣기" class="bt" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?genre=<%=genre%>'); return false;">
			</div>
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
						<th>순위</th>
						<th colspan="2">곡/앨범</th>
						<th>아티스트</th>
						<th>듣기</th>
						<th>내 리스트</th>
						<th>다운로드</th>
					</tr>
				</thead>
				<%
				if (arr == null || arr.size() == 0) {
				%>
				<tbody>
					<tr>
						<td colspan="6">차트가 존재하지 않습니다.</td>
					</tr>
				</tbody>
				<%
				} else {
				for (int i = 0; i < arr.size(); i++) {
					if (i < 30) {
				%>
				<tbody>
					<tr class="song-list-body">
						<td>
							<div class="song-list-row"><%=arr.get(i).getRnum()%></div>
						</td>
						<td>
							<div class="song-list-album-image">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(i).getAlbumId()%>"><img src="/semi2/resources/images/album/<%=arr.get(i).getAlbumId()%>/cover.jpg" class="song-list-album-image"></a>
							</div>
						</td>
						<td>
							<div class="song-list-song-name">
								<a href="/semi2/chart/song-details.jsp?songid=<%=arr.get(i).getId()%>"><%=arr.get(i).getName()%></a>
							</div>
							<div class="song-list-album-name">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(i).getAlbumId()%>"><%=arr.get(i).getAlbumName()%></a>
							</div>
						</td>
						<td>
							<div class="song-list-artist-name">
								<a href="/semi2/artist/main.jsp?memberid=<%=arr.get(i).getMemberId()%>"><%=arr.get(i).getArtist()%></a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?songid=<%=arr.get(i).getId()%>'); return false;">
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openModal('songid',<%=arr.get(i).getId()%>); return false;">
								<img src="/semi2/resources/images/design/add-list-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/add-list-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="/semi2/chart/download-song.jsp?songid=<%=arr.get(i).getId()%>&songname=<%=arr.get(i).getName() %>&albumid=<%=arr.get(i).getAlbumId()%>&artist=<%=arr.get(i).getArtist()%>" target="hiddenFrame">
								<img src="/semi2/resources/images/design/download-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/download-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
					</tr>
				</tbody>

				<%
				} else {
				%>

				<tbody class="morelist2" style="display: none;">
					<tr class="song-list-body">
						<td>
							<div class="song-list-row"><%=arr.get(i).getRnum()%></div>
						</td>
						<td>
							<div class="song-list-album-image">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(i).getAlbumId()%>"><img src="/semi2/resources/images/album/<%=arr.get(i).getAlbumId()%>/cover.jpg" class="song-list-album-image"></a>
							</div>
						</td>
						<td>
							<div class="song-list-song-name">
								<a href="/semi2/chart/song-details.jsp?songid=<%=arr.get(i).getId()%>"><%=arr.get(i).getName()%></a>
							</div>
							<div class="song-list-album-name">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(i).getAlbumId()%>"><%=arr.get(i).getAlbumName()%></a>
							</div>
						</td>
						<td>
							<div class="song-list-artist-name">
								<a href="/semi2/artist/main.jsp?memberid=<%=arr.get(i).getMemberId()%>"><%=arr.get(i).getArtist()%></a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?songid=<%=arr.get(i).getId()%>'); return false;">
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openModal('songid',<%=arr.get(i).getId()%>); return false;">
								<img src="/semi2/resources/images/design/add-list-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/add-list-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#">
								<img src="/semi2/resources/images/design/download-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/download-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
					</tr>
				</tbody>
				<%
				}
				}
				}
				%>

			</table>
			<%
			if (genre.equals("전체")) {
			%>
			<div class="bt_div">
				<input type="button" class="bt" id="more" value="더보기" onclick="moreList()">
			</div>
			<%
			}
			%>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
	</div>
</body>
</html>