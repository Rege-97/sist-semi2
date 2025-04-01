<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<fieldset>
	<form action="song-form.jsp">
	<img src = "" name = "albumart">
	<br>
	<input type = "text" name = "albumtitle" placeholder="앨범제목">
	<input type = "text" name = "description" placeholder="앨범소개">
	<input type = "text" name = "description" placeholder="아티스트">
	<select>
	<option disabled selected>장르선택</option>
	<option>장르1</option>
	<option>장르2</option>
	<option>장르3</option>
	</select>
	<input type = "submit" value = "다음">
	</form>
</fieldset>

</body>
</html>