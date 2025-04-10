<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.support.*"%>
<%@page import="java.text.*"%>
<jsp:useBean id="noticeDao" class="com.plick.support.NoticeDao"></jsp:useBean>
<%
String id_str = request.getParameter("id");
if (id_str == null || id_str.equals("")) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	location.href = '/semi2/support/main.jsp';
</script>
<%
}
String page_str = request.getParameter("page");
if (page_str == null || page_str.equals("")) {
page_str = "1";
}
int previousPage = Integer.parseInt(page_str);
int id = Integer.parseInt(id_str);
NoticeDto dto = noticeDao.showContent(id);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String createAt = sdf.format(dto.getCreatedAt());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function updateRequest(){
	document.postForm.submit();
}
</script>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<form name="postForm" action='/semi2/support/notice/updateContent.jsp' method="post">
			<div class="support-view-box">
				<div class="support-view-title"><%=dto.getTitle()%></div>
				<div class="support-view-content"><%=dto.getContent().replaceAll("\n", "<br>")%></div>
				<input name="title" type="hidden" value="<%=dto.getTitle()%>">
				<input name="content" type="hidden" value="<%=dto.getContent()%>">
				<input name="id" type="hidden" value="<%=id%>">
				<input name="page" type="hidden" value="<%=previousPage%>">
				<div class="support-view-date">
					작성일자 :
					<%=createAt%></div>
			</div>
			</form>
			<div>
				<%
				if (signedinDto.getMemberAccessType().equals("admin")) {
				%>
				<input type=button value="수정"
					onclick='updateRequest();'
					class="bt">
				<input type=button value="삭제"
					onclick="location.href='/semi2/support/notice/delete_ok.jsp?id=<%=id %>'"
					class="bt">
				<%
				}
				%>
				<input type=button value="목록"
					onclick="location.href='/semi2/support/main.jsp?page=<%=previousPage%>'"
					class="bt">
			</div>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>