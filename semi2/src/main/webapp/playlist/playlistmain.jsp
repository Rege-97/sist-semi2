<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page = "/header.jsp"></jsp:include>
<h2><label>인기급상승</label>|<label>플리 만들기</label></h2>
<iframe src = "playlisttable.jsp?tabletype=popularity"></iframe>

<h2>최신등록</h2>
<iframe src = "playlisttable.jsp?tabletype=recent"></iframe>

<h2>분위기별</h2>
<iframe src = "playlisttable.jsp?tabletype=ambience"></iframe>

<jsp:include page = "/footer.jsp"></jsp:include>
</body>
</html>