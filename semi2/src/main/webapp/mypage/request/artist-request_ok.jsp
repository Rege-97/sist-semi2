<%@page import="com.plick.signedin.SignedinDto"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
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
MypageDao mdao = new MypageDao();
int result = mdao.changeMemberAccessType(signedinDto.getMemberId());
if (result > 0) signedinDto.setMemberAccessType("applicant");
String msg = result > 0 ? "":"신청 실패";
%>
<script>
if ("<%=msg%>" != ""){
	window.alert("<%=msg %>");
}
location.href = "/semi2/mypage/profile.jsp";
</script>