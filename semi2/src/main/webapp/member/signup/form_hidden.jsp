<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.member.MemberDao"%>
<%
MemberDao dao = new MemberDao();
if(request.getParameter("email")!=null && request.getParameter("email")!=""){
	int result = dao.checkEmailDuplicate(request.getParameter("email"));
	if(result > 0){
%>
<script>
	var email = window.parent.document.getElementById("checkEmailDuplicate");
	email.innerText = "중복된 이메일이에요.";
</script>
<%	
	}
}else if(request.getParameter("nickname")!=null && request.getParameter("nickname")!=""){
	int result = dao.checkNicknameDuplicate(request.getParameter("nickname"));
	if(result > 0){
%>
<script>
	window.parent.document.getElementById("checkNicknameDuplicate").innerText = "중복된 닉네임입니다.";
</script>
<%	
	}else{
%>
<script>
	window.parent.document.getElementById("checkNicknameDuplicate").innerText = "사용가능한 닉네임입니다.";
</script>
<%	
	}
}
%>