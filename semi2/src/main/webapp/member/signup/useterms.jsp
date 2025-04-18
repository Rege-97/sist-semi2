<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
try{
	BufferedReader br = new BufferedReader(new FileReader(request.getRealPath("/resources/texts/term/terms.txt")));
	String terms = null;

%>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body class="useterms">

<%
	while((terms = br.readLine()) !=null){
		%>
		<%=terms %>
		<br>
		<%
	}
}catch(Exception e){
	e.printStackTrace();
}
%>

</body>
</html>