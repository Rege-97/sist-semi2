<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.member.MemberDao"%>
<%
request.setCharacterEncoding("UTF-8");
MemberDao memberDao = new MemberDao();
int result = memberDao.resetPassword(request.getParameter("password"), request.getParameter("email"));
if (result > 0){
%>
<script>
window.alert("비밀번호 변경성공");
location.href = "/semi2/member/signin.jsp";
</script>
<%
}else{
%>
<script>
window.alert("비밀번호 변경실패");
history.back();
</script>
<%
}
%>