<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 사진 변경</title>
</head>
<%
File profileImg = new File(request.getParameter("standardPath")+"/profileImg.jpg");
String profileImgPath = profileImg.exists() ? "/profileImg.jpg" : "/defaultImg.jpg";
%>
<script>
function imgChange() {
	document.getElementById('editNewProfileImg').click();
}
</script>
<body>
<img id = editProfileImg src = "<%=request.getParameter("standardPath")+profileImgPath %>"> 
<form action = "edit_profile-img_ok.jsp" method = "post" enctype= "multipart/form-data">
<input style = "display: none;" type = "file" id = "editNewProfileImg" name = "editProfileImg">
<input type = "button" value = "이미지 변경하기" onclick = "imgChange();">
<input type = "submit" value = "저장하기">
</form>
</body>
</html>