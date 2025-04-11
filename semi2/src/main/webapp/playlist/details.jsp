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
	function toggleEdit(event) {
		event.preventDefault();
		document.getElementById("name-text").style.display = "none";
		document.getElementById("name-input").style.display = "inline";
		document.getElementById("confirm-btn").style.display = "inline";
		document.getElementById("cancel-btn").style.display = "inline";
		document.getElementById("edit-icon-link").style.display = "none";
		document.getElementById("name-input").focus();
	}

	function cancelEdit() {
		const text = document.getElementById("name-text");
		const input = document.getElementById("name-input");

		input.value = text.innerText; // 원래 값 복원
		input.style.display = "none";
		text.style.display = "inline";
		document.getElementById("confirm-btn").style.display = "none";
		document.getElementById("cancel-btn").style.display = "none";
		document.getElementById("edit-icon-link").style.display = "inline";
	}
    function toggleMoodEdit(e) {
        e.preventDefault();
        document.getElementById('mood-display').style.display = 'none';
        document.getElementById('mood-edit-section').style.display = 'block';
      }

      function cancelMoodEdit() {
        document.getElementById('mood-display').style.display = 'block';
        document.getElementById('mood-edit-section').style.display = 'none';
      }

</script>
<style>
#name-input {
	background-color: black;
	color: white;
	border: none;
	border-bottom: 1px solid white;
	font-size: inherit;
	width: auto;
}

#confirm-btn, #cancel-btn {
	background: none;
	border: none;
	color: white;
	font-size: 14px;
	cursor: pointer;
	margin-left: 5px;
}

#edit-icon {
	vertical-align: middle;
}
</style>
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
//로그인 한 유저가 이 플레이리스트의 소유자인지 확인, 수정권한을 부여하기 위함
SignedinDto loggedinUser = (SignedinDto) session.getAttribute("signedinDto");
int loggedinUserId = loggedinUser == null || loggedinUser.getMemberId() == 0 ? -1 : loggedinUser.getMemberId();
boolean isOwnedPlaylist = loggedinUserId == playlistDetailDto.getMemberId() ? true : false;
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
						<%
						String playlistName = playlistDetailDto.getPlaylistName();
						%>
						<h2 id="playlist-name">
							<%
							if (isOwnedPlaylist) {
							%>
							<form id="edit-form" method="get" action="name-update_ok.jsp"
								style="display: inline;">
								<span id="name-text" style="color: white;"><%=playlistName%></span>
								<input type="text" name="playlistname" id="name-input"
									value="<%=playlistName%>" style="display: none;" /> <input
									type="hidden" name="playlistid" value="<%=playlistId%>" />

								<!-- 확인/취소 버튼 -->
								<button type="submit" id="confirm-btn" style="display: none;">확인</button>
								<button type="button" id="cancel-btn" style="display: none;"
									onclick="cancelEdit()">취소</button>

								<!-- 편집 아이콘 -->
								<a href="#" id="edit-icon-link" onclick="toggleEdit(event)">
									<img id="edit-icon"
									src="/semi2/resources/images/design/playlist-edit.png"
									width="25" height="25" />
								</a>
							</form>
							<%
							} else {
							%>
							<%=playlistName%>
							<%
							}
							%>
						</h2>
					</div>
					<div class="detail-card-info-artist-name">
						<a
							href="/semi2/artist/main.jsp?memberid=<%=playlistDetailDto.getMemberId()%>"><%=playlistDetailDto.getNickname()%></a>
					</div>
					<div class="detail-card-info-genre">
						<%
						if (isOwnedPlaylist) {
							String[] selectedMoods = mood.toString().trim().split(" ");
							Set<String> selectedSet = new HashSet<>(Arrays.asList(selectedMoods));
							String[] allMoods = {"신나는", "잔잔한", "감성적인", "슬플 때", "달달한", "상쾌한", "몽환적인"};
						%>

						<form id="mood-form" method="get" action="mood-update_ok.jsp"
							style="display: inline;">
							<div id="mood-display">
								<%=mood.toString().trim()%>
								<a href="#" id="edit-mood-link" onclick="toggleMoodEdit(event)">
									<img src="/semi2/resources/images/design/playlist-edit.png"
									width="20" height="20" />
								</a>
							</div>

							<div id="mood-edit-section" style="display: none;">
								<%
								for (String m : allMoods) {
								%>
								<label style="color: white; margin-right: 8px;"> <input
									type="checkbox" name="mood" value="<%=m%>"
									<%=selectedSet.contains(m.trim()) ? "checked" : ""%> /> <%=m%>
								</label>
								<%
								}
								%>

								<input type="hidden" name="playlistid" value="<%=playlistId%>" />
								<button type="submit" id="confirm-btn">확인</button>
								<button type="button" id="cancel-btn"
									onclick="cancelMoodEdit()">취소</button>
							</div>
						</form>
		<script>
	    // 최대 2개 선택 제한
	    document.querySelectorAll('input[name="mood"]').forEach(cb => {
	      cb.addEventListener('change', () => {
	        const checked = document.querySelectorAll('input[name="mood"]:checked');
	        if (checked.length > 2) {
	          alert("분위기는 최대 2개까지만 선택할 수 있습니다.");
	          cb.checked = false;
	        }
	      });
	    });
	  </script>


						<%
						} else {
						%>
						<%=mood.toString().trim()%>
						<%
						}
						%>
					</div>
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
					<%
					if (isOwnedPlaylist) {
					%>
					<col style="width: 40px;">
					<!-- 삭제 -->
					<%
					}
					%>

				</colgroup>
				<thead>
					<tr class="song-list-head">
						<th>순번</th>
						<th colspan="2">곡/앨범</th>
						<th>아티스트</th>
						<th>듣기</th>
						<th>내 리스트</th>
						<th>다운로드</th>
						<%
						if (isOwnedPlaylist) {
						%>
						<th>삭제</th>
						<%
						}
						%>
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
							<div class="song-list-row"><%=sortedSongs.get(i).getTurn()%></div>
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
						<%
						if (isOwnedPlaylist) {
						%>
						<td>
							<div class="icon-group">
								<a
									href="song-delete_ok.jsp?playlistid=<%=sortedSongs.get(i).getPlaylistId()%>&playlistsongid=<%=sortedSongs.get(i).getId()%>&turn=<%=sortedSongs.get(i).getTurn()%>"
									onclick="return confirm('정말 삭제하시겠습니까?');"> <img
									src="/semi2/resources/images/design/playlist-delete.png"
									class="icon-default"> <img
									src="/semi2/resources/images/design/playlist-delete-hover.png"
									class="icon-hover">
								</a>
							</div>
						</td>
						<%
						}
						%>
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