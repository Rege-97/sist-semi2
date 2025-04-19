	<%@page import="com.plick.member.MemberDao"%>
	<%@page import="com.plick.signedin.SignedinDto"%>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<%
	if (session.getAttribute("signedinDto") != null) {
		SignedinDto sDto = (SignedinDto) session.getAttribute("signedinDto");
		sDto.setMemberDescription(request.getParameter("description"));
		MemberDao mdao = new MemberDao();
		int rs = mdao.resetDescription(sDto);
	%>
	<script>
	parent.window.alert("<%=rs%>개의 업데이트 완료");
	</script>
	<%
	}else{
		%>
		<script>
		window.alert("잘못된 접근입니다. 메인페이지로 돌아갑니다.");
		location.href = "/semi2/main.jsp";
		</script>
		<%
	}
	%>
