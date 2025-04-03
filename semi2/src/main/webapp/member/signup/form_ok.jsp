<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.plick.dto.MemberDto" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="memberdto" class = "com.plick.dto.MemberDto" scope = "request"></jsp:useBean>
<jsp:setProperty property="*" name="memberdto"/>
<jsp:useBean id="memberdao" class = "com.plick.member.MemberDao"></jsp:useBean>

<%
Calendar now = Calendar.getInstance();
memberdto.setCreatedAt(new Timestamp(now.getTimeInMillis()));
memberdto.setAccessType("listener");

int result = memberdao.addMember(memberdto);
String msg = result > 0 ? "회원가입 성공" : "오류 발생!";
%>

<script>
window.alert("<%=msg %>");
location.href = "result.jsp?name=<%=memberdto.getName() %>";
</script>