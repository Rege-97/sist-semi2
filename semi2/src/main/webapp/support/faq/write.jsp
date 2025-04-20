<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
%>
<div class="subtitle"><h2>FAQ 게시글 작성</h2></div>
<form name="writeForm" action="/semi2/support/faq/write_ok.jsp" method="post">
<div class="support-write-box">
<div class="support-write-title">
<input name="title" type="text" placeholder="제목을 입력하세요.">
</div>
<div class="support-write-content">
<textarea name="content" placeholder="본문을 입력하세요."></textarea>
</div>
<div class="support-write-bt">
<input type="button" value="글쓰기" class="bt" onclick="sendRequest();">
</div>
</div>
<input type="hidden" name="memberId" value="<%=signedinDto.getMemberId()%>">
</form>


<%@ include file="/footer.jsp" %>
</div>
</body>
</html>