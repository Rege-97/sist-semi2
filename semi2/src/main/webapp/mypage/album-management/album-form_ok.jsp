<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.album.SongsDto"%>
<%@page import="com.plick.album.AlbumDto"%>
<%@page import="com.plick.album.AlbumDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="songsDto" class="com.plick.album.SongsDto"></jsp:useBean>
<%
// 최종적으로 앨범과 곡을 db에 저장하는 페이지
// 세션에서 dto들 불러오기
AlbumDto aDto = (AlbumDto) session.getAttribute("albumDto");
ArrayList<SongsDto> songsDtos = (ArrayList<SongsDto>) session.getAttribute("SongsDtos");
// 마지막 서밋에 데이터가 있었으면 곡 한 번더 list에 추가
if(request.getParameter("name")!=null){
SongsDto sDto = new SongsDto();
sDto.setAlbum_id(aDto.getId());
sDto.setName(request.getParameter("name"));
sDto.setName(request.getParameter("omposer"));
sDto.setName(request.getParameter("lyricist"));
sDto.setName(request.getParameter("lyrics"));
songsDtos.add(songsDto);
}
aDto.setSongsDtos(songsDtos);
AlbumDao aDao = new AlbumDao();
int result = aDao.addAlbum(aDto);
// SongsDtos에 저장된 songs 한 행씩 db에 등록 
// AlbumId가 아직 AlbumDto에 세팅 되지 않았으므로 db에서 가져와서 세팅 
int albumId = aDao.findAlbumId(aDto.getName());
ArrayList<SongsDto> arr = aDto.getSongsDtos();
for (int i = 0; i < arr.size(); i++){
	arr.get(i).setAlbum_id(albumId);
	result += aDao.addSongs(arr.get(i));
	System.out.println(result+":"+i);
}
String msg = result > 0 ? result-1+"앨범 추가 성공" : result-1+"앨범 추가 실패";
%>
<script>
window.alert("<%=msg %>");
parent.location.href = "/semi2/mypage/profile.jsp";
</script>

