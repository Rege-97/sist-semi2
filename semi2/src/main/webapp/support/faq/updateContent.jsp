<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>     
<jsp:useBean id="faqDto" class="com.plick.support.FaqDto"></jsp:useBean>    
<jsp:setProperty property="*" name="faqDto"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
<script>
function sendRequest(){
	let title = document.writeForm.title.value;
	let content = document.writeForm.content.value;
	console.log(content);
	if(title==""||title==null){
		window.alert('제목을 입력하세요.');
	}else if(content==""||content==null){
		window.alert('내용을 입력하세요.')
	}else{
		document.writeForm.submit();
	}
}
</script>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="body-content">
<%
String accessType=signedinDto.getMemberAccessType();
if(accessType==null){
	accessType="";
}
if(!accessType.equals("admin")){
	%>
	<script>
	window.alert('잘못된 접근입니다.');
	location.href='/semi2/support/main.jsp';
	</script>
	<%
}
String page_str = request.getParameter("page");
if (page_str == null || page_str.equals("")) {
	page_str="1";
}
int previousPage = Integer.parseInt(page_str);
%>
<div class="subtitle"><h2>FAQ 게시글 수정</h2></div>
<form name="writeForm" action="/semi2/support/faq/updateContent_ok.jsp" method="post">
<div class="support-write-box">
<div class="support-write-title">
<input name="title" type="text" value="<%=faqDto.getTitle()%>">

</div>
<div class="support-write-content">
<textarea name="content"><%=faqDto.getContent()%></textarea>
</div>
<div class="support-write-bt">
<input type="button" value="수정" class="bt" onclick="sendRequest();">
</div>
</div>
<input type="hidden" name="memberId" value="<%=signedinDto.getMemberId()%>">
<input type="hidden" name="id" value="<%=faqDto.getId()%>">
<input name="page" type="hidden" value="<%=previousPage%>">
</form>


<%@ include file="/footer.jsp" %>
</div>
</body>
</html>