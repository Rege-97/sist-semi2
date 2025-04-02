<%@page import="com.plick.chart.SongDetailDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.plick.dto.*"%>
<jsp:useBean id="sdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
String id_s = request.getParameter("songid");

if (id_s == null || id_s.equals("")) {
	id_s = "0";
}

int id = Integer.parseInt(id_s);

SongDetailDto dto = sdao.findSong(id);
%>

</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<table>
				<tr>
					<td rowspan="4"><img src="/semi2/resources/images/album/<%=dto.getAlbumId()%>/cover.jpg" width="200"></td>
					<td colspan="2"><%=dto.getName() %></td>
				</tr>
				<tr>
					<td colspan="2"><%=dto.getArtist() %></td>
				</tr>
				<tr>
					<td colspan="2"><%=dto.getAlbumName() %> ></td>
				</tr>
				<tr>
					<td>재생</td> <!-- 재생버튼 -->
					<td>담기</td> <!-- 플리담기버튼 -->
				</tr>
			</table>
		</article>
		<article>
			<table>
				<tr>
					<td>곡명</td>
					<td><%=dto.getName() %></td>
				</tr>
				<tr>
					<td>작곡</td>
					<td><%=dto.getComposer() %></td>
				</tr>
				<tr>
					<td>작사</td>
					<td><%=dto.getLyricist() %></td>
				</tr>
				<tr>
					<td colspan="2"><br><%=dto.getLyrics().replaceAll("\n", "<br>")%></td>
				</tr>
			</table>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>