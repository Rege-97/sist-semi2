
<%@page import="com.plick.mypage.SongDto"%>
<%@page import="com.plick.mypage.MypageDto"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.album.AlbumDto"%>
<%@page import="com.plick.album.SongsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/mypage/mypage-header.jsp"%>
	<div class=profile-change-card>
<%
if (request.getParameter("songId")==null){
%>
	<div class="subtitle">
			<h2>수록곡 등록</h2>
	</div>
	<form action = "song-form_ok.jsp" method = "post" enctype = "multipart/form-data">
	<audio id="audio" controls></audio>
	<input type = "button" value = "오디오 추가" onclick = "clickFile(this);">
	<input style="display: none;" type="file" id="audioFile" name = "audioFile" accept="audio/mpeg" onchange = "changeAudio(this);">
	<input type = "hidden" name = "song" id = "songHidden">
	<div>
	<input type = "text" name = "name" placeholder="곡 이름" class="login-text">
	</div>
	<div>
	<input type = "text" name = "composer" placeholder="작곡" class="login-text">
	</div>
	<div>
	<input type = "text" name = "lyricist" placeholder="작사" class="login-text">
	</div>
	<div>
	<input type = "text" name = "lyrics" placeholder="가사" class="login-text">
	</div>
	<div>
	</div>
	<div>
	<input type = "submit" value = "곡 등록" class="bt">
	</div>
	</form>
<%
}else{
	MypageDao mypageDao = new MypageDao();
	SongDto songDto = mypageDao.findSong(Integer.parseInt(request.getParameter("songId")));
%>
	<div class="subtitle">
			<h2>수록곡 수정</h2>
	</div>
	<form action = "song-form_ok.jsp?songId=<%=songDto.getId() %>" method = "post" enctype = "multipart/form-data">
	<audio id="audio" src = "/semi2/resources/songs/<%=session.getAttribute("albumId").toString() %>/<%=songDto.getId() %>" controls></audio>
	<input type = "button" value = "오디오 추가" onclick = "clickFile(this);">
	<input style="display: none;" type="file" id="audioFile" name = "audioFile" accept="audio/mpeg" onchange = "changeAudio(this);">
	<input type = "hidden" name = "song" id = "songHidden">
	<div>
	<input type = "text" name = "name" value = "<%=songDto.getName() %>" class="login-text">
	</div>
	<div>
	<input type = "text" name = "composer" value = "<%=songDto.getComposer() %>" class="login-text">
	</div>
	<div>
	<input type = "text" name = "lyricist" value = "<%=songDto.getLyricist() %>" class="login-text">
	</div>
	<div>
	<input type = "text" name = "lyrics" value = "<%=songDto.getLyrics() %>" class="login-text">
	</div>
	<div>
	</div>
	<div>
	<input type = "submit" value = "곡 수정" class="bt">
	</div>
	</form>
<% 
}
%>
</div>
	<jsp:include page="/footer.jsp"></jsp:include>
<script>
var audioFile = document.getElementById("audioFile");
var audio = document.getElementById("audio");
// 히든 컴포넌트 매핑
function clickFile(bt) {
	bt.value = "곡 변경";
	audioFile.click();
}

// 오디오 등록시 오디오 컨트롤러에 표시
function changeAudio(song) {
	var file = song.files[0];
	if(file){
		var reader = new FileReader();
		reader.onload = function(e) {
			audio.src = e.target.result;
        };
        reader.readAsDataURL(file);
    } else {
        alert("파일을 선택하지 않았습니다.");
    }
}
</script>
</body>
</html>