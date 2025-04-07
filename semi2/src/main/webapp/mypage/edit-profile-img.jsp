<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 사진 변경</title>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>
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
<img id = editProfileImg src = "/semi2/<%=memberDao.loadEditerImg(request.getRealPath(""), Integer.parseInt(request.getParameter("memberId"))) %>"> 
<form action = "edit_profile-img_ok.jsp?memberId=<%=request.getParameter("memberId") %>" method = "post" enctype= "multipart/form-data">
<input style = "display: none;" type = "file" id = "editNewProfileImg" name = "editProfileImg">
<input type = "button" value = "이미지 변경하기" onclick = "imgChange();">
<input type = "submit" value = "저장하기">
</form>
</body>
</html>