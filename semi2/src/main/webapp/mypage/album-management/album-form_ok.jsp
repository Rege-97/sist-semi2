<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.album.SongsDto"%>
<%@page import="com.plick.album.AlbumDto"%>
<%@page import="com.plick.album.AlbumDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
AlbumDao aDao = new AlbumDao();


int albumId = request.getParameter("albumId")!=null ? Integer.parseInt(request.getParameter("albumId")) : aDao.findMaxAlbumId();

if(aDao.checkAlbumDuplicate(albumId) == 0){


String coverPath = request.getRealPath("/resources/images/album/"+albumId);
String songsPath = request.getRealPath("/resources/songs/"+albumId);

java.io.File f = new java.io.File(coverPath);
if(!f.exists()) f.mkdirs();

java.io.File f2 = new java.io.File(songsPath);	
if(!f2.exists()) f2.mkdirs();

MultipartRequest mr = new MultipartRequest(request, coverPath, 20 * 1024 * 1024, "UTF-8");

AlbumDto albumDto = new AlbumDto();
albumDto.setId(albumId);
albumDto.setName(mr.getParameter("name"));
albumDto.setMemberId(signedinDto.getMemberId());
albumDto.setDescription(mr.getParameter("description"));
albumDto.setGenre1(mr.getParameter("genre1"));
albumDto.setGenre2(mr.getParameter("genre2"));
albumDto.setGenre3(mr.getParameter("genre3"));

//select 박스로 조합된 날짜 파싱 후 releasedAt 생성
SimpleDateFormat format = new SimpleDateFormat("yyyy-M-d");
String releaseDate = mr.getParameter("year")+mr.getParameter("month")+mr.getParameter("date");
releaseDate = releaseDate.replace("년", "-");
releaseDate = releaseDate.replace("월", "-");
releaseDate = releaseDate.replace("일", "");
Date parseDate = format.parse(releaseDate);
Timestamp releasedAt = new Timestamp(parseDate.getTime());
albumDto.setReleasedAt(releasedAt);




String msg = "";


MypageDao mDao = new MypageDao();

if(request.getParameter("albumId")==null){
	msg = aDao.addAlbum(albumDto) > 0 ? "" : "실패";
}else{
	albumDto.setId(albumId);
	msg = aDao.modifyAlbum(albumDto) > 0 ? "" : "실패";
}
	
if (mr.getFilesystemName("inputAlbumCover")!=null){
		
	String type = mr.getFilesystemName("inputAlbumCover").substring(mr.getFilesystemName("inputAlbumCover").lastIndexOf("."));
	
	File df = new File(coverPath+"/"+albumId+type);
	if(df.exists()) df.delete();
	if (mDao.renameFile(coverPath, mr.getFilesystemName("inputAlbumCover"), "cover"+type)){
		
	}
}

%>
<script>
if("<%=msg %>"!="") window.alert("<%=msg %>");
parent.location.href = "/semi2/mypage/album-management/song.jsp?albumId=<%=albumId%>";
</script>
<%}else{
%>
<script>
window.alert("현재 작업 중인 아티스트가 너무 많습니다. 다시 시도 해주세요.");
parent.location.href = "/semi2/mypage/album-management/main.jsp";
</script>
<%
}
%>
