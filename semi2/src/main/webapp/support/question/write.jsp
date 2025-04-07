<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<body>
<%@ include file="/header.jsp" %>
<%
String accessType=signedinDto.getMemberAccessType();
if(accessType==null){
	%>
	<script>
	window.alert('잘못된 접근입니다.');
	location.href='/semi2/support/main.jsp';
	</script>
	<%
	
}
%>
<h1>1대1 질문 글쓰기</h1>
<form name="writeForm" action="/semi2/support/question/write_ok.jsp" method="post">
<label>제목</label><input name="title" type="text" placeholder="제목을 입력하세요."><br>
<textarea name="content"></textarea>
<input type="hidden" name="memberId" value="<%=signedinDto.getMemberId()%>">
<input type="button" value="글쓰기" onclick="sendRequest();">
</form>


<%@ include file="/footer.jsp" %>
</body>
</html>