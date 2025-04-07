<%@page import="com.plick.album.AlbumDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
System.out.println("00");
if(request.getParameter("first") != null){
%>
<jsp:useBean id="albumDto" class="com.plick.album.AlbumDto"></jsp:useBean>
<jsp:setProperty property="*" name="albumDto"/>
<%
session.setAttribute("albumDto", albumDto);
}else{
%>
<jsp:useBean id="songsDto" class="com.plick.album.SongsDto"></jsp:useBean>
<%
songsDto.setName(request.getParameter("name"));
songsDto.setComposer(request.getParameter("composer"));
songsDto.setLyricist(request.getParameter("lyricist"));
songsDto.setLyrics(request.getParameter("lyrics"));
AlbumDto aDto = (AlbumDto) session.getAttribute("albumDto");
aDto.setSongsdto(songsDto);
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
<body>
<fieldset>
	<form>
	<input type = "text" name = "name" placeholder="곡 이름">
	<input type = "text" name = "composer" placeholder="작곡">
	<input type = "text" name = "lyricist" placeholder="작사">
	<input type = "text" name = "lyrics" placeholder="가사">
	<audio src="" name = ""></audio>
	<select>
	<option disabled selected>장르선택</option>
	<option>장르1</option>
	<option>장르2</option>
	<option>장르3</option>
	</select>
	<input type = "button" value = "다음 곡 추가" onclick = "nextsong(this);">
	<input type = "button" value = "앨범 등록" onclick = "add_album(this);">
	</form>
</fieldset>
</body>
</html>