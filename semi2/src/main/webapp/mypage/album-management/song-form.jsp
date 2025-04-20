
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
<style>
#lyrics {
	display: block;
	margin: 0 auto;
	width: 300px;
	height: 300px;
	resize: none;
	border: 1px solid #666666;
	border-radius: 8px;
}
textarea::-webkit-scrollbar {
    display: none; /* 스크롤바 숨기기 */
}
</style>
	<%
	if(session.getAttribute("signedinDto")==null){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}else if(((SignedinDto) session.getAttribute("signedinDto")).getMemberId() == 0){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}
	%>
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
		<div class="blank"></div>
	<form action = "song-form_ok.jsp?albumId=<%=request.getParameter("albumId") %>" method = "post" enctype = "multipart/form-data">
	<audio id="audio" controls></audio>
		<div class="blank3"></div>
	<div>
	<input type = "button" value = "수록곡 추가" onclick = "clickFile(this);" class="bt" id="addsong">
	</div>
			<div class="blank3"></div>
	<input style="display: none;" type="file" id="audioFile" required name = "audioFile" accept="audio/mpeg" onchange = "changeAudio(this);">
	<input type = "hidden" name = "song" id = "songHidden">
	<div>
	<input type = "text" name = "name" required placeholder="곡 이름" class="login-text">
	</div>
	<div>
	<input type = "text" name = "composer" required placeholder="작곡" class="login-text">
	</div>
	<div>
	<input type = "text" name = "lyricist" required placeholder="작사" class="login-text">
	</div>
			<div class="blank3"></div>
	<div>
	<textarea  style = "resize: none;" name = "lyrics" required id = "lyrics" rows = "10" cols = "70" maxlength = "255" placeholder="가사" class="login-text"></textarea>
	</div>
	<div>
	</div>
			<div class="blank"></div>
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
	<form action = "song-form_ok.jsp?songId=<%=songDto.getId() %>&albumId=<%=request.getParameter("albumId") %>" method = "post" enctype = "multipart/form-data">
	<audio id="audio" src = "/semi2/resources/songs/<%=request.getParameter("albumId") %>/<%=songDto.getId() %>.mp3" controls></audio>
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
	<textarea  style = "resize: none;" name = "lyrics" id = "lyrics" rows = "10" cols = "70" maxlength = "255" placeholder="가사" class="login-text"><%=songDto.getLyrics() %></textarea>
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
	audioFile.click();
}

// 오디오 등록시 오디오 컨트롤러에 표시
function changeAudio(song) {
	var file = song.files[0];
	const bt = document.getElementById("addsong");
	if(file){
		var reader = new FileReader();
		reader.onload = function(e) {
			audio.src = e.target.result;
        };
        reader.readAsDataURL(file);
    	bt.value = "곡 변경";
    } else {
        window.alert("파일을 선택하지 않았습니다.");
    }
}
</script>
</body>
</html>