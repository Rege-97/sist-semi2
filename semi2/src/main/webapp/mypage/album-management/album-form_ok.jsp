<%@page import="com.plick.album.SongsDto"%>
<%@page import="com.plick.album.AlbumDto"%>
<%@page import="com.plick.album.AlbumDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="songsDto" class="com.plick.album.SongsDto"></jsp:useBean>
<%
AlbumDto aDto = (AlbumDto) session.getAttribute("albumDto");
if(songsDto.getName()!=null){
SongsDto sdto = new SongsDto();
sdto.setName(request.getParameter("name"));
sdto.setName(request.getParameter("omposer"));
sdto.setName(request.getParameter("lyricist"));
sdto.setName(request.getParameter("lyrics"));
aDto.setSongsdto(songsDto);
}
AlbumDao aDao = new AlbumDao();
int result = aDao.addAlbum(aDto);
String msg = result > 0 ? "앨범 추가 성공" : "앨범 추가 실패";
%>
<script>
window.alert("<%=msg %>");
location.href = "/semi2/mypage/profile.jsp";
</script>

