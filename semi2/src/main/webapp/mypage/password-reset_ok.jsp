<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.plick.member.MemberDao"%>
<%
request.setCharacterEncoding("UTF-8");
SignedinDto signedinDto = (SignedinDto) session.getAttribute("signedinDto");
MemberDao memberDao = new MemberDao();
if (request.getParameter("password")!=null){
int result = memberDao.resetPassword(request.getParameter("password"), signedinDto.getMemberEmail());
if (result > 0){
	signedinDto.setMemberPassword(request.getParameter("password"));
%>
<script>
window.alert("비밀번호 변경성공");
location.href = "/semi2/mypage/profile.jsp";
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
}else{
	%>
	<script>
	window.alert("잘못된 접근입니다. 메인페이지로 돌아갑니다.");
	location.href = "/semi2/main.jsp";
	</script>
	<%	
}
%>