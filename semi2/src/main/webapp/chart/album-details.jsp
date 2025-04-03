<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.chart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String id_s = request.getParameter("albumid");
if (id_s == null || id_s.equals("")) {
	id_s = "0";
}
int id = Integer.parseInt(id_s);

AlbumDetailDto dto = cdao.findAlbum(id);

String genres[] = { dto.getGenre1(), dto.getGenre2(), dto.getGenre3() };
StringBuffer genre = new StringBuffer();

for (int i = 0; i < 3; i++) {
	if (genres[i] != null || genres.equals("")) {
		if (i != 2) {
	genre.append(genres[i] + "/");
		} else {
	genre.append(genres[i]);
		}
	}
}

SimpleDateFormat sdf= new SimpleDateFormat("yyyy년 MM월 dd일");
String releasedAt = sdf.format(dto.getReleasedAt());
%>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<table>
				<tr>
					<td rowspan="4"><img src="/semi2/resources/images/album/<%=dto.getId()%>/cover.jpg" width="200"></td>
					<td colspan="2"><%=dto.getName()%></td>
					<td rowspan="2">별점</td>
				</tr>
				<tr>
					<td colspan="2"><%=dto.getArtist()%></td>
				</tr>
				<tr>
					<td colspan="3"><%=genre%></td>
				</tr>
				<tr>
					<td><a href="#">모두재생</a></td>
					<!-- 재생버튼 -->
					<td><a href="#">담기</a></td>
					<!-- 플리담기버튼 -->
					<td><a href="#">다운로드</a></td>
					<!-- 플리담기버튼 -->
				</tr>
			</table>
		</article>
		<article>
			<h1>수록곡</h1>
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
					ArrayList<TrackDto> arr = cdao.trackList(id);

					if (arr == null || arr.size() == 0) {
					%>
					<tr>
						<td colspan="7">수록곡이 존재하지 않습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < arr.size(); i++) {
					%>
					<tr>
						<td rowspan="2"><%=arr.get(i).getRnum()%></td>
						<td rowspan="2"><img src="/semi2/resources/images/album/<%=dto.getId()%>/cover.jpg" width="50"></td>
						<td><%=arr.get(i).getName()%></td>
						<td rowspan="2"><%=arr.get(i).getArtist()%></td>
						<td rowspan="2">듣기</td>
						<td rowspan="2">플리</td>
						<td rowspan="2">다운로드</td>
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
		<article>
			<table>
				<tr>
					<td>앨범소개</td>
				</tr>
				<tr>
					<td><%=releasedAt %></td>
				</tr>
				<tr>
					<td><br><%=dto.getDescription().replaceAll("\n", "<br>")%></td>
				</tr>
			</table>
		</article>
		<article>
			<form>
				<img>사용자프로필이미지 <label>닉네임</label> <input type="text">
				<input type="submit" value="등록">
			</form>
			<table>
				<tr>
					<td><img>사용자프로필이미지
					<td><label>닉네임</label>
					<td><label>댓글컨텐츠</label> <input type="button" value="답글">
				<tr>
					<td><img>사용자프로필이미지
					<td><label>닉네임</label>
					<td><label>댓글컨텐츠</label> <input type="button" value="답글">
			</table>

		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>