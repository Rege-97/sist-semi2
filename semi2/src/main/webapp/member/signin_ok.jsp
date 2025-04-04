<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="memberDto" class="com.plick.dto.MemberDto" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="memberDto"/>	
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>
<%
int result = memberDao.verifySignin(memberDto);
String msg = "";
String path = "";

switch(result){
case 0: 
if(request.getParameter("rememberMe")!=null){
	Cookie rememberMe = new Cookie("rememberMe", memberDto.getEmail());
	rememberMe.setMaxAge(memberDao.COOKIE_LIFE_30DAYS);
	response.addCookie(rememberMe);
}else{
	Cookie cookies[] = request.getCookies();
	for(int i = 0; i < cookies.length; i++){
		if(cookies[i].getName().equals("rememberMe")){
			cookies[i].setMaxAge(0);
			response.addCookie(cookies[i]);
		}
	}
}
msg = "로그인 성공!";
path = "/semi2/main.jsp";
break;
case 1: case 2: msg = "아이디 혹은 비밀번호가 일치하지 않습니다"; 
path =  "/semi2/member/signin.jsp";
break;
default: msg = "위험! 알 수 없는 오류 발생";
}
%>
<script>
window.alert("<%=msg %>");
location.href = "<%=path %>";
</script>