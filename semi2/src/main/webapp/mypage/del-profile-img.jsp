<%@page import="com.plick.signedin.SignedinDto"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
File delFile = new File(request.getRealPath("resources/images/member/"+request.getParameter("memberId")+"/profile.jpg"));
delFile.delete();
%>
<script>
window.parent.location.reload();
</script>