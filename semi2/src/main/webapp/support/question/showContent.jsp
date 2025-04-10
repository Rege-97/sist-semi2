<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.support.*"%>
<%@page import="java.text.*"%>
<jsp:useBean id="questionDao" class="com.plick.support.QuestionDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@include file="/header.jsp"%>
	<%
	String swAnswer = request.getParameter("answer")!=null?request.getParameter("answer"):"true";
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
	QuestionDto dto = questionDao.showContent(id);

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String createAt = sdf.format(dto.getCreatedAt());
	%>
	<section>
		<article>
			<div class="support-view-box-answer">
				<div class="support-view-title"><%=dto.getTitle()%></div>
				<div class="support-view-content"><%=dto.getContent().replaceAll("\n", "<br>")%></div>
				<div class="support-view-date-box">
					<div class="support-view-date">
						작성일자 :
						<%=createAt%></div>
					<%
					String accessType = signedinDto.getMemberAccessType();
					if (accessType == null) {
						accessType = "";
					}
					if (accessType.equals("admin") && swAnswer.equals("false")) {
					%>

					<input type="button" value="답글" class="bt" onclick="sendRequest(1)">

					<%
					} 
					if (dto.getMemberId() == signedinDto.getMemberId()) {
					%>

					<input type=button value="수정" onclick="sendRequest(2);" class="bt">
					<input type=button value="삭제"
						onclick="location.href='/semi2/support/question/delete_ok.jsp?id=<%=id %>&parentId=<%=dto.getParentId() %>'"
						class="bt">

					<%
					}
					%>
					<input type=button value="목록"
						onclick="location.href='/semi2/support/question.jsp?page=<%=previousPage%>'"
						class="bt">

				</div>
			</div>
			<form id="postForm" method="post">
				<input type="hidden" name="title" value="<%=dto.getTitle()%>">
				<input type="hidden" name="content" value="<%=dto.getContent()%>">
				<input type="hidden" name="parentId" value="<%=dto.getParentId()%>">
				<input name="id" type="hidden" value="<%=id%>"> <input
					name="page" type="hidden" value="<%=previousPage%>"> <input
					name="swAnswer" type="hidden" value="<%=swAnswer%>">


			</form>

		</article>
	</section>
	<%@include file="/footer.jsp"%>
	<script>
	function sendRequest(mode){
		const form = document.getElementById("postForm");
		switch (mode){
			case 1:form.action = "/semi2/support/question/answer.jsp";break;
			case 2:form.action = "/semi2/support/question/updateContent.jsp";break;		
		}
		console.log(form);
		
		form.submit();
	}
	</script>
	</body>
	</html>