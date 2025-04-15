<%@page import="com.plick.signedin.SignedinDto"%>
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
	if(session.getAttribute("signedinDto")==null){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}else if(((SignedinDto) session.getAttribute("signedinDto")).getMemberId() == 0){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}
	%>

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