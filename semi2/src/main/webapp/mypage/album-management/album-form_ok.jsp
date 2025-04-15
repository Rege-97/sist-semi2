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
SignedinDto signedinDto = (SignedinDto) session.getAttribute("signedinDto");
request.setCharacterEncoding("UTF-8");
String path = request.getRealPath("/resources/images/album");

java.io.File f = new java.io.File(path);
if(!f.exists()) f.mkdirs();

MultipartRequest mr = new MultipartRequest(request, path, 20 * 1024 * 1024, "UTF-8");

AlbumDto albumDto = new AlbumDto();
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

AlbumDao aDao = new AlbumDao();
MypageDao mDao = new MypageDao();

if(request.getParameter("modify")==null){
	msg = aDao.addAlbum(albumDto) > 0 ? "db등록" : "실패";
}else{
	albumDto.setId(Integer.parseInt(session.getAttribute("albumId").toString()));
	msg = aDao.modifyAlbum(albumDto) > 0 ? "db등록" : "실패";
}
int albumId = aDao.findAlbumId(albumDto.getName());
	
if (mr.getFilesystemName("inputAlbumCover")!=null){
		
	String type = mr.getFilesystemName("inputAlbumCover").substring(mr.getFilesystemName("inputAlbumCover").lastIndexOf("."));
	
	File df = new File(path+"/"+albumId+type);
	if(df.exists()) df.delete();
	if (mDao.renameFile(path, mr.getFilesystemName("inputAlbumCover"), albumId+type)){
		msg += "파일 저장";
	}
}
session.setAttribute("albumId", albumId);

%>
<script>
window.alert("<%=msg %>");
parent.location.href = "/semi2/mypage/album-management/song.jsp";
</script>

