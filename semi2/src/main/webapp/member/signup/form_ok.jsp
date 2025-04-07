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
memberDto.setAccessType("listener");

int result = memberDao.addMember(memberDto);
String msg = result > 0 ? "회원가입 성공" : "오류 발생!";

int memberId = memberDao.searchId(memberDto.getEmail());
File profile = new File(request.getRealPath("resources/member/"+memberId));
profile.mkdirs();
%>

<script>
window.alert("<%=msg %>");
location.href = "result.jsp?name=<%=memberDto.getName() %>";
</script>