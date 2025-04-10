<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="deleteDao" class="com.plick.support.DeleteDao"></jsp:useBean>>    
<%    
String id_str = request.getParameter("id");
if (id_str == null || id_str.equals("")) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	location.href = '/semi2/support/main.jsp';
</script>
<%
}
int id = Integer.parseInt(id_str);
int result = deleteDao.delete(id, "notice");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>