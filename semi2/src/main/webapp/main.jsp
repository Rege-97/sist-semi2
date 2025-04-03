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
			ArrayList<RootDto> arr = rdao.recentAlbumShow();
			for (int i=0;i<arr.size();i++){
				%>
				<li><img src="/semi2/resources/images/album/<%=arr.get(i).getId()%>">
				<label><%=arr.get(i).getAlbumName() %></label>
				<label><%=arr.get(i).getMemberName() %></label>
				<%
				
			}
			%>
			
		</ul>
	</article>
	<article>
		<label>
		인기음악
		</label>
		<ul>
			<li><img>1번 음악
			<li><img>2번 음악
			<li><img>3번 음악
			<li><img>4번 음악
			<li><img>5번 음악
		</ul>
	</article>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>