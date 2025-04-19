<%@page import="com.plick.playlist.PlaylistPreviewDto"%>
<%@page import="java.util.List"%>
<%@page import="com.plick.playlist.mylist.PlaylistMylistDao"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function showAlertAndGoLoginPage(message) {
		window.alert(message);
		if (window.parent && typeof window.parent.closeModal === 'function') {
			window.parent.closeModal();
		} else {
			window.close();
		}
	}
	function showAlertAndGoBack(message) {
		window.alert(message);
		if (window.parent && typeof window.parent.closeModal === 'function') {
			window.parent.closeModal();
		} else {
			window.close();
		}
	}
	function confirmAction(message) {
		return confirm(message);
	}

	function showAddForm() {
		document.getElementById("addForm").style.display = "block";
		document.getElementById("addButtonArea").style.display = "none";
	}

	function hideAddForm() {
		document.getElementById("addForm").style.display = "none";
		document.getElementById("addButtonArea").style.display = "flex";
	}
</script>
<style>
/*폰트 세팅*/
@font-face {
	font-family: 'Noto Sans KR';
	src: url('/semi2/resources/fonts/NotoSansKR-Regular.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

/*기본 세팅*/
body {
	background: #131313;
	color: white;
	margin: 0;
	font-family: 'Noto Sans KR', sans-serif;
	padding: 0 0 30px 30px; /* 좌우 여백 추가 */
	box-sizing: border-box;
	overflow-x: hidden; /* 가로 스크롤 방지 */
}

/*링크 세팅*/
a {
	color: white;
	text-decoration: none;
}

/* 모달 컨테이너 */
.modal-container {
	width: 100%;
	max-height: 90vh;
	overflow-y: auto;
	box-sizing: border-box;
	padding-right: 10px;
	padding-bottom: 20px; /* 아래 빈 공간 제거용 */
}

/* 스크롤바 스타일 */
.modal-container::-webkit-scrollbar {
	width: 10px;
}

.modal-container::-webkit-scrollbar-thumb {
	background-color: #444;
	border-radius: 5px;
}

.modal-container::-webkit-scrollbar-track {
	background-color: #222;
}

/* 리스트 하나 */
.playlist-item {
	display: flex;
	align-items: center;
	padding: 6px 0;
	margin-bottom: 4px;
	border-radius: 6px;
	transition: color 0.2s ease;
	cursor: pointer;
	width: 100%;
	box-sizing: border-box;
	overflow: hidden;
}

/* hover 시 텍스트만 핑크로 */
.playlist-item:hover {
	color: #ff2dac;
}

/* 커버 이미지 */
.playlist-cover {
	width: 70px;
	height: 70px;
	object-fit: cover;
	margin-right: 20px;
	border-radius: 12px;
	background-color: #333;
	flex-shrink: 0;
}

/* 텍스트 영역 */
.playlist-info {
	display: flex;
	flex-direction: column;
	overflow: hidden;
}

/* 플레이리스트 제목 */
.playlist-info a {
	color: inherit;
	text-decoration: none;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* 곡 수 표시 */
.playlist-info span {
	display: block;
	font-size: 12px;
	color: #bbb;
}

.add-playlist-text {
	color: white;
	font-size: 16px;
	margin-bottom: 10px;
	transition: color 0.2s ease;
}

.add-playlist-text:hover {
	color: hotpink;
}

/* 입력창 줄 */
.add-form-row {
	display: flex;
	align-items: center;
	gap: 6px;
	margin-bottom: 16px;
}

/* 텍스트 필드 */
.add-form-row input[type="text"] {
	flex: 1;
	padding: 6px 10px;
	border: none;
	border-radius: 4px;
	background-color: #222;
	color: white;
	outline: none;
}

/* 버튼 공통 스타일 */
.plain-btn {
	background: none;
	border: none;
	color: white;
	cursor: pointer;
	font-size: 14px;
	transition: color 0.2s ease;
	padding: 4px 6px;
}

.plain-btn:hover {
	color: hotpink;
}
</style>
</head>
<%
SignedinDto loggedinUser = (SignedinDto) session.getAttribute("signedinDto");

if (loggedinUser == null || loggedinUser.getMemberId() == 0) {
%>
<script>
	showAlertAndGoLoginPage("로그인이 필요합니다");
</script>
<%
return;
}
%>
<%
String songIdParam = request.getParameter("songid");
String albumIdParam = request.getParameter("albumid");
String playlistIdParam = request.getParameter("playlistid");

boolean existsSongId = songIdParam == null || songIdParam.isEmpty() ? false : true;
boolean existsAlbumId = albumIdParam == null || albumIdParam.isEmpty() ? false : true;
boolean existsPlaylistId = playlistIdParam == null || playlistIdParam.isEmpty() ? false : true;

String type = "";
String idParam = "";
int id = -1;

if (existsSongId) {
	type = "song";
	idParam = songIdParam;
} else if (existsAlbumId) {
	type = "album";
	idParam = albumIdParam;
} else if (existsPlaylistId) {
	type = "playlist";
	idParam = playlistIdParam;
} else {
%>
<script>
	showAlertAndGoBack("파라미터가 유효하지 않습니다.");
</script>
<%
return;
}

try {
id = Integer.parseInt(idParam);
} catch (NumberFormatException e) {
%>
<script>
	showAlertAndGoBack("잘못된 접근: 파라미터에 정수만 전달가능합니다.");
</script>
<%
}
%>
<%
int loggedinUserId = loggedinUser.getMemberId();
PlaylistMylistDao playlistMylistDao = new PlaylistMylistDao();
List<PlaylistPreviewDto> playlistPreviews = playlistMylistDao
		.findPlaylistPreviewsOrderByCreatedAtByMemberId(loggedinUserId);
%>
<body>
	<div class="modal-container">

		<div id="addPlaylistSection">

			<div id="addButtonArea" class="playlist-item" onclick="showAddForm()"
				style="cursor: pointer;">
				<img class="playlist-cover"
					src="/semi2/resources/images/playlist/add-playlist.jpg" /> <a
					href="#" class="add-playlist-text">새 플레이리스트 추가</a>
			</div>

			<!-- 입력창 (처음엔 숨김) -->
			<form id="addForm" action="popup-list-form_ok.jsp" method="get"
				style="display: none;">
				<div class="add-form-row">
					<input type="text" id="playlistNameText" name="playlistName"
						placeholder="플레이리스트 이름을 정해주세요."
						value="<%=playlistPreviews.size() + 1%>번 플레이리스트" />

					<button type="button" class="plain-btn"
						onclick="document.getElementById('playlistNameText').value = '';">X</button>
					<input type="hidden" name="id" value="<%=id%>" /> <input
						type="hidden" name="type" value="<%=type%>" />
					<button type="button" class="plain-btn" onclick="hideAddForm()">취소</button>
					<button type="submit" class="plain-btn">확인</button>
				</div>
			</form>
		</div>


		<%
		for (PlaylistPreviewDto playlistPreview : playlistPreviews) {
		%>
		<div class="playlist-item"
			onclick="location.href='popup-add-song_ok.jsp?type=<%=type%>&id=<%=id%>&playlistid=<%=playlistPreview.getPlaylistId()%>'">
			<img class="playlist-cover"
				src="/semi2/resources/images/<%=playlistPreview.getFirstAlbumId() == 0 ? "playlist/default-cover.jpg"
		: "album/" + playlistPreview.getFirstAlbumId() + "/cover.jpg"%>" />
			<div class="playlist-info">
				<a
					href="popup-add-song_ok.jsp?type=<%=type%>&id=<%=id%>&playlistid=<%=playlistPreview.getPlaylistId()%>">
					<%=playlistPreview.getPlaylistName()%>
				</a> <span><%=playlistPreview.getSongCount()%>곡</span>
			</div>
		</div>
		<%
		}
		%>
	</div>
</body>

</html>