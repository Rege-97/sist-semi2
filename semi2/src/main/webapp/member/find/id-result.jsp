<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.plick.member.MemberDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
MemberDao dao = new MemberDao();
ArrayList<String> memberEmails = dao.searchEmail(request.getParameter("name"), request.getParameter("tel").substring(0, 3)+"-"+request.getParameter("tel").substring(3, 7)+"-"+request.getParameter("tel").substring(7));
if (memberEmails == null) {
%>
<script>
	window.alert("위험! 알 수 없는 오류 발생");
	history.back();
</script>
<%
} else if (memberEmails.size() < 1) {
%>
<script>
	window.alert("해당하는 유저가 없습니다");
	history.back();
</script>
<%
}
%>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<jsp:include page="/header.jsp"></jsp:include>
<div class="login-box">
		<form>
	<div class="blank2"></div>
		<div class="signup-title">아이디 찾기</div>
			<h3><%=request.getParameter("name")%>님의 아이디는
			</h3>
			<%
			for (int i = 0; i < memberEmails.size(); i++) {
			%>
			<h3><%=memberEmails.get(i)%> 입니다
			</h3>
			<%
			}
			%>
			<br> <input type="button" value="로그인하러 가기"
				class="bt" onclick="location.href = '/semi2/member/signin.jsp'">
		</form>
	</div>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>