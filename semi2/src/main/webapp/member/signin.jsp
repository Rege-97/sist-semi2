<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
Cookie cookies[] = request.getCookies();
String rememberEmail = null;
for(int i = 0; i < cookies.length; i++){
	if(cookies[i].getName().equals("rememberMe")){
		if(cookies[i].getValue() != null) {
			rememberEmail = cookies[i].getValue();			
			break;
		}
	}
}



%>
</head>
<body onload = "checkRememberMe();">
<%@ include file="/header.jsp" %>
<fieldset>
	<form action = "signin_ok.jsp" method = "post">
		<input type="email" name = "memberEmail" placeholder="아이디(이메일)" <%=rememberEmail!=null?"value='"+rememberEmail+"'":"" %>>
		<br>
		<input type="password" name = "memberPassword" placeholder="비밀번호">
		<br>
		<input type="checkbox" id="remeberMe" name="rememberMe" <%=rememberEmail!=null?"checked":"" %>>아이디 저장
		<br>
		<input type="submit" value = "로그인">
		<br>
		<label onclick="location.href = '/semi2/member/find/id.jsp'">아이디 찾기</label>|
		<label onclick="location.href = '/semi2/member/find/password.jsp'">비밀번호 찾기</label>
		<label onclick="location.href = '/semi2/member/signup/terms.jsp'">회원가입</label>
	</form>
</fieldset>
<%@ include file="/footer.jsp" %>
</body>
</html>