<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.plick.dto.MemberDto" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="memberDto" class = "com.plick.dto.MemberDto"></jsp:useBean>
<jsp:setProperty property="*" name="memberDto"/>
<jsp:useBean id="memberDao" class = "com.plick.member.MemberDao"></jsp:useBean>

<%
Calendar now = Calendar.getInstance();
memberDto.setCreatedAt(new Timestamp(now.getTimeInMillis()));
memberDto.setAccessType("listener");

int result = memberDao.addMember(memberDto);
String msg = result > 0 ? "회원가입 성공" : "오류 발생!";
%>

<script>
window.alert("<%=msg %>");
location.href = "result.jsp?name=<%=memberDto.getName() %>";
</script>