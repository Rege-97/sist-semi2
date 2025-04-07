<%@page import="com.plick.playlist.PlaylistPreviewDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.plick.playlist.main.PlaylistMainDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!// 각 리스트(최신순, 인기순)에 최대 몇개를 가져올지 설정
static final int PREVIEW_MAX_COUNT = 10;%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
PlaylistMainDao playlistMainDao = new PlaylistMainDao();
// 최신순 인기순 리스트를 한번에 받아오는 메서드, 결과가 없을시 map 객체에는 빈 Arraylist들이 들어가 있음. 예외발생시 빈 map 객체를 반환함. 
Map<String, List<PlaylistPreviewDto>> previews = playlistMainDao.findRecommendedPlaylistsByLimit(PREVIEW_MAX_COUNT);
// 최신순 리스트가 최대 PREVIEW_MAX_COUNT 만큼 들어있음, 없으면 빈 리스트임.
List<PlaylistPreviewDto> latestPreviews = previews.get("latest");
// 최신순 리스트가 최대 PREVIEW_MAX_COUNT 만큼 들어있음, 없으면 빈 리스트임.
List<PlaylistPreviewDto> popularPreviews = previews.get("popular");
%>
<body>
	<%@include file="/header.jsp"%>
	<h2>
		<label>인기급상승</label>|<label>플리 만들기</label>
	</h2>


	<%@include file="/footer.jsp"%>
</body>
</html>