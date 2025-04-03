<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String lastPage = request.getParameter("lastPage");
session.invalidate();
%>
<script>
window.alert("로그아웃 실행");
location.href = "/semi2/"+lastPage;
</script>