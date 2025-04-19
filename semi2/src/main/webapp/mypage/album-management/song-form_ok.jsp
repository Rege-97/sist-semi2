<%@page import="java.io.File"%>
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
	if(session.getAttribute("signedinDto")==null){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}else if(((SignedinDto) session.getAttribute("signedinDto")).getMemberId() == 0){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}
	%>

<%
SignedinDto signedinDto = (SignedinDto) session.getAttribute("signedinDto");
request.setCharacterEncoding("UTF-8");
String albumIdInSession = session.getAttribute("albumId") != null ? session.getAttribute("albumId").toString() : null;
if(albumIdInSession != null){

String path = request.getRealPath("/resources/songs/"+albumIdInSession);

java.io.File f = new java.io.File(path);
if(!f.exists()) f.mkdirs();

MultipartRequest mr = new MultipartRequest(request, path, 20 * 1024 * 1024, "UTF-8");

SongsDto songDto = new SongsDto();
songDto.setAlbum_id(Integer.parseInt(session.getAttribute("albumId").toString()));
songDto.setName(mr.getParameter("name"));
songDto.setComposer(mr.getParameter("composer"));
songDto.setLyricist(mr.getParameter("lyricist"));
songDto.setLyrics(mr.getParameter("lyrics"));

AlbumDao aDao = new AlbumDao();
MypageDao mDao = new MypageDao();

String msg = "";
int songId = request.getParameter("songId") != null ? Integer.parseInt(request.getParameter("songId")) : aDao.findMaxSongId()+1;

if (request.getParameter("songId")==null){
	msg = aDao.addSong(songDto) > 0 ? "DB등록" : "실패";
}else{
	songDto.setId(songId);
	msg = aDao.modifySong(songDto) > 0 ? "DB등록" : "실패";
}
if (mr.getFilesystemName("audioFile")!=null){
	String type = mr.getFilesystemName("audioFile").substring(mr.getFilesystemName("audioFile").lastIndexOf("."));
	
	File df = new File(path+"/"+songId+type);
	if(df.exists()) df.delete();
	if (mDao.renameFile(path, mr.getFilesystemName("audioFile"), songId+type)){
		msg += "+음원 변경";
	}
}

%>
<script>
window.alert("<%=msg %>");
parent.location.href = "song.jsp?albumId=<%=albumIdInSession %>";
</script>
<%
}else{
%>
<script>
window.alert("잘못된 접근입니다. 메인페이지로 돌아갑니다.");
parent.location.href = "/semi2/main.jsp";
</script>
<%	
}
%>
</body>
</html>