<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.member.MemberDao"%>
<%
	MemberDao dao = new MemberDao();
	int result = dao.checkEmailDuplicate(request.getParameter("email"));
	
	if(result > 0){
%>
<script>
	window.parent.document.getElementById("checkemailduplicate").innerText = "중복된 이메일이에요";
</script>
<%	
	}else{
%>
<script>
	window.parent.document.getElementById("checkemailduplicate").innerText = "사용가능한 이메일이에요";
</script>
<%	
	}
%>