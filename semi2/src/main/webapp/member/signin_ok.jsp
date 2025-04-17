<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto"></jsp:useBean>
<jsp:setProperty property="*" name="signedinDto"/>	
<jsp:useBean id="signedinDao" class="com.plick.signedin.SignedinDao"></jsp:useBean>
<%
int result = signedinDao.verifySignin(signedinDto);
String msg = "";
String path = "";

switch(result){
case 0: 
	//로그인 정보 쿠키 추가
if(request.getParameter("rememberMe")!=null){
	Cookie rememberMe = new Cookie("rememberMe", signedinDto.getMemberEmail());
	rememberMe.setMaxAge(signedinDao.COOKIE_LIFE_30DAYS);
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

session.setAttribute("signedinDto", signedinDto);
msg = "로그인 성공!";
path = "/semi2/main.jsp";
break;
case 1: case 2: msg = "아이디 혹은 비밀번호가 일치하지 않습니다"; 
path =  "/semi2/member/signin.jsp";
break;
default: msg = "위험! 알 수 없는 오류 발생";
}
%>
<%
String rtm = request.getParameter("returntome");
%>
<script>
window.alert("<%=msg %>");
location.href = "<%=rtm != null ? rtm : "/semi2/main.jsp" %>";
</script>