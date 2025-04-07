<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="signedinDto" class="com.plick.signedin.signedinDto" scope="session"></jsp:useBean>
<%
String totalPath = request.getRealPath("resources/images/design/member/"+signedinDto.getMemberId());
request.setCharacterEncoding("UTF-8");
MultipartRequest mulrequest = new MultipartRequest(request, totalPath, 200, "UTF-8");
File TempImg = new File(totalPath+"/"+mulrequest.getFileNames());
File profileImg = new File(totalPath+"/profileImg.jpg");
String profileImgName = profileImg.exists() ? "/profileImg.jpg" : "/editerImg.jpg";
profileImg.delete();
TempImg.renameTo(profileImg);
%>
<script>
location.href = "profile.jsp"
</script>