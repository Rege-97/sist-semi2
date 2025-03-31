<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
function nextsong(b){
	window.alert("다음 곡을 추가하시겠습니까?");
	var form = b.form;
	form.action = "song-form.jsp";
	form.submit();
}
function add_album(b){
	window.alert("앨범을 등록하시겠습니까?");
	var form = b.form;
	form.action = "../mypage-profile.jsp";
	form.submit();
}
</script>
<body>
<fieldset>
	<form>
	<input type = "text" name = "albumtitle" placeholder="곡 이름">
	<input type = "text" name = "description" placeholder="작곡">
	<input type = "text" name = "description" placeholder="작사">
	<input type = "text" name = "description" placeholder="가사">
	<audio src="" name = ""></audio>
	<select>
	<option disabled selected>장르선택</option>
	<option>장르1</option>
	<option>장르2</option>
	<option>장르3</option>
	</select>
	<input type = "button" value = "다음 곡 추가" onclick = "nextsong(this);">
	<input type = "button" value = "앨범 등록" onclick = "add_album(this);">
	</form>
</fieldset>
</body>
</html>