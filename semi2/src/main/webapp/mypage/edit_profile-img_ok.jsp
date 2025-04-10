<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>
<%
request.setCharacterEncoding("UTF-8");
int memberId = signedinDto.getMemberId();
MultipartRequest mulrequest = new MultipartRequest(request, request.getRealPath("resources/images/member/"+memberId), 1000000, "UTF-8");
//저장된 파일을 "profileImg.jpg로 이름 변경
File delFile = new File(request.getRealPath("resources/images/member/"+memberId)+"/profile.jpg");
delFile.delete();
File originFile = new File(request.getRealPath("resources/images/member/"+memberId)+"/"+mulrequest.getFilesystemName("editProfileImg"));
File newFile = new File(request.getRealPath("resources/images/member/"+memberId)+"/profile.jpg");
String msg = originFile.renameTo(newFile) ? "변경성공":"변경실패" ;
%>
<script>
window.alert("<%=msg %>");
location.href = "/semi2/mypage/profile.jsp";
</script>