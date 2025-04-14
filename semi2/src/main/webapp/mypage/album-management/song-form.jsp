<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
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
<%
request.setCharacterEncoding("UTF-8");
// 첫 서밋이면 album-form에서 요청된 데이터들 처리
if(request.getParameter("first") != null){
%>
<jsp:useBean id="albumDto" class="com.plick.album.AlbumDto"></jsp:useBean>
<jsp:setProperty property="*" name="albumDto"/>
<%
// select 박스로 조합된 날짜 파싱 후 releasedAt 생성
SimpleDateFormat format = new SimpleDateFormat("yyyy-M-d");
String releaseDate = request.getParameter("year")+request.getParameter("month")+request.getParameter("date");
releaseDate = releaseDate.replace("년", "-");
releaseDate = releaseDate.replace("월", "-");
releaseDate = releaseDate.replace("일", "");
Date parseDate = format.parse(releaseDate);
Timestamp releasedAt = new Timestamp(parseDate.getTime());
albumDto.setReleasedAt(releasedAt);
// 세션에 value 세팅 된 albumDto 올림
session.setAttribute("albumDto", albumDto);
// 세션에서 들고 다니면서 곡이 추가 될 때마다 list에 추가할 arraylist 생성
session.setAttribute("SongsDtos", new ArrayList<SongsDto>());
}else{// 첫 방문이 아니면 이전 페이지에서 넘어온 song의 데이터 처리
%>
<jsp:useBean id="songsDto" class="com.plick.album.SongsDto"></jsp:useBean>
<%
AlbumDto aDto = (AlbumDto) session.getAttribute("albumDto");
// 액션태그 사용시 조건문과 상관 없이 property를 처리하려고 해서 오류 발생해서 직접 세팅해줌
songsDto.setAlbum_id(aDto.getId());
songsDto.setName(request.getParameter("name"));
songsDto.setComposer(request.getParameter("composer"));
songsDto.setLyricist(request.getParameter("lyricist"));
songsDto.setLyrics(request.getParameter("lyrics"));
ArrayList<SongsDto> songsDtos = (ArrayList<SongsDto>) session.getAttribute("SongsDtos");
songsDtos.add(songsDto);
}
%>

<script>
function nextsong(b){
	window.alert("다음 곡을 추가하시겠습니까?");
	var form = b.form;
	form.action = "song-form.jsp";
	form.submit();
}
function add_album(b){
	window.alert("앨범을 등록하시겠습니까?");
	var form = b.form;
	form.action = "/semi2/mypage/album-management/album-form_ok.jsp";
	form.submit();
}
</script>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/mypage/mypage-header.jsp"%>
	<div class=profile-change-card>
	<div class="subtitle">
			<h2>수록곡 등록</h2>
		</div>
	<form>
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
	<audio src="" name = ""></audio>
	</div>
	<div>
	<input type = "button" value = "다음 곡 추가" onclick = "nextsong(this);" class="bt">
	<input type = "button" value = "앨범 등록" onclick = "add_album(this);" class="bt">
	</div>
	</form>
</div>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>