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
String msg = "동시 접속자 수가 너무 많습니다. 다시 시도해주세요.";
if (memberDao.checkEmailDuplicate(request.getParameter("email")) < 0 || memberDao.checkEmailDuplicate(request.getParameter("nickname")) < 0){
}else{

	memberDto.setAccessType("listener");
	
	int result = memberDao.addMember(memberDto);
	msg = result > 0 ? "회원가입 성공" : "오류 발생!";
	
	int memberId = memberDao.searchId(memberDto.getEmail());
	System.out.println(memberId+"memberId");
	File profile = new File(request.getRealPath("resources/images/member/"+memberId));
	profile.mkdirs();
}
%>

<script>
window.alert("<%=msg %>");
location.href = "result.jsp?name=<%=memberDto.getName() %>";
</script>