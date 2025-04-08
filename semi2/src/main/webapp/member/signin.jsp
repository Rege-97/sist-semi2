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
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body onload = "checkRememberMe();">
<%@ include file="/header.jsp" %>
<div class="login-box">
<div class="login-input">
	<form action = "signin_ok.jsp" method = "post">
		<input type="email" name = "memberEmail" class="login-text" placeholder="아이디(이메일)" <%=rememberEmail!=null?"value='"+rememberEmail+"'":"" %>>
		<br>
		<input type="password" name = "memberPassword" class="login-text" placeholder="비밀번호">
		<br>
		<div class="id-checkbox">
		<input type="checkbox" id="remeberMe" name="rememberMe" <%=rememberEmail!=null?"checked":"" %>><div class="id-remember">아이디 저장</div>
		</div>
<div class="login-bt-box">
		<input type="submit" value = "로그인" class="login-bt">
</div>
<div class="login-sub-box">
	<div class="login-find">
		<label onclick="location.href = '/semi2/member/find/id.jsp'">아이디 찾기</label>
		</div>
		 <div class="login-find-line"> | </div>
			<div class="login-find">
		<label onclick="location.href = '/semi2/member/find/password.jsp'">비밀번호 찾기</label>
				</div>
		<div class="login-signup">
		<label onclick="location.href = '/semi2/member/signup/terms.jsp'">회원가입</label>
		</div>
	</div>
	</form>
	</div>
	</div>
<%@ include file="/footer.jsp" %>
</body>
</html>