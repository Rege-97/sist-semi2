<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
댓글(<%="댓글 수" %>)
<table>
	<tr>
		<td><img src = "/semi2/img/mincat.png" width="50px" height="50px"></td>
		<td>닉네임</td>
		<td>댓글내용</td>
		<td><input type = "button" value = "답글" onclick = "opencoment();"></td>
	</tr>
	<tr>
		<td colspan="4"><iframe src = ""></iframe><input type = "button" value = "X" onclick = "closecoment();"></td>
	</tr>
</table>
</body>
</html>