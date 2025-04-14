<%@page import="com.plick.album.SongsDto"%>
<%@page import="com.plick.album.AlbumDao"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@page import="com.plick.album.AlbumDto"%>
<%@page import="com.plick.mypage.SongDto"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
SignedinDto signedinDto = (SignedinDto) session.getAttribute("signedinDto");
request.setCharacterEncoding("UTF-8");
String path = request.getRealPath("/resources/songs/"+(Integer) session.getAttribute("albumId"));

java.io.File f = new java.io.File(path);
if(!f.exists()) f.mkdirs();

MultipartRequest mr = new MultipartRequest(request, path, 20 * 1024 * 1024, "UTF-8");

SongsDto songDto = new SongsDto();
songDto.setAlbum_id((Integer) session.getAttribute("albumId"));
songDto.setName(mr.getParameter("name"));
songDto.setComposer(mr.getParameter("composer"));
songDto.setLyricist(mr.getParameter("lyricist"));
songDto.setLyrics(mr.getParameter("lyrics"));

AlbumDao aDao = new AlbumDao();
MypageDao mDao = new MypageDao();
String msg = aDao.addSong(songDto) > 0 ? "성공" : "실패";

mDao.renameFile(path, mr.getFilesystemName("audioFile"), ""+aDao.findAlbumId(songDto.getName()));

%>
<script>
window.alert("<%=msg %>");
parent.location.href = "song.jsp";
</script>

</body>
</html>