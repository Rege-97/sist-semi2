<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.plick.dto.*"%>
<jsp:useBean id="dao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
String id_s = request.getParameter("songid");

if (id_s == null && id_s.equals("")) {
	id_s = "0";
}

int id = Integer.parseInt(id_s);

SongDto dto = dao.findSong(id);


%>

</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<img>앨범아트 <label>곡 제목</label> <label>아티스트</label> <label>앨범명</label>
		</article>
		<article>
			<table>
				<tr>
					<td>작곡
					<td>작사
				<tr>
					<td>작곡가 이름, 작곡가 이름
					<td>작사가 이름, 작사가 이름
			</table>
			<h3>가사</h3>
			<p>가사내용가사내용가사내용가사내용가사내용가사내용가사내용가사내용가사내용
				가사내용가사내용가사내용가사내용가사내용가사내용가사내용가사내용가사내용</p>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>