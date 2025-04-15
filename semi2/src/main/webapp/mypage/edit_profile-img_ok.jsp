<%@page import="com.plick.signedin.SignedinDto"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>
	<%
	if(session.getAttribute("signedinDto")==null){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}else if(((SignedinDto) session.getAttribute("signedinDto")).getMemberId() == 0){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}
	%>

<%
int memberId = signedinDto.getMemberId();
String data64 = request.getParameter("img64");

//저장된 파일을 "profileImg.jpg로 이름 변경
File delFile = new File(request.getRealPath("resources/images/member/"+memberId)+"/profile.jpg");
delFile.delete();
MypageDao mDao = new MypageDao();
boolean a = mDao.addFileToBase64(request.getParameter("img64"), request.getRealPath("resources/images/member/"+memberId)+"/profile.jpg");
%>
<script>
window.alert("<%=a ? "성공":"실패" %>");
location.href = "/semi2/mypage/profile.jsp";
</script>