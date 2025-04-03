<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.chart.*"%>
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

System.out.println(dto);

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
%>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<table>
				<tr>
					<td rowspan="4"><img
						src="/semi2/resources/images/album/<%=dto.getId()%>/cover.jpg"
						width="200"></td>
					<td colspan="2"><%=dto.getName()%></td>
					<td rowspan="2">별점</td>
				</tr>
				<tr>
					<td colspan="2"><%=dto.getArtist()%></td>
				</tr>
				<tr>
					<td colspan="3"><%=genre %></td>
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
			<label>수록곡</label>
			<table>
				<tr>
					<td><img>앨범아트
					<td><a>제목</a> <a>앨범명</a>
					<td><label>아티스트</label>
					<td><img>+
					<td><img>재생
					<td><img>다운로드
				<tr>
					<td><img>앨범아트
					<td><a>제목</a> <a>앨범명</a>
					<td><label>아티스트</label>
					<td><img>+
					<td><img>재생
					<td><img>다운로드
			</table>
		</article>
		<article>
			<label>앨범소개</label> <label>발매일</label> <label>소개소개소개소개소개소개소개소개소개소개소개소개</label>
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