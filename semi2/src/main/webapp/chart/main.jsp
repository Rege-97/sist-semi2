<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="com.plick.chart.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String genre = request.getParameter("genre");

ArrayList<TrackDto> arr = null;

if (genre == null) {
	arr = cdao.allChartList();
}else{
	
}


%>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<ul>
				<li><a href="#">전체차트</a></li>
				<li><a href="#">발라드</a></li>
				<li><a href="#">알앤비</a></li>
				<li><a href="#">힙합</a></li>
				<li><a href="#">아이돌</a></li>
				<li><a href="#">재즈</a></li>
				<li><a href="#">팝</a></li>
				<li><a href="#">클래식</a></li>
				<li><a href="#">댄스</a></li>
				<li><a href="#">인디</a></li>
				<li><a href="#">락</a></li>
			</ul>
		</article>
		<article>
			<h1>인기차트 TOP 100</h1>
			<table width="600">
				<thead align="left">
					<tr>
						<th>번호</th>
						<th colspan="2">곡/앨범</th>
						<th>아티스트</th>
						<th>듣기</th>
						<th>내 리스트</th>
						<th>다운로드</th>
					</tr>
					<tr>
						<td colspan="7"><hr></td>
					</tr>
				</thead>
				<tbody>
					<%

					if (arr == null || arr.size() == 0) {
					%>
					<tr>
						<td colspan="7">차트가 존재하지 않습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < arr.size(); i++) {
					%>
					<tr>
						<td rowspan="2"><%=arr.get(i).getRnum()%></td>
						<td rowspan="2"><img
							src="/semi2/resources/images/album/<%=arr.get(i).getAlbumId()%>/cover.jpg"
							width="50"></td>
						<td><a
							href="/semi2/chart/song-details.jsp?songid=<%=arr.get(i).getId()%>"><%=arr.get(i).getName()%></a></td>
						<td rowspan="2"><a href="/semi2/artist/main.jsp?memberid=<%=arr.get(i).getMemberId()%>"><%=arr.get(i).getArtist()%></a></td>
						<td rowspan="2"><a href="#">듣기</a></td>
						<td rowspan="2"><a href="#">담기</a></td>
						<td rowspan="2"><a href="#">다운로드</a></td>
					</tr>
					<tr>
						<td><%=arr.get(i).getAlbumName()%></td>
					</tr>
					<tr>
						<td colspan="7"><hr></td>
					</tr>

					<%
					}

					}
					%>
				</tbody>
			</table>
		</article>
	</section>


	<%@include file="/footer.jsp"%>
</body>
</html>