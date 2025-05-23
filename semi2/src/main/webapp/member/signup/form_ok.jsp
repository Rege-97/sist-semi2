<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.io.File" %>
<%@ page import="com.plick.member.MemberDto" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="memberDto" class = "com.plick.member.MemberDto"></jsp:useBean>
<jsp:setProperty property="*" name="memberDto"/>
<jsp:useBean id="memberDao" class = "com.plick.member.MemberDao"></jsp:useBean>

<%
//컨트롤러 페이지에서 2차 검증 시도
String msg = "여러 명이 동시에 회원가입을 시도하고 있습니다. 다시 시도해주세요.";
if (memberDao.checkEmailDuplicate(request.getParameter("email")) < 0 || memberDao.checkEmailDuplicate(request.getParameter("nickname")) < 0){
%>
<script>
window.alert("<%=msg %>");
location.href = "result.jsp?name=<%=memberDto.getName() %>";
</script>
<%	
}else{

	memberDto.setAccessType("listener");
	
	int result = memberDao.addMember(memberDto);
	msg = result > 0 ? "" : "여러 명이 동시에 회원가입을 시도하고 있습니다. 다시 시도해주세요.";
	
	int memberId = memberDao.searchId(memberDto.getEmail());
	System.out.println(memberId+"memberId");
	File profile = new File(request.getRealPath("resources/images/member/"+memberId));
	profile.mkdirs();
%>
<script>
if("<%=msg%>"!=""){
	window.alert("<%=msg%>");
	location.href = "/semi2/main.jsp";
}else{
	location.href = "result.jsp?name=<%=memberDto.getName() %>";
}
</script>	
<%
}
%>

