<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
File delFile = new File(request.getRealPath("resources/images/member/"+request.getParameter("memberId")+"/profile.jpg"));
String msg = delFile.delete() ? "프로필 사진 초기화":"삭제 실패" ;
%>
<script>
parent.window.alert("<%=msg %>");
</script>