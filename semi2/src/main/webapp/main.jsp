<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.root.*" %>
<%@ page import="java.util.*" %>    
<jsp:useBean id="rdao" class="com.plick.root.RootDao"></jsp:useBean>
<jsp:useBean id="rdto" class="com.plick.root.RootDto"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/header.jsp" %>
<!-- 배너 -->
<section>
	<article>
		<a>&lt;&lt;</a>
		<img>배너이미지
		<a>&gt;&gt;</a>
	</article>
</section>
<!-- 첫 번째 메뉴 + 컨텐츠 -->
<section>
	<article>
		<label>
		최신발매앨범
		</label>
		<ul>
			<%
			ArrayList<RootDto> arr = new ArrayList<RootDto>();
			arr = rdao.recentAlbumShow();
			if(arr==null){
				%>
				<li>불러올 정보가 없습니다.
				<%
			}else{
				
				for (int i=0;i<arr.size();i++){
					%>
					<li>
					<a href="/semi2/chart/album-details.jsp?id=">				
					<img src="/semi2/resources/images/album/<%=arr.get(i).getAlbumId()%>/cover.jpg">
					</a>
					<label><a href="/semi2/chart/album-details.jsp?id="><%=arr.get(i).getAlbumName() %></a></label>
					<label><a href="/semi2/artist/main.jsp?id="><%=arr.get(i).getMemberName() %></a></label>
					<%
					
				}
			}
			%>
			
		</ul>
	</article>
	<article>
		<label>
		인기음악
		</label>
		<ul>
			<%
			arr = rdao.popularSongShow();
			if(arr==null){
				%>
				<li>불러올 정보가 없습니다.
				<%
			}else{
				
				for (int i=0;i<arr.size();i++){
					%>
					<li>
					<a href="/semi2/chart/album-details.jsp?id=">
					<img src="/semi2/resources/images/album/<%=arr.get(i).getAlbumId()%>/cover.jpg">
					</a>
					<label><a href="/semi2/chart/song-details.jsp?id="><%=arr.get(i).getSongName() %></a></label>
					<label><a href="/semi2/artist/main.jsp?id="><%=arr.get(i).getMemberName() %></a></label>
					<%
					
				}
			}
			%>
		</ul>
	</article>
	<article>
		<label>
		인기 플레이리스트
		</label>
		<ul>
			<%
			arr = rdao.popularPlaylistShow();
			if(arr==null){
				%>
				<li>불러올 정보가 없습니다.
				<%
			}else{
				
				for (int i=0;i<arr.size();i++){
					%>
					<li>
					<a href="/semi2/playlist/details.jsp?id=">
					<img src="/semi2/resources/images/playlist/<%=arr.get(i).getPlaylistId()%>/cover.jpg">
					</a>
					<label><a href="/semi2/playlist/details.jsp?id="><%=arr.get(i).getPlaylistName() %></a></label>
					<%
					
				}
			}
			%>
		</ul>
	</article>
	<article>
		<label>
		분위기에 따른 플레이리스트
		</label>
		<ul>
			<li><a href="#"><img>신나는</a>
			<li><a href="#"><img>잔잔한</a>
			<li><a href="#"><img>감성적인</a>
			<li><a href="#"><img>슬플 때</a>
			<li><a href="#"><img>달달한</a>
			<li><a href="#"><img>상쾌한</a>
			<li><a href="#"><img>몽환적인</a>
		</ul>
	</article>
	<article>
		<label>
		장르 콜렉션
		</label>
		<ul>
			<li><a href="#"><img>1번 장르</a>
			<li><a href="#"><img>2번 장르</a>
			<li><a href="#"><img>3번 장르</a>
			<li><a href="#"><img>4번 장르</a>
			<li><a href="#"><img>5번 장르</a>
			<li><a href="#"><img>6번 장르</a>
			<li><a href="#"><img>7번 장르</a>
			<li><a href="#"><img>8번 장르</a>
			<li><a href="#"><img>9번 장르</a>
			<li><a href="#"><img>10번 장르</a>
		</ul>
	</article>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>