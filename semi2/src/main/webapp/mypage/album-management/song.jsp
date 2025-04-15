<%@page import="com.plick.mypage.SongDto"%>
<%@page import="com.plick.mypage.AlbumDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp"%>
<%@ include file="/mypage/mypage-header.jsp"%>
<%
if(request.getParameter("albumId")!=null) session.setAttribute("albumId", request.getParameter("albumId"));

int albumId = (Integer.parseInt(session.getAttribute("albumId").toString()));
System.out.println(albumId+"<<");
AlbumDto aDto = mdao.findInfoAlbums(albumId);
ArrayList <SongDto> songs = mdao.findAlbumSongs(albumId);
%>
<h2>앨범수정</h2>
<div>
	<input type="button" value="신곡 추가하기" onclick="location.href = 'song-form.jsp'">
	<table>
		<thead>
			<tr>
				<td><img src = "<%=request.getRealPath("/resources/images/album")+albumId+".jpg" %>"
					onerror="this.src='/semi2/resources/images/album/default-album.jpg';"></td>
				<td><%=aDto.getId() %></td>
				<td><%=aDto.getName() %></td>
				<td><%=aDto.getReleased_at().getYear() %>+"년"+
				<%=aDto.getReleased_at().getMonth()+1 %>+"월"+
				<%=aDto.getReleased_at().getDate() %>+"일"
				</td>
			</tr>
		</thead>
	</table>
</div>
<div>
	<table>
		<thead>
			<tr>
				<td>앨범커버</td>
				<td>곡번호</td>
				<td>곡명</td>
				<td>작사</td>
				<td>작곡</td>
			</tr>
		</thead>
		<tbody>
		<%
		if(songs==null || songs.size()==0){
		%>
		<tr>
			<td colspan="4">등록된 수록곡이 없습니다</td>
		</tr>	
		<%	
		}else{
			for (int i = 0; i < songs.size(); i++){
		%>
		<tr>
			<td><img></td>
			<td><%=songs.get(i).getId() %></td>
			<td><%=songs.get(i).getName() %></td>
			<td><%=songs.get(i).getComposer() %></td>
			<td><%=songs.get(i).getLyricist() %></td>
		</tr>
		<%
			}
		}
		%>
		</tbody>
	</table>
</div>
<%@ include file="/footer.jsp" %>
</body>
</html>