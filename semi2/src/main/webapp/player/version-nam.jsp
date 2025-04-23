<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.player.*" %>
<jsp:useBean id="playerDao" class="com.plick.player.PlayerDao"></jsp:useBean>  
<%
String songId_str = request.getParameter("songId");
int songId = Integer.parseInt(songId_str);
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 앨범사진(앨범아이디), 노래이름, 아티스트 이름, 앨범이름, 가사, 오디오태그, 재생목록 -->
<%
PlayerDto dto = playerDao.showSongInfo(songId);
%>
<img src="/semi2/resources/images/album/<%=dto.getAlbumId()%>/cover.jpg">
<a><%=dto.getSongName() %></a>
<a><%=dto.getNickname() %></a>
<a><%=dto.getAlbumName() %></a>
<p><%=dto.getLyrics() %>
<audio src="/semi2/resources/songs/<%=dto.getAlbumId()%>/<%=dto.getSongId() %>.mp3" controls></audio>
<table>재생목록</table>
</body>
</html>