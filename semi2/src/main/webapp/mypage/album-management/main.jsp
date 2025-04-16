<%@page import="com.plick.mypage.AlbumDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@ page import="java.io.File"%>
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
ArrayList <AlbumDto> albums = mdao.findMeberAlbums(signedinDto.getMemberId());
%>
<h2>앨범목록</h2>
<div>
	<input type = "button" value = "신규 앨범 등록" onclick = "location.href = 'album-form.jsp'">
	<table>
		<thead>
			<tr>
				<td>앨범커버</td>
				<td>앨범번호</td>
				<td>앨범명</td>
				<td>발매일</td>
			</tr>
		</thead>
		<tbody>
		<%
		for (int i = 0; i < albums.size(); i++){
		%>
		<tr>
			<td><img src = "<%=request.getRealPath("/resources/images/album/")+albums.get(i).getId()+".jpg" %>"
					onerror="this.src='/semi2/resources/images/album/default-cover.jpg';"></td>
			<td><%=albums.get(i).getId() %></td>
			<td><a href = "song.jsp?albumId=<%=albums.get(i).getId() %>"><%=albums.get(i).getName() %></a></td>
			<td><%=albums.get(i).getReleased_at() %></td>
		</tr>
		<%
		}
		%>
		</tbody>
	</table>
</div>
<%@ include file="/footer.jsp" %>
</body>
</html>