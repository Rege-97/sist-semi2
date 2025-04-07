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
//이 부분은 차후에 이미지 에디터 작업할 때 추가로 진행하겠습니다 화면 전환 없이 구현할 부분
function changeEditImg() {
	var newImg = document.getElementById('editNewProfileImg').files[0].name;
	window.alert("/semi2/resources/images/member/<%=request.getParameter("memberId") %>/"+newImg);
	document.getElementById('editProfileImg').src = 
		"/semi2/resources/images/member/<%=request.getParameter("memberId") %>/"+newImg;
}
</script>
<body>
<img id = editProfileImg src = "/semi2/<%=memberDao.loadEditerImg(request.getRealPath(""), Integer.parseInt(request.getParameter("memberId"))) %>"> 
<form action = "edit_profile-img_ok.jsp?memberId=<%=request.getParameter("memberId") %>" method = "post" enctype= "multipart/form-data">
<input style = "display: none;" type = "file" id = "editNewProfileImg" name = "editProfileImg" onchange = "changeEditImg();">
<input type = "button" value = "이미지 변경하기" onclick = "imgChange();">
<input type = "submit" value = "저장하기">
</form>
</body>
</html>